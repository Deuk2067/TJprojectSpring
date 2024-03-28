<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");

	session.removeAttribute("loginCheck");
	session.removeAttribute("loginInfoID");
	session.removeAttribute("loginInfoPW");
	
	// MainList list = MainService.getInstance().selectList(1);
	// int total = list.getTotalPage();
	
	// System.out.println(total);
	
	int backPage = Integer.parseInt(request.getParameter("backPage"));

	out.println("<script>");
	try {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		out.println("location.href='goBack?backPage=" + backPage + "&idx=" + idx + "&currentPage=" + currentPage + "'");
	} catch (NumberFormatException e) {
		
		out.println("location.href='goBack?backPage=" + backPage + "'");
	}
	out.println(backPage);
	
	out.println("</script>");
	
	
%>
 


</body>
</html>