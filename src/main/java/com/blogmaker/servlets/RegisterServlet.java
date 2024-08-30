package com.blogmaker.servlets;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.blogmaker.dao.UserDao;
import com.blogmaker.entities.user;
import com.blogmaker.helper.ConnectionProvider;


/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("</head>");
		out.println("<body>");
		
		String name=request.getParameter("name");
		String mobile=request.getParameter("mobile");
	
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		//Create user obj
		user u1=new user(name,mobile,email,password,null,null);
		
		//create userdao obj
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		if(dao.saveUser(u1)) {
			response.sendRedirect("login.jsp");
			
		}
		else
		{
			response.sendRedirect("register.jsp");
		}
		
		
		out.println("</body>");
		out.println("</html>");
	}

}
