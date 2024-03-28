package com.tjoeun.Tjproject;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.tjoeun.Tjproject.DAO.MybatisDAO;
import com.tjoeun.Tjproject.VO.MainCommentList;
import com.tjoeun.Tjproject.VO.MainCommentVO;
import com.tjoeun.Tjproject.VO.MainList;
import com.tjoeun.Tjproject.VO.MainVO;
import com.tjoeun.Tjproject.VO.MemberVO;
import com.tjoeun.Tjproject.VO.Param;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired 
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "redirect: list";
	}
	
//	main에 목록 띄우기
	@RequestMapping("/list")
	public String Main(HttpServletRequest request, Model model) {
		logger.info("컨트롤러에서 Main() 실행");
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int pageSize = 10; 
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {}
		int totalCount = mapper.selectCount();
		//logger.info("totalCount: {}", totalCount);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MainList mainList = ctx.getBean("list", MainList.class);
		mainList.initMainList(pageSize, totalCount, currentPage);
		//logger.info("mainList:{}",mainList);
		
		// 1페이지 분량의 글 목록을 얻어온다. 
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", mainList.getStartNo());
		hmap.put("endNo", mainList.getEndNo());
		mainList.setList(mapper.selectList(hmap));
		//logger.info("mainList:{}",mainList);
		
		// 조회수 행킹, 추천수 랭킹, 신규글 랭킹
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		
//		logger.info("mainList:{}",mainList);
//		logger.info("selectHit:{}",selectHit);
//		logger.info("selectGood:{}",selectGood);
//		logger.info("selectNew:{}",selectNew);
		
		model.addAttribute("mainList", mainList);
		
		return "Main";
	}
	
