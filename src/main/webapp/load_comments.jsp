<%@page import="com.blogmaker.entities.user"%>
<%@page import="com.blogmaker.entities.Comments"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blogmaker.helper.ConnectionProvider"%>
<%@page import="com.blogmaker.dao.CommentDao"%>
<%@include file="head.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comment Page</title>
     <style>
        #comment-list {
            max-height: 400px;
            overflow-y: auto;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .card-title img {
            border-radius: 50%;
            height: 50px;
            width: 50px;
        }
        .card-title a {
            font-weight: 100;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h3 class="mb-4">Comments</h3>
        <%
        int pid = Integer.parseInt(request.getParameter("pid"));
        CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());
        ArrayList<Comments> comments = cdao.getCommentByPostId(pid);
        %>
        <!-- Comment List -->
        <div id="comment-list" class="card mb-3">
            <% for (Comments c : comments) {
                user user = cdao.getUserByUid(c.getUid());
            %>
                <div class="card-body">
                    <h6 class="card-title">
                        <img class="img-fluid" src="upload/<%= user.getProfile() %>">
                        <a href="#"><%= user.getName() %></a>
                    </h6>
                    <h6 class="card-subtitle text-muted">Posted on: <%= c.getComdate() %></h6>
                    <p class="card-text"><%= c.getComment() %></p>
                </div>
                <hr>
            <% } %>
        </div>
    </div>
    
</body>
</html>
