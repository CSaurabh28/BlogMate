<%@page import="com.blogmaker.dao.LikedDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.blogmaker.entities.Category"%>
<%@page import="com.blogmaker.entities.Post"%>
<%@page import="com.blogmaker.entities.user"%>
<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import="com.blogmaker.dao.PostDao"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		.profile-name{
			font-weight:100;
			font-size:25px;
		}
		.post-title{
			
		}
		</style>
	<%@include file="head.jsp" %>
	<link href="css/style.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<%	//the user which is login now
    	user u2=(user)session.getAttribute("currentuser");
    	if(u2==null){
    		response.sendRedirect("login.jsp");
    	}
    %>
	<%
		//getting post id of post open now
		String postid=request.getParameter("post_id");
		int post_id=Integer.parseInt(postid);
	
			//getting post by postid means open post in full details
			PostDao dao=new PostDao(ConnectionProvider.getConnection());
			Post p=dao.getPostByPostId(post_id);
			
			//post dalne wale user ke details u me jayenge
			int uid=p.getuId();
			user u=dao.getUserByUid(uid);
			
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy"); // e.g., "Monday, July 23, 2024"
			// Get the post date as a Timestamp
		    Timestamp postTimestamp = p.getpDate(); // Assuming p.getpDate() returns Timestamp
		    // Convert Timestamp to Date
		    Date postDate = new Date(postTimestamp.getTime());
		    // Format the Date to a readable string
		    String formattedDate = dateFormat.format(postDate);
		 	 //get user which posted post details
			int uid1=p.getuId();
			user u3=dao.getUserByUid(uid1);
%>


	<!-- navbar started -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark text-white primary-background1" >
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
<!-- nav end -->
<%
	//for transfer postid to the comment table insertion of comment is done on insertcomment.jsp
	HttpSession session1=request.getSession();
	session1.setAttribute("currentpost", p);
%>
<!-- Body of page started -->
<main>
    <div class="container">
        <div class="row mt-4">
            
            <!-- View Single Post start -->
            <div class="col-md-7 mt-2">
                <div class="card" style="width: 100%;">
                    <div class="card-body card border-danger">
                        <h6 class="card-title profile-name ">
						    <img class="img-fluid"src="upload/<%=u.getProfile()%>" style="border-radius:50%;height:50px;width:50px">
						    <a href="#!" data-toggle="modal" data-target="#post-profile-modal"><%= u.getName()%></a>
						</h6>
						
					    <hr>
					    
					    <h3 class="card-subtitle mb-2 post-title"><%=p.getpTitle() %></h3>
                        <img class="card-img-top" src="postimg/<%= p.getpImg() %>" alt="Card image cap">
                        <p class="card-text"><%= p.getpContent() %></p>
                    </div>
                    
                    
                    <div class="card-footer primary-background1">
                        <%
			    		LikedDao ldao=new LikedDao(ConnectionProvider.getConnection());
			    		%>
			    		<!-- like button -->
				    	<a href="#!" onclick="getLike(<%=p.getpId() %>,<%=u2.getId() %>)" type="Button" class="btn btn-outline-light like-button" data-post-id="<%=p.getpId()%>">
						    <span class="fa fa-heart-o like-counter" id="like-counter-<%=p.getpId()%>"><%= ldao.countLikes(p.getpId())%></span>
						</a>
			    	
					  	<a href="#!" type="button" class="btn btn-outline-light" id="insert-comments"><span class="fa fa-comment-o"></span> Comment</a>
                        <a href="#!" type="button" class="btn btn-outline-light"><span class="fa fa-share"></span> Share</a>
                    	<span class="text-white" style="font-weight:100;font-size:15px"><%=formattedDate%></span><br>
                    	<h4><a href="#!" onclick='getComments(<%=p.getpId() %>)' class="text-white"style="font-weight:100;font-size:25px">view comments</a></h4>
                    </div>
                    
                    <div class="card-footer" id="inserted-comments">	
			    			<!-- comments will insert from here -->
			  		</div>
                </div>
            </div>
            <!-- View Single Post end -->



            <!-- Comments Section start -->
            <div class="col-md-5 mt-4">
                <div class="container pr-5" id="loader">
                    <i class="fa fa-refresh fa-2x fa-spin"></i>
                    <h5 class="mt-2">Loading...</h5>
                </div>
                <div class="container-fluid" id="view-comments">
                  
                  
                    <!-- Comments will be loaded here via AJAX -->
                    
                    
                    
                </div>
            </div>
            <!-- Comments Section end -->

        </div>
    </div>
