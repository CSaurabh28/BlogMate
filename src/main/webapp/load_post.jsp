

<%@page import="com.blogmaker.dao.LikedDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.blogmaker.entities.user"%>
<%@page import="com.blogmaker.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import="com.blogmaker.dao.PostDao"%>
	
	<%
		/* user who is login now */
		user u2=(user)session.getAttribute("currentuser");
    	if(u2==null){
    		response.sendRedirect("login.jsp");
    	}
		
		Thread.sleep(500);
		
			/* category section start */
			ArrayList<Post>list=null;
			PostDao dao=new PostDao(ConnectionProvider.getConnection());
			/*fetching category id from getPost() method  */	
			int catid=Integer.parseInt(request.getParameter("cid"));
			/*showing posts by category  */
			if(catid==0){
				list=dao.getAllPosts();
			}
			else{
				list=dao.getPostByCategories(catid);
			}
			  	if(list.size()==0){
					out.println("<h5 class='display-3 text-center'>This Category has No posts</h5>");
					return;
			  	} 
			 /* category section end*/
			  	
	  	 SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy"); // e.g., "Monday, July 23, 2024"
	for(Post p:list){
					//get user which posted post details
					int uid=p.getuId();
					user u=dao.getUserByUid(uid);
				
				// Get the post date as a Timestamp
		        Timestamp postTimestamp = p.getpDate(); // Assuming p.getpDate() returns Timestamp
		        // Convert Timestamp to Date
		        Date postDate = new Date(postTimestamp.getTime());
		        // Format the Date to a readable string
		        String formattedDate = dateFormat.format(postDate);
		
	%>
	<!DOCTYPE div PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
		<head>
		<link href="css/style.css" rel="stylesheet" type="text/css"/>
		<%@include file="head.jsp" %>
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

		</style>
		</head>
		
	<!-- post in cards -->	
	<div class="col-md-8 mt-4">
		<div class="card" style="width: 30rem;">
					
			  <div class="card-body card border-danger" style="card-border:40px">
			  	
			    <h6 class="card-title profile-name ">
			    <img class="img-fluid"src="upload/<%=u.getProfile()%>" style="border-radius:50%;height:50px;width:50px">
			     <a href="#!" data-toggle="modal" data-target="#post-profile-modal"><%= u.getName()%></a>
			    </h6>
			    <hr>
			    <h3 class="card-subtitle mb-2 post-title"><%=p.getpTitle() %></h3>
			   	 <img class="card-img-top" src="postimg/<%=p.getpImg() %>" alt="Card image cap">
			   	<hr>
			    <p class="card-text">
                <%
                    String content = p.getpContent();
                    int maxLength = 150; // maximum number of characters to show
                    if (content.length() > maxLength) {
                        out.print(content.substring(0, maxLength) + "...");
                        %><a href="show_blog_page.jsp?post_id=<%=p.getpId() %>">Read more</a><%
                    } else {
                        out.print(content);
                    }
                %>
            </p>
        </div>
			    <div class="card-footer primary-background1 ">
			    
			    	<%
			    		LikedDao ldao=new LikedDao(ConnectionProvider.getConnection());
			    		
			    	%>
						<a href="#!" onclick="getLike(<%=p.getpId() %>,<%=u2.getId() %>)" type="Button" class="btn btn-outline-light like-button" data-post-id="<%=p.getpId()%>">
	    					<span class="fa fa-heart-o like-counter" id="like-counter-<%=p.getpId()%>"><%= ldao.countLikes(p.getpId())%></span>
						</a>
 						<a href="#!" onclick="getComment()" type="button" class="btn btn-outline-light" id="add-comments"><span class="fa fa-comment-o"></span> Comment</a>
                        <a href="show_blog_page.jsp?post_id=<%=p.getpId() %>" type="Button" class="btn btn-outline-light"><span class="fa fa-share"></span>share</a>
					<span class="text-white" style="font-weight:100;font-size:15px"><%=formattedDate %></span>			
				</div>
				<div class="card-footer" id="post-comment">	
			    
			  	</div>
			  </div>
			  
			
			  
			
			  
			  
		</div>
	
	 <!-- JAVASCRIPT -->
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
			  
			  <!--insert comment  -->
			  <script type="text/javascript">
			  function getComment(){
				  $('#add-comments').click(function(){
					  $.ajax({
							url:"insertComment.jsp",
							
							success:function(data,textstatus,jqXHR){
								console.log(data);
								
								$("#post-comment").html(data);
								
								
							}
						})
				  })
			  	$(document).ready(function(e){
					
					
				})
			  </script>	
	</html>
	<%	
	}
	%>
	
	