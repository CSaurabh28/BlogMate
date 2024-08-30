<%@page import="com.blogmaker.entities.user"%>
<%@page import="com.blogmaker.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blogmaker.dao.PostDao"%>
<%@page import="com.blogmaker.dao.LikedDao"%>
<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import= "java.text.SimpleDateFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="head.jsp" %>
<%@page import="java.sql.*" %>
<%@include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BlogMate</title>
<link href="css/style.css" rel="stylesheet" type="text/css"/>
<style>
  .carousel-item {
    height: 90vh; 
    min-height: 300px;
    position: relative; /* Needed for the overlay */
  }

  .carousel-item img {
    height: 100%;
    width: 100%;
    object-fit: cover; /* This ensures the image covers the entire carousel item */
  }

  .carousel-item::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6); /* Dark overlay with 60% opacity */
    z-index: 1;
  }

  .carousel-caption {
    position: relative;
    z-index: 2;
  }
</style>
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
<!-- banner -->
<div class="container-fluid p-0 m-0">
  <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
      <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img class="d-block w-100" src="img/tiger.jpg" alt="First slide">
        <div class="carousel-caption d-none d-md-block">
		    <h1 class="display-2">This is BlogMate</h1>
		    <p>BlogMate is an all-in-one blogging platform designed to empower writers and readers alike. We provide you with the tools to create stunning blog posts, engage with a community of like-minded individuals, and discover a wide range of topics and stories.</p>
		</div>
      </div>
      <div class="carousel-item">
        <img class="d-block w-100" src="img/nature.jpg" alt="Second slide">
        <div class="carousel-caption d-none d-md-block">
		    <h1 class="display-2">This is BlogMate</h1>
		    <p>BlogMate is an all-in-one blogging platform designed to empower writers and readers alike. We provide you with the tools to create stunning blog posts, engage with a community of like-minded individuals, and discover a wide range of topics and stories.</p>
		</div>
      </div>
      <div class="carousel-item">
        <img class="d-block w-100" src="img/wc.jpg" alt="Third slide">
        <div class="carousel-caption d-none d-md-block">
		    <h1 class="display-2">This is BlogMate</h1>
		    <p>BlogMate is an all-in-one blogging platform designed to empower writers and readers alike. We provide you with the tools to create stunning blog posts, engage with a community of like-minded individuals, and discover a wide range of topics and stories.</p>
		</div>
      </div>
      <div class="carousel-item">
        <img class="d-block w-100" src="img/education.jpg" alt="Fourth slide">
        <div class="carousel-caption d-none d-md-block">
		    <h1 class="display-2">This is BlogMate</h1>
		    <p>BlogMate is an all-in-one blogging platform designed to empower writers and readers alike. We provide you with the tools to create stunning blog posts, engage with a community of like-minded individuals, and discover a wide range of topics and stories.</p>
		</div>
      </div>
      <div class="carousel-item">
        <img class="d-block w-100" src="img/politics.jpg" alt="Fifth slide">
        <div class="carousel-caption d-none d-md-block">
		    <h1 class="display-2">This is BlogMate</h1>
		    <p>BlogMate is an all-in-one blogging platform designed to empower writers and readers alike. We provide you with the tools to create stunning blog posts, engage with a community of like-minded individuals, and discover a wide range of topics and stories.</p>
		</div>
      </div>
    </div>
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>
<br>
<!-- //cards -->
<%

PostDao pdao=new PostDao(ConnectionProvider.getConnection());
ArrayList<Post> list=pdao.getAllPosts();
%>
<div class="container">
<div class="row">
<%
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
                        <a href="login.jsp">Read more</a>
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
                    <a href="#!" onclick="getLike(<%= p.getpId() %>, <%= u.getId() %>)" type="Button" class="btn btn-outline-light">
                        <span class="fa fa-heart-o like-counter"><%= ldao.countLikes(p.getpId()) %></span>
                    </a>

                    <a href="show_blog_page.jsp?post_id=<%= p.getpId() %>" type="Button" class="btn btn-outline-light"><span class="fa fa-share"></span> Share</a>
                    <%-- <div class="text-center mt-2">
                        <span class="text-white" style="font-weight:100; font-size:15px"><%=formattedDate %></span>
                        <br>
            
                    </div> --%>
                </div>
            </div>
        </div>

 
        <%} %>
        <!-- USER POST END -->
        </div>
        </div>
<%@include file="footer.jsp" %>
</body>
</html>