</main>





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
				    		<!-- Profile Modal -->
				    		
				    		
				    		
				      			<!--Editmodal start  -->
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
									<!-- EditModal end -->
				      		</div>
				      
      
      
      
			      <div class="modal-footer text-center" style="padding-right:200px">
			        
			        <a href="LogoutServlet" type="button" class="btn btn-danger">Logout</a>
			         <a id="edit-profile-button" type="button" class="btn btn-success">Edit</a>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- profile modal end -->





<!--ADD post modal start -->
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
       
       
        <!-- Add post form start -->
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
				
				<!-- addpost form end here -->
      </div>
     
    </div>
  </div>
</div>
<!-- ADD post modal end -->






<!-- post pe click krne pr open profile Modal start -->
<div class="modal fade" id="post-profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
	       			<td><img src="upload/<%=u3.getProfile()%>" class="img-fluid" style="border-radius:50%;height:120px;width:130px" > </td>
	       			
	       		</tr>
	       		<tr>
	       			<td>Name:	<%=u3.getName() %></td>
	       			
	       		</tr>
	       		<tr>
	       			<td>Mobile:	<%= u3.getMobile()%></td>
	       			
	       		</tr>
	       		<tr>
	       			<td>Email:	<%=u3.getEmail() %></td>
	       			
	       		</tr>	
	       			
	       		
	       </table>
      	</div>
      			
      </div>      
    </div>
  </div>
</div>
<!--post profile modal end -->













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

	//getposts asyncronously on same page using ajax
  	function getPosts(catId,temp){
	  $("#loader").show();//firstly it will show refresh button 
	  $("#show-posts").hide();//and hide all posts
	  $(".c-link").removeClass("primary-background1");//it for click category will have color
	  $(".c-link").removeClass("text-white");
		  
	  		$.ajax({
				url:"load_post.jsp",//fetch data from load_post.jsp page to profile.jsp asynchronously
				data:{cid:catId},//show post by categoryid
						success:function(data,textstatus,jqXHR){
							console.log(data);
							$("#loader").hide();//it will hide loader
							$("#show-posts").show();//it will show posts
							$("#show-posts").html(data);//it will show posts which is coded on load_post.jsp
							$(temp).addClass("primary-background1");//it for click category will have color
							$(temp).addClass("text-white");//it for click category will have color
							
							}
					})
 	 }
	
	//Comments insertion
  	function insertComments(){
	  $('#insert-comments').click(function(){
		  $.ajax({
				url:"insertComment.jsp",
				
				success:function(data,textstatus,jqXHR){
					console.log(data);
					
					$("#inserted-comments").html(data);
					
					
					}
				})
	 	 })
	  }
  
	//Comments fetching
  function getComments(pId,temp){
	  
	  $.ajax({
			url:"load_comments.jsp",
			data:{pid:pId},
			success:function(data,textstatus,jqXHR){
				console.log(data);
				
				$("#view-comments").html(data);
				
			}
		})
  }
  
  
$(document).ready(function(e){
	let allpostref=$("c-link")[0]
	getPosts(0,allpostref);
	insertComments();
	
	
})
</script>



<!-- LIKES Counter -->
<script type="text/javascript">
				function getLike(pid, uid) {
				    console.log(pid + "," + uid);
				    const d = {
				        postid: pid,
				        userid: uid,
				        operation: "like"
				    };
				
				    $.ajax({
				        url: "LikeServlet",
				        type: 'GET',
				        data: d,
				        success: function(data, textStatus, jqXHR) {
				            console.log(data);
				            let likeCounter = $("#like-counter-" + pid);
				            let count = parseInt(likeCounter.html());
				            if (data.trim() == 'true') {
				                count++;
				            } else {
				                count--;
				            }
				            likeCounter.html(count);
				        },
				        error: function(jqXHR, textStatus, errorThrown) {
				            console.log(errorThrown);
				        }
				    });
				}

			  
			 
			  </script>
	

<%@include file="footer.jsp" %>
</body>
</html>

