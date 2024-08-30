<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.blogmaker.dao.PostDao"%>
<%@page import="java.util.*"%>
<%@page import="com.blogmaker.entities.user" %>
<%@page import="com.blogmaker.entities.Category" %>
<%@include file="head.jsp" %>
    
    
    <%//get user who is login now
    	user u2=(user)session.getAttribute("currentuser");
    	if(u2==null){
    		response.sendRedirect("login.jsp");
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<link href="css/style.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>BlogMaker</title>
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
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
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
	
		<!-- Body of page started -->
		<main>
		<div class="container">
			<div class="row mt-4">
				
				<div class="col-md-4">
					
					
					<!-- Categories STARTED -->
					
					<div class="list-group">
						  <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action primary-background1 text-white">
						    All posts
						  </a>
						 	 	<% 
						 		 for(Category c:cat)
								{
								%>
									<a href="#" onclick="getPosts(<%=c.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%=c.getCname() %></a>
									
								<% 
								}
								%>
						  
					</div>
				</div>
				<!-- CATEGORIES ENDED -->
				
				
				<!-- POSTS STARTED -->
				<div class="col-md-8">
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-2x fa-spin"></i>
						<h5 class="mt-2">Loading..</h5>	
					</div>
					<div class="container-fluid" id="show-posts">
						<!-- POSTS WILL DYNAMICALLY FETCHED HERE BY AJAX FROM LOAD_POST.JSP PAGE -->
					</div>
						
				
				</div>
			</div>
		</div>
		
		</main>
	<!-- Body of page ended -->



<!--modal start  -->



<!-- profile Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background1 text-white " style="padding-left:200px">
      	
      		<h5 class="modal-title" style="text-align:centre;" id="exampleModalLongTitle"><span class="fa fa-user-circle-o pr-2"></span>Profile</h5>
      	
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div id="profile-details">
      	 <table class="table text-center" >
       		<tr>
       			<td><img src="upload/<%=u2.getProfile()%>" class="img-fluid" style="border-radius:50%;height:120px;width:130px" > </td>
       			
       		</tr>
       		<tr>
       			<td>Name:	<%=u2.getName() %></td>
       			
       		</tr>
       		<tr>
       			<td>Mobile:	<%= u2.getMobile()%></td>
       			
       		</tr>
       		<tr>
       			<td>Email:	<%=u2.getEmail() %></td>
       			
       		</tr>	
       		<tr>
       			<td>Date:	<%=u2.getRdate() %></td>
       			
       		</tr>	
       		
       	</table>
      </div>
      			<!--EDIT MODAL STARTED  -->
				<div id="edit-profile-details" style="display:none;">
				<form action="EditServlet" method="post" enctype="multipart/form-data">
				<table class="table">
					<tr>
					<td>Upload profile: </td>
					<td><input type="file" name="profile" value="<%=u2.getProfile()%>"></td>
					</tr>
					<tr>
					<td>Id: </td>
					<td><%=u2.getId()%></td>
					</tr>
					<tr>
					<td>Name: </td>
					<td><input type="text" name="name" value="<%=u2.getName()%>"></td>
					</tr>
					<tr>
					<td>Mobile: </td>
					<td><input type="text" name="mobile" value="<%=u2.getMobile()%>"></td>
					</tr>
					<tr>
					<td>Email: </td>
					<td><input type="text" name="email" value="<%=u2.getEmail()%>"></td>
					</tr>
					<tr>
					<td>Date: </td>
					<td><%=u2.getRdate()%></td>
					</tr>
					
				</table>
				<div class="text-center">
					
					<Button class="btn btn-outline-primary" type="submit" >SAVE</Button>
					</div>
				</form>
				</div>
				<!-- EDITMODAL ENDED -->
      </div>
      
      
      
      	<!-- FOOTER OF PROFILE -->
      	<div class="modal-footer text-center" style="padding-right:200px">
        
	        <a href="User_posts.jsp" type="button" class="btn btn-danger">View Full Profile</a>
	        <a id="edit-profile-button" type="button" class="btn btn-success">Edit</a>
	         
     	</div>
    </div>
  </div>
</div>
<!-- PROFILE MODAL ENDED -->

<!-- ADD POST MODAL STARTED -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background1 text-white">
        <h5 class="modal-title" id="exampleModalLabel">Add Your Post</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- ADDPOST FORM STARTED -->
        <div id="add-post-detail" >
				<form class="form-control" action="AddPostServlet" method="post" enctype="multipart/form-data">
					<table class="table">
						<div class="text-center">
							<tr >
							<select name="cid" class="form-control">
							<option selected disabled> --Select Categories--</option>
							<!-- Dynamically fetching categories -->
							<%
								
								for(Category c1:cat){
									%>
										<option value="<%=c1.getCid()%>"> <%=c1.getCname() %></option>
									<% 
								}
							
							%>
							</select>
						</tr>
						</div>
						
						<tr>
						<td>Title: </td>
						<td><input type="text" name="title" ></td>
						</tr>
						<tr>
						<td>Content: </td>
						<td><textarea name="content"> </textarea></td>
						</tr>
						<tr>
						<td>Upload Image: </td>
						<td><input type="file" name="img" ></td>
						</tr>
						<tr>
						
					</table>
				
						<div class="text-center">
							<Button class="btn btn-outline-primary" type="submit" >POST</Button>
						</div>
				</form>
				</div>
				
				<!-- ADDPOST FORM END  HERE -->
      </div>
     
    </div>
  </div>
</div>
<!--ADD POST MODAL ENDED -->












 <script >
		$(document).ready(function(){
			
			let editStatus=false;
			
			$("#edit-profile-button").click(function(){
				
				if(editStatus==false)
				{
					$("#profile-details").hide()
					$("#edit-profile-details").show()
					editStatus==true;
					
				
				}
				else{
					$("#profile-details").show()
					$("#edit-profile-details").hide()
					editStatus==false;
					
				}
			})
		})
</script> 


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



<%@include file="footer.jsp" %>
</body>
</html>