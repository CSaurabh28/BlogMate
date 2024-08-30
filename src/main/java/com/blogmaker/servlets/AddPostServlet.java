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

import com.blogmaker.dao.PostDao;
import com.blogmaker.entities.FileHelper;
import com.blogmaker.entities.Post;
import com.blogmaker.entities.user;
import com.blogmaker.helper.ConnectionProvider;

/**
 * Servlet implementation class AddPostServlet
 */@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			PrintWriter out=response.getWriter();
			
			//fetch data from post form
			int cid=Integer.parseInt(request.getParameter("cid"));
			String pTitle=request.getParameter("title");
			String pContent=request.getParameter("content");
			Part part=request.getPart("img");
			String img=part.getSubmittedFileName();
			
			//get user who is posting
			HttpSession s=request.getSession();
			user u=(user)s.getAttribute("currentuser");
			
			//make a post
			Post p=new Post(pTitle,pContent,img,null,cid,u.getId());
			PostDao dao=new PostDao(ConnectionProvider.getConnection());
			if(dao.savePost(p)) {
				//upload img of post to folder postimg
				String path=request.getServletContext().getRealPath("/")+"postimg"+File.separator+part.getSubmittedFileName();
				FileHelper.saveFile(part.getInputStream(), path);
				response.sendRedirect("profile.jsp");
				
				
			}else
			{
				out.println(" not posted");
			}
			
			
		
			
	}

}
