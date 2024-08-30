package com.blogmaker.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.blogmaker.dao.LikedDao;
import com.blogmaker.helper.ConnectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		PrintWriter out=response.getWriter();
		String operation=request.getParameter("operation");
		int pid=Integer.parseInt(request.getParameter("postid"));
		int uid=Integer.parseInt(request.getParameter("userid"));
		
		LikedDao ldao=new LikedDao(ConnectionProvider.getConnection());
		boolean islike=ldao.isLikedByUser(pid, uid);
		if(operation.equals("like")) {
			if(!islike)
			{
				boolean f=ldao.insertLike(pid, uid);
				out.println(f);
				
			}
			else {
				boolean del;
				del=ldao.disLikedByUser(pid, uid);
				if(del) {
					response.getWriter().write("alreadyLiked");
				}
				
				
			
				
				
			}
			
			
		}
		
	}

}
