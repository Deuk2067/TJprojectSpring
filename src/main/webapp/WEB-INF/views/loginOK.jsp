<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.tjoeun.Tjproject.DAO.MybatisDAO"%>
<%@page import="com.tjoeun.Tjproject.VO.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="./js/mainjs.js"></script>
<title>로그인</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String) request.getAttribute("id");
	String password = (String) request.getAttribute("pw");
	
	int loginCheck = (int) request.getAttribute("loginCheck");
	
	int backPage;
	try{
		backPage = (int) request.getAttribute("backPage");
	} catch (NumberFormatException e){
		backPage = 1;
	}
	
	out.println("<script>");
	if (loginCheck != 1) {
		out.println("alert('로그인 불가')");
		out.println("location.href='./login'");
	} else {
		session.setAttribute("loginInfoID", id);
		session.setAttribute("loginInfoPW", password);
		session.setAttribute("loginCheck", loginCheck);
		out.println(backPage);
		out.println("alert('로그인 성공')");
//		out.println("alert('"+ backPage +"')");

		if (backPage == 3) {
			int idx;
			int currentPage;
			try {
				idx = Integer.parseInt(request.getParameter("idx"));
				currentPage = Integer.parseInt(request.getParameter("currentPage"));		
			} catch (NumberFormatException e){
				idx = 1;
				currentPage = 1;
			}
			session.setAttribute("idx", idx);
			session.setAttribute("currentPage", currentPage);
			out.println("location.href='./goBack?backPage=" + backPage + "&idx=" + idx + "&currentPage=" + currentPage + "'");
		} else {
			out.println("location.href='./goBack?backPage=" + backPage +"'");		
		}
	}
	out.println("</script>");
%>

</body>
</html>