<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import="com.blogmaker.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    
    int postid=Integer.parseInt(request.getParameter("post_id"));
	PostDao pdao=new PostDao(ConnectionProvider.getConnection());
	if(pdao.deletePostByPostId(postid))
	{
			response.sendRedirect("User_posts.jsp");
	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>