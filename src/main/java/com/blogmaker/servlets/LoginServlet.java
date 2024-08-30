package com.blogmaker.servlets;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import com.blogmaker.dao.UserDao;
import com.blogmaker.entities.Message;
import com.blogmaker.entities.user;
import com.blogmaker.helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("</head>");
		out.println("<body>");
		
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		user u2=dao.getUserByEmailAndPassword(email, password);
		if(u2==null)
		{
			Message msg=new Message("Invalid Details","error","alert-danger");
			HttpSession s=request.getSession();
			s.setAttribute("msg",msg);
			response.sendRedirect("login.jsp");
		}
		else {
			HttpSession s=request.getSession();
			s.setAttribute("currentuser", u2);
			response.sendRedirect("profile.jsp");
		}
	
		
		
		out.println("</body>");
		out.println("</html>");
	}

}
