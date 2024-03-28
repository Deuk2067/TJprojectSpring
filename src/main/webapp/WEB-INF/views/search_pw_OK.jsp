<%@page import="com.tjoeun.Tjproject.VO.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
//	out.println(id + " " + name + " " + email);
	
	MemberVO vo = new MemberVO();
	vo.setId(id);
	vo.setName(name);
	vo.setEmail(email);
//	out.println(vo);
	
	
	int search_pw_check = (int) request.getAttribute("search_pw_check");
	MemberVO search_pw= (MemberVO) request.getAttribute("search_pw");
//	out.println(search_pw.getPw() + "/" + search_pw_check);

	int backPage = 1;
	out.println("<script>");
	try {
		 backPage = Integer.parseInt(request.getParameter("backPage")) ;
//	out.println(backPage);
		if (search_pw_check == 1) {
			out.println("alert('" + vo.getName() + "의 비밀번호는 " + search_pw.getPw() + "입니다.')");
			out.println("location.href='login?backPage=" + backPage + "'");
		} else {
			out.println("alert('입력 정보 확인 바랍니다.')");
			out.println("location.href='search_pw'");
		}
	} catch (NumberFormatException e) {
//		out.println("alert('예외 발생')");
		if (search_pw_check == 1) {
			out.println("alert('" + vo.getName() + "의 비밀번호는 " + search_pw.getPw() + "입니다.')");
			out.println("location.href='login?backPage=1'");
		} else {
			out.println("alert('입력 정보 확인 바랍니다.')");
			out.println("location.href='search_pw'");
		}
	}
	out.println("</script>");
	
	
	
%>

</body>
</html>