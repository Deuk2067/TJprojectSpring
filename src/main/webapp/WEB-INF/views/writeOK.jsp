<%@page import="com.tjoeun.Tjproject.VO.MainVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>저장하기 1</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	String category = request.getParameter("category");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String id = (String) session.getAttribute("loginInfoID");
//	out.println("id : "+id +"/");
//	out.println("content : "+content+"/");
//	out.println("subject :"+subject+"/");
//	out.println("category :"+category+"/");
	
	MainVO vo = new MainVO();
	vo.setId(id);
	vo.setSubject(subject);
	vo.setContent(content);	
	vo.setCategory(category);
//	out.println("writeOK - vo : " + vo);

    if (category.equals("카테고리 입력")) { 
         out.println("<script>");
         out.println("alert('카테고리를 입력하세요')");
         out.println("location.href='./write'");
         out.println("</script>");
    
    } else if (subject == null || subject.trim().equals("")) {
    	 out.println("<script>");
         out.println("alert('제목을 입력하세요')");
         out.println("location.href='./write'");
         out.println("</script>");
    
    	
    } else if (content == null || content.trim().equals("")) {
    	 out.println("<script>");
         out.println("alert('내용을 입력하세요')");
         out.println("location.href='./write'");
         out.println("</script>");
    
    }
%>

</body>
</html>
