<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="head.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<form  class="form-group" action="CommentServlet" method="post" id="commentForm">
                <div class="form-group">
                    <label for="commentText">Add a comment:</label>
                    <textarea name="comment" class="form-control" id="commentText" rows="3" placeholder="Write your comment here..."></textarea>
                </div>
                <button type="submit"  class="btn btn-primary">Submit</button>
            </form>

</body>
</html>