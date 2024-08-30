package com.blogmaker.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.blogmaker.dao.CommentDao;
import com.blogmaker.entities.Comments;
import com.blogmaker.entities.Post;
import com.blogmaker.entities.user;
import com.blogmaker.helper.ConnectionProvider;

/**
 * Servlet implementation class CommentServlet
 */
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String comment=request.getParameter("comment");
		
		HttpSession session=request.getSession();
		Post p=(Post)session.getAttribute("currentpost");
		user u=(user)session.getAttribute("currentuser");
		Comments c=new Comments(comment,p.getpId(),u.getId(),null);
		CommentDao cdao=new CommentDao(ConnectionProvider.getConnection());
		if(cdao.insertComments(c))
		{
			Post p1=(Post)session.getAttribute("currentpost");
			response.sendRedirect("show_blog_page.jsp?post_id="+p1.getpId());
		}else {
			out.println("not inserted");
		}
	}

}
