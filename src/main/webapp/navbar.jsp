<%@page import="java.util.ArrayList"%>
<%@page import="com.blogmaker.entities.Category"%>
<%@page import="com.blogmaker.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="head.jsp" %>
    <%@page import="java.sql.*" %>
    <%@page import="com.blogmaker.helper.ConnectionProvider" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BlogMaker</title>
<link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
		<!-- navbar start -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-danger text-white primary-background1" >
  <a class="navbar-brand" href="#">BlogMate</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
     
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        	
        	<!-- Dynamically fetching categories -->
        					<%
								PostDao dao=new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> cat=dao.getCategories();
								for(Category c:cat)
								{
							%>
									<a onclick="getPosts(<%=c.getCid()%>,this)"class=" c-link dropdown-item primary-background1" href="#"><%=c.getCname() %></a>
							<% 
								}
							
							%>
         
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link " href="register.jsp">Register</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="login.jsp">login</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>


<script>
			function getPosts(catId,temp){
					  $("#loader").show();
					  $("#show-posts").hide();
					  $(".c-link").removeClass("primary-background1");
					  $(".c-link").removeClass("text-white");
					  $.ajax({
							url:"load_post.jsp",
							data:{cid:catId},
							success:function(data,textstatus,jqXHR){
								console.log(data);
								$("#loader").hide();
								$("#show-posts").show();
								$("#show-posts").html(data);
								$(temp).addClass("primary-background1");
								$(temp).addClass("text-white");
								
							}
						})
				  }
				$(document).ready(function(e){
					let allpostref=$("c-link")[0]
					getPosts(0,allpostref)
				})
		</script>


</body>
</html>