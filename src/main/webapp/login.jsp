<%@page import="com.blogmaker.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="head.jsp" %>
    <%@page import="java.sql.*" %>
    <%@include file="navbar.jsp" %>
    <%@page import="com.blogmaker.helper.ConnectionProvider"%>
    <%
    	Message msg=(Message)session.getAttribute("msg");
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Blogmate</title>
</head>
<body>
	<div class="container " style="margin:60px;">
		<div class="row justify-content-center " >
			<div class="col-md-6">
				<div class="card primary-background1">
					<div class="card-header text-white">
						<p><span class="fa fa-user-circle-o"></span> Login here</p>
						
						  <%if(msg!=null)
						  	{
						  %>
						  <div class="alert <%=msg.getCssclass() %>" role="alert">
						  		<%=msg.getContent() %>
							</div>
							<%
								session.removeAttribute("msg");
						  		}
							%>
					</div>
					<div class="card-body text-white">
						<form action="LoginServlet" method="post" >
							  <div class="form-group">
							    <label for="exampleInputEmail1">Email address</label>
							    <input type="email" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
							    
							  </div>
							  <div class="form-group">
							    <label for="exampleInputPassword1">Password</label>
							    <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
							  </div>
							 
							  <div class="text-center">
							  <button type="submit" class="btn btn-light  ">Submit</button>
							  </div>
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp" %>
</body>
</html>