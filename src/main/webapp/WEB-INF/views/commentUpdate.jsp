<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	String upcomment = request.getParameter("upcomment");
	System.out.print(upcomment);

	if(upcomment == null || upcomment.trim().equals("")) {
		int idx = Integer.parseInt(request.getParameter("voidx"));
		int comidx = Integer.parseInt(request.getParameter("comidx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		out.println("<script>");
		out.println("alert('" + comidx + "번 댓글 수정 실패')");
		out.println("location.href='read?idx=" + idx + "&currentPage=" + currentPage + "'");
		out.println("</script>");
	} else {
		int idx = Integer.parseInt(request.getParameter("voidx"));
		int comidx = Integer.parseInt(request.getParameter("comidx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		//	수정할 댓글에 수정하기 위해 원 댓글 내용 얻어옴
	//	MainCommentVO originalComment = MainCommentService.getInstance().selectByIdx(comidx);
		upcomment.replace(">", "%gt;");
		upcomment.replace("<", "%lt;");
		//originalComment.setContent(upcomment.trim());
		// System.out.println("originalComment: " + originalComment);
		
		//MainCommentService.getInstance().update(originalComment);
	
		response.sendRedirect("read?idx=" + idx + "&currentPage=" + currentPage); 	
	}
%>

</body>
</html>