//	Main에서 글을 클릭하면 글 1건을 가져오고 조회수를 증가시킨 후 
//	read 페이지로 이동
	@RequestMapping("/read")
	public String read(HttpServletRequest request, Model model) {
		logger.info("컨트롤러에서 read() 실행");
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		//logger.info("mainVO: {}", mainVO);
		//logger.info("currentPage: {}", currentPage);
		mapper.increment(idx);
		
//		글 한건 얻어오는 메소드 실행 selectByIdx()
		MainVO vo = mapper.selectByIdx(idx);
		//logger.info("vo: {}", vo);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// 댓글 목록 띄우기
		MainCommentList commentList = ctx.getBean("commentList", MainCommentList.class);
		commentList.setList(mapper.selectCommentList(idx));
		
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		
		logger.info("commentList: {}", commentList);
		
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		model.addAttribute("vo", vo);
		model.addAttribute("commentList", commentList);
		model.addAttribute("enter", "\r\n");
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("idx", request.getParameter("idx"));
		
		return "read";
	}
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		logger.info("컨트롤러에서 login() 실행");
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		// 오른쪽 칸에 조회수, 추천수, 신규글
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		
		return "login";
	}
	
	@RequestMapping("/loginOK")
	public String loginOK(HttpServletRequest request, Model model, MemberVO memberVO) {
		logger.info("컨트롤러에서 loginOK() 실행");
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String id = memberVO.getId();
		String password = memberVO.getPw();
		
		MemberVO vo = new MemberVO(id, password);
		
		int loginCheck = mapper.login(vo);
		HttpSession session = request.getSession();
		session.setAttribute("loginInfoID", loginCheck);
		
		//logger.info("session@@@@@@@:{}", session.getId());
		
		int backPage;
		try{
			backPage = Integer.parseInt(request.getParameter("backPage") );
		} catch (NumberFormatException e){
			backPage = 1;
		}
		model.addAttribute("id", id);
		model.addAttribute("password", password);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("idx", request.getParameter("idx"));
		model.addAttribute("loginCheck",loginCheck);
		model.addAttribute("backPage",backPage);
		
		return "loginOK";
	}
	
	@RequestMapping("/goBack")
	public String goBack(HttpServletRequest request, Model model) {
		logger.info("컨트롤러에서 goBack() 실행");
		String id = request.getParameter("loginInfoID");
		model.addAttribute("id", id);
		int backPage = 1;
		try {
			backPage = Integer.parseInt(request.getParameter("backPage"));
		} catch (NumberFormatException e) {
			backPage = 1;
		}
		
		int idx;
		try {
			idx = Integer.parseInt(request.getParameter("idx"));
		} catch (NumberFormatException e) {
			idx = 1;
		}
		
		int currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));			
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		switch (backPage) {
		case 1 : // main.jsp
			return "redirect: list";
		case 2 : // write.jsp
			return "redirect: write";
		case 3 : // read.jsp
			model.addAttribute("currentPage", request.getParameter("currentPage"));
			model.addAttribute("idx", request.getParameter("idx"));
			return "read";
		default : // main.jsp
			return "redirect: list";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, Model model, HttpSession session) {
		logger.info("컨트롤러에서 logout() 실행");
		session.invalidate(); // 로그인 상태 해제
		return "logout";
	}
	
	@RequestMapping("/search_pw")
	public String search_pw(HttpServletRequest request, Model model) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		
		return "search_pw";
	}
	
	@RequestMapping("/search_pw_OK")
	public String search_pw_OK(HttpServletRequest request, Model model) {
		
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		MemberVO vo = ctx.getBean("memberVO", MemberVO.class);
		vo.setId(id);
		vo.setName(name);
		vo.setEmail(email);
		
		MemberVO search_pw= mapper.search_pw(vo);
		int search_pw_check = mapper.search_pw_check(vo);
		
		model.addAttribute("search_pw", search_pw);
		model.addAttribute("search_pw_check", search_pw_check);
		
		return "search_pw_OK";
	}
	
	@RequestMapping("/register")
	public String register(HttpServletRequest request, Model model) {
		
		return "register";
	}
	
	@RequestMapping("/registerProcess")
	public String registerProcess(HttpServletRequest request, Model model) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String pw2 = request.getParameter("pw2");
        String name = request.getParameter("name");
        String nick = request.getParameter("nick");
        String email = request.getParameter("email");
        
        MemberVO vo = new MemberVO(id, pw, name, nick, email);
        try {
        	
//      회원 가입 아이디 중복 검사 결과
        int resultId = mapper.registerProcess(id);
		if (resultId > 0) {
			String messageType = "오류 메시지:";
	        String messageContent = "이미 존재하는 아이디입니다.";
			model.addAttribute("messageType", messageType);
			model.addAttribute("messageContent", messageContent);
			return "register";
		}
		// 비밀번호 일치 검사
		else if (!pw.equals(pw2)) {
            // 오류 메시지 설정
			String messageType = "오류 메시지:";
	        String messageContent = "비밀번호가 일치하지 않습니다.";
			model.addAttribute("messageType", messageType);
			model.addAttribute("messageContent", messageContent);
			// 회원가입 양식 페이지로 리디렉션
            return "register";
        }
		// 입력 체크
		else if (id == null || id.equals("") || 
                pw == null || pw.equals("") ||
                pw2 == null || pw2.equals("") ||
                name == null || name.equals("") ||
                nick == null || nick.equals("") ||
                email == null || email.equals("")) {
			String messageType = "오류 메시지:";
	        String messageContent = "모든 내용을 입력하세요.";
			
        	model.addAttribute("messageType", messageType);
			model.addAttribute("messageContent", messageContent);
			return "register";
        }
        
		mapper.insertRegister(vo);
        
		String messageType = "성공 메시지:";
        String messageContent = "회원가입이 완료되었습니다.";
        model.addAttribute("messageType", messageType);
		model.addAttribute("messageContent", messageContent);
		return "redirect: list";
        
        }catch (Exception e) {
        	String messageType = "오류 메시지:";
            String messageContent = "회원가입 중 오류가 발생했습니다.";
            model.addAttribute("messageType", messageType);
    		model.addAttribute("messageContent", messageContent);
    		return "register";
		}
		
	}
	
	@RequestMapping("/write")
	public String write(HttpServletRequest request, Model model) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		
		return "write";
	}
	
	@RequestMapping("/writeOK")
	public String writeOK(HttpServletRequest request, Model model, MainVO mainVO, HttpSession session) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		String category = mainVO.getCategory();
		String subject = mainVO.getSubject();
		String content = mainVO.getContent();
		String id = (String) session.getAttribute("loginInfoID");
		
		logger.info("id: {}", id);
		model.addAttribute("content", content);
		model.addAttribute("subject", subject);
		model.addAttribute("category",category);
		mainVO.setId(id);
		
		
		if (category.equals("카테고리 입력")) { 
			return "writeOK";
	    } else if (subject == null || subject.trim().equals("")) {
	    	return "writeOK";
	    } else if (content == null || content.trim().equals("")) {
	    	return "writeOK";
	    }
		logger.info("mainVO: {}", mainVO);
		mapper.write(mainVO);
		logger.info("mainVO: {}", mainVO);
		
		return "redirect: list";
	}
		
	@RequestMapping("/update")
	public String update (HttpServletRequest request, Model model) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		MainVO Mainboard = mapper.selectByIdx(idx);
		
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		
		model.addAttribute("Mainboard",Mainboard);
		model.addAttribute("idx",idx);
		model.addAttribute("currentPage",currentPage);
		
		return "readUpdateOK";
	}
	
	@RequestMapping("/updateOK")
	public String updateOK (HttpServletRequest request, Model model, MainVO mainVO) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		mapper.update(mainVO);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		
		model.addAttribute("idx",idx);
		model.addAttribute("currentPage",currentPage);
		
		return "redirect: read";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		
		model.addAttribute("idx",idx);
		model.addAttribute("currentPage",currentPage);
		
		mapper.delete(idx);
		
		return "redirect: list";
	}
	
	@RequestMapping("/search")
	public String search(HttpServletRequest request, Model model, HttpSession session) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		int currentPage;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			currentPage = 1;
		}
		
		Param param = ctx.getBean("param", Param.class);
		String searchVal = request.getParameter("searchVal"); // 검색어
		logger.info("searchVal: {}",searchVal);
		String searchTag = request.getParameter("searchTag"); // 태그(작가,제목)
		logger.info("searchTag: {}",searchTag);
		String category = request.getParameter("category");
		logger.info("category: {}",category);
		
		if (searchVal != null) { // 넘어온 검색어가 있으면 세션에 태그와 검색어를 저장
			session.setAttribute("searchTag", searchTag);
			session.setAttribute("category", category);
			searchVal = searchVal.trim().length() == 0 ? "" : searchVal;
			session.setAttribute("searchVal", searchVal);
		} else { // 검색어가 없으면 세션에 저장된 검색어와 카테고리를 읽어온다.
			searchTag = (String) session.getAttribute("searchTag");
			category = (String) session.getAttribute("category");
			searchVal = (String) session.getAttribute("searchVal");
		}
		
		MainList mainList = ctx.getBean("list", MainList.class);

		if (searchVal == null || searchVal.trim().length() == 0) {
			// 검색어가 입력되지 않은 경우 => 1 페이지로 돌아감 
			return "redirect: list";
		} else {
			// 검색어가 입력된 경우 위에서 받은 인수로 메소드 실행

			int pageSize = 10;
			param.setSearchTag(searchTag);
			param.setCategory(category);
			param.setSearchVal(searchVal);

			if (searchTag.equals("subject")) { // searchTag가 subject인 경우
				int totalCount = mapper.selectCountsearch(param);
				mainList.initMainList(pageSize, totalCount, currentPage);
				param.setStartNo(mainList.getStartNo());
				param.setEndNo(mainList.getEndNo());
				mainList.setList(mapper.selectListsearch(param));
			} else { // searchTag가 id인 경우
				int totalCount = mapper.selectCount1(param);
				mainList.initMainList(pageSize, totalCount, currentPage);
				param.setStartNo(mainList.getStartNo());
				param.setEndNo(mainList.getEndNo());
				mainList.setList(mapper.selectList1(param));
			}

		}
		MainList selectHit = ctx.getBean("selectHit", MainList.class); // 조회수 랭킹
		MainList selectGood = ctx.getBean("selectGood", MainList.class); // 추천수 랭킹
		MainList selectNew = ctx.getBean("selectNew", MainList.class); // 신규글 랭킹 
		
		selectHit.setList(mapper.selectHit());
		selectGood.setList(mapper.selectGood());
		selectNew.setList(mapper.selectNew());
		
		model.addAttribute("selectHit", selectHit);
		model.addAttribute("selectGood", selectGood);
		model.addAttribute("selectNew", selectNew);
		model.addAttribute("currentPage",currentPage);
		
		model.addAttribute("mainList", mainList);
		
		return "Main";
	}
	
	@RequestMapping("commentInsert")
	public String commentInsert(HttpServletRequest request, Model model, MainCommentVO mainCommentVO) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int gup = Integer.parseInt(request.getParameter("gup"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		mapper.insertComment(mainCommentVO);
		
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("idx",idx);
		
		return "redirect: read";
	}
	
	@RequestMapping("commentUpdate")
	public String commentUpdate(HttpServletRequest request, Model model,MainCommentVO mainCommentVO) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		
		String upcomment = request.getParameter("upcomment");
		if(upcomment == null || upcomment.trim().equals("")) {
			int idx = Integer.parseInt(request.getParameter("voidx"));
			int comidx = Integer.parseInt(request.getParameter("comidx"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			return "commentUpdate";
		} else {
			int idx = Integer.parseInt(request.getParameter("voidx"));
			int comidx = Integer.parseInt(request.getParameter("comidx"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			MainCommentVO originalComment = mapper.selectByIdxCo(comidx);
			upcomment.replace(">", "%gt;");
			upcomment.replace("<", "%lt;");
			originalComment.setContent(upcomment.trim());
			mapper.updateCo(originalComment);
			
			model.addAttribute("currentPage",currentPage);
			model.addAttribute("idx",idx);
			
			return "redirect: read";
		}
		
		
	}
	
	@RequestMapping("commentDelete")
	public String commentDelete(HttpServletRequest request, Model model,MainCommentVO mainCommentVO) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		int idx = Integer.parseInt(request.getParameter("idx"));
		int comidx = Integer.parseInt(request.getParameter("commentidx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		MainCommentVO originalComment = mapper.selectByIdxCo(comidx);
		mapper.deleteCommentCheck(comidx);
		
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("idx",idx);
		
		return "redirect: read";
	}
	
		
		
		
	
}









































