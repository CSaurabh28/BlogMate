package com.blogmaker.dao;


import java.sql.*;

import com.blogmaker.entities.user;

public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		super();
		this.con = con;
	}
	
	//method to insert user
	public boolean saveUser(user u) {
		boolean f=false;
		try {
			
				//user->database
			String query="insert into register(name,mobile,email,password)values(?,?,?,?)";
			PreparedStatement psmt=this.con.prepareStatement(query);
			psmt.setString(1, u.getName());
			psmt.setString(2, u.getMobile());
			psmt.setString(3, u.getEmail());
			psmt.setString(4, u.getPassword());
			psmt.executeUpdate();
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	public user getUserByEmailAndPassword(String email,String password) {
		user u1=null;
		try {
			String q="select * from register where email=? and password=? ";
			PreparedStatement psmt=this.con.prepareStatement(q);
			psmt.setString(1, email);
			psmt.setString(2, password);
			
			ResultSet rs=psmt.executeQuery();
			if(rs.next()) {
				u1=new user();
				//fetch from db
				String name=rs.getString("name");
				//set to obj
				u1.setId(rs.getInt("id"));
				u1.setName(name);
				u1.setEmail(rs.getString("email"));
				u1.setMobile(rs.getString("mobile"));
				u1.setPassword(rs.getString("password"));
				u1.setRdate(rs.getTimestamp("rdate"));
				u1.setProfile(rs.getString("profile"));
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u1;
	}
	public boolean updateUser(user u) {
		boolean f=false;
		try {
			String q="update register set name=?,mobile=?,email=?,profile=? where id=? ";
			PreparedStatement pst=con.prepareStatement(q);
			pst.setString(1,u.getName());
			pst.setString(2,u.getMobile());
			pst.setString(3,u.getEmail());
			pst.setString(4,u.getProfile());
			pst.setInt(5,u.getId());
			
			pst.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	

}
