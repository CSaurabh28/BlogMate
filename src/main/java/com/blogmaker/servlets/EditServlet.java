package com.blogmaker.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.blogmaker.dao.UserDao;
import com.blogmaker.entities.FileHelper;
import com.blogmaker.entities.user;
import com.blogmaker.helper.ConnectionProvider;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name=request.getParameter("name");
		String mobile=request.getParameter("mobile");
		String email=request.getParameter("email");
	
		Part part=request.getPart("profile");
		String imageName=part.getSubmittedFileName();
		
		HttpSession s=request.getSession();
		user u=(user)s.getAttribute("currentuser");
		u.setName(name);
		u.setMobile(mobile);
		u.setEmail(email);
		u.setProfile(imageName);
		
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		boolean ans=dao.updateUser(u);
		PrintWriter out=response.getWriter();
		if(ans) {
			out.println("Updated");
			
			String path=request.getServletContext().getRealPath("/")+"upload"+File.separator+u.getProfile();
			FileHelper.deleteFile(path);
			if(FileHelper.saveFile(part.getInputStream(), path))
			{
				out.println("profile update");
			}else
			{
				out.println("profile not  update");
			}
			response.sendRedirect("profile.jsp");
		}
		else {
			out.println("Errors");
			
		}
		
		
	}

}
