<%@page import="com.blogmaker.entities.Category"%>
<%@page import="com.blogmaker.dao.LikedDao"%>
<%@page import= "java.sql.Timestamp"%>
<%@page import= "java.text.DateFormat"%>
<%@page import= "java.util.Date"%>
<%@page import= "java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@include file="head.jsp" %>

<%@page import="com.blogmaker.entities.user"%>
<%@page import="com.blogmaker.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import="com.blogmaker.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    /* user who is login now */
    user u2=(user)session.getAttribute("currentuser");
    if(u2==null){
    	response.sendRedirect("login.jsp");
    }

    
    %>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blogmate</title>

<link href="css/style.css" rel="stylesheet" type="text/css"/>

<style type="text/css">
.profile-name{
font-weight:100;
font-size:25px;
}
/* Add this to your CSS file */
#clicked-like {
background-color: blue; /* Change to your desired color */
border-color: red; /* Ensure the border matches the new background color */
color: white; /* Ensure the text color contrasts with the background color */
}
.card {
    margin-bottom: 1.5rem; /* Adjust spacing between cards */
}

.card-img-top {
    object-fit: cover; /* Ensure the image covers the area without distortion */
}


</style>
</head>
<body>
<!-- NAVBAR STARTED -->
<nav class="navbar navbar-expand-lg navbar-dark bg-danger text-white primary-background1" >
  <a class="navbar-brand" href="index.jsp">BlogMate</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="profile.jsp">Home <span class="sr-only">(current)</span></a>
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
        <a class="nav-link " href="#">Contact us</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="#">about</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal" >Add post</a>
      </li>
    </ul>
	<ul class="navbar-nav mr-right">
		<li class="nav-item">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle-o pr-2"></span><%=u2.getName() %></a>
      	</li>
		<li class="nav-item">
        	<a class="nav-link" href="LogoutServlet"><span class="fa fa-share-square pr-2"></span>logout</a>
      	</li>
      
	</ul>
  </div>
</nav>
<!-- NAVBAR end -->
<div class="container">
<!-- PROFILE-1 NAME AND PHOTO STARTED -->
<div class="row mt-3">
      <div class="col-lg-4">
        <div class="card card border-danger mb-4">
          <div class="card-body text-center">
            <img src="upload/<%=u2.getProfile()%>"
              class=" img-fluid" style="width: 200px;">
            <h5 class="my-3"><%=u2.getName() %></h5>
            <p class="text-muted mb-1">Full Stack Developer</p>
            <p class="text-muted mb-4">Bay Area, San Francisco, CA</p>
            <div class="d-flex justify-content-center mb-2">
              <a href='LogoutServlet'  type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-danger">LOGOUT</a>
              
            </div>
          </div>
        </div>
        </div>
        
        
         <!-- PROFILE-2 NAME AND OTHER -->
		<div class="col-lg-8 mt-4">
        <div class="card card border-danger mb-4">
          <div class="card-body">
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Full Name</p>
              </div>
              <div class="col-sm-9">
                <p class=" mb-0"><%=u2.getName() %></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Email</p>
              </div>
              <div class="col-sm-9">
                <p class=" mb-0"><%=u2.getEmail() %></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Phone</p>
              </div>
              <div class="col-sm-9">
                <p class=" mb-0"><%=u2.getMobile() %></p>
              </div>
            </div>
            <hr>
            <div class="row">
              <div class="col-sm-3">
                <p class="mb-0">Date</p>
              </div>
              <div class="col-sm-9">
                <p class=" mb-0"><%=u2.getRdate()%></p>
              </div>
            </div>
            <hr>
            
          </div>
        </div>
        
        
        </div>
       <!-- PROFILE-1 NAME AND PHOTO ENDED -->
		
		
<div class="row ">
            <div class="col-md-12 text-center" style="padding-left:400px">
                <h3 style="font-weight:100"> Your Posts</h3>
                <hr>
                
            </div>
        </div>


	<div class="row ">

