package com.blogmaker.helper;

import java.sql.*;

public class ConnectionProvider {
	public static Connection con;
	
	public static Connection getConnection(){
		if(con==null)
		{
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/blogmaker","root","root");
				
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		return con;
	}
	
	
}
