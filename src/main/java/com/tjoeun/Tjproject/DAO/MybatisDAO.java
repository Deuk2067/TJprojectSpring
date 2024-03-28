package com.tjoeun.Tjproject.DAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.tjoeun.Tjproject.VO.MainCommentList;
import com.tjoeun.Tjproject.VO.MainCommentVO;
import com.tjoeun.Tjproject.VO.MainList;
import com.tjoeun.Tjproject.VO.MainVO;
import com.tjoeun.Tjproject.VO.MemberVO;
import com.tjoeun.Tjproject.VO.Param;

public interface MybatisDAO {

//	mapper로 사용할 인터페이스의 추상 메소드 형식은 다음과 같다.
//	public abstract 리턴타입 메소드이름(인수); // 추상 메소드 형식
//	<select id="select" parameterType="" resultType="">// sql 명령을 실행하는 xml 파일의 태그
//	public abstract resultType id(parameterType); // mapper 추상 메소드 형식
	
//	추상 메소드 이름이 xml파일의 실행할 sql 명령을 식별하는 id로 사용되고 리턴 타입이 resultType으로 
//	사용되고 parameterType이 메소드로 전달되는 인수로 사용된다.
	
	int selectCount();

	ArrayList<MainVO> selectList(HashMap<String, Integer> hmap);

	void increment(int idx);

	MainVO selectByIdx(int idx);

	ArrayList<MainVO> selectHit();

	ArrayList<MainVO> selectGood();

	ArrayList<MainVO> selectNew();

	int login(MemberVO vo);

	MemberVO search_pw(MemberVO vo);
	
	int search_pw_check(MemberVO vo);

	int registerProcess(String id);

	void insertRegister(MemberVO vo);

	void write(MainVO mainVO);

	MainCommentList selectList(int idx);

	void update(MainVO mainVO);

	void delete(int idx);

	MainList selectSearchList(int currentPage, String searchTag, String category, String searchVal);

	int selectCountsearch(Param param);

	ArrayList<MainVO> selectListsearch(Param param);

	int selectCount1(Param param);

	ArrayList<MainVO> selectList1(Param param);

	void insertComment(MainCommentVO mainCommentVO);

	ArrayList<MainCommentVO> selectCommentList(int idx);

	MainCommentVO selectByIdxCo(int comidx);

	void updateCo(MainCommentVO originalComment);

	void deleteCommentCheck(int comidx);

	
	
}