<%

PostDao pdao=new PostDao(ConnectionProvider.getConnection());
ArrayList<Post> list=pdao.getPostByUser(u2.getId());


for(Post p:list){
	
				//get user which posted post details
				int uid=p.getuId();
				user u=pdao.getUserByUid(uid);
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// Get the post date as a Timestamp
			Timestamp postTimestamp = p.getpDate(); // Assuming p.getpDate() returns Timestamp
			// Convert Timestamp to Date
			Date postDate = new Date(postTimestamp.getTime());
			// Format the Date to a readable string
			String formattedDate = dateFormat.format(postDate);
			
			%>


<!-- USER POSTS STARTS -->

 <!-- USER POSTS STARTS -->
        <div class="col-md-4 mb-4">
            <div class="card" style="width:100%; height:100%;">
                <div class="card-body card border-danger">
                    <h6 class="card-title profile-name">
                        <img class="img-fluid" src="upload/<%= u.getProfile() %>" style="border-radius:50%; height:50px; width:50px;">
                        <a href="#!" data-toggle="modal" data-target="#post-profile-modal"><%= u.getName() %></a>
                    </h6>
                    <hr>
                    <h3 class="card-subtitle mb-2 post-title"><%= p.getpTitle() %></h3>
                    <img class="card-img-top" src="postimg/<%= p.getpImg() %>" alt="Card image cap" style="height:155px; width:100%;">
                    <hr>
                    <p class="card-text">
                        <% 
                        String content = p.getpContent();
                        int maxLength = 150; // maximum number of characters to show
                        if (content.length() > maxLength) {
                            out.print(content.substring(0, maxLength) + "...");
                        %>
                        <a href="show_blog_page.jsp?post_id=<%= p.getpId() %>">Read more</a>
                        <% 
                        } else {
                            out.print(content);
                        }
                        %>
                    </p>
                </div>
                <div class="card-footer primary-background1 text-center">
                    <% 
                    LikedDao ldao = new LikedDao(ConnectionProvider.getConnection());
                    %>
                    <a href="#!" onclick="getLike(<%= p.getpId() %>, <%= u2.getId() %>)" type="Button" class="btn btn-outline-light">
                        <span class="fa fa-heart-o like-counter"><%= ldao.countLikes(p.getpId()) %></span>
                    </a>
                    <a href="show_blog_page.jsp?post_id=<%=p.getpId() %>" type="Button" class="btn btn-outline-light"><span class="fa fa-comment-o"></span> Comment</a>
                    <a href="show_blog_page.jsp?post_id=<%= p.getpId() %>" type="Button" class="btn btn-outline-light"><span class="fa fa-share"></span> Share</a>
                    <div class="text-center mt-2">
                        <span class="text-white" style="font-weight:100; font-size:15px"><%= formattedDate %></span>
                        <br>
                        <a href="DeletePost.jsp?post_id=<%= p.getpId() %>" type="Button" class="btn btn-outline-light"><span class="fas fa-trash-alt"></span> Delete</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- USER POST END -->
		
		
<!-- JAVASCRIPT -->
<script type="text/javascript">
function getLike( pid,uid){
	
	console.log(pid+","+uid);
	const d={
		postid:pid,
		userid:uid,
		operation:"like"
		
	}
	$.ajax({
		url:"LikeServlet",
		type:'GET',
		data:d,
		success:function(data,textStatus,jqXHR){
			console.log(data);
			if(data.trim()=='true')
				{
					let c=$(".like-counter").html();
					c++;
					$(".like-counter").html(c);
				}
				 else{
					 let c=$(".like-counter").html();
				c--;
				$(".like-counter").html(c);
			} 
		}
		,error:function(jqXHR,textStatus,errorThrown){
			console.log(data);
		}
	})
	
}
</script>		
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<%	
}
%>


</div>
</div>
</div>

</body>

</html>
<%@include file="footer.jsp" %>