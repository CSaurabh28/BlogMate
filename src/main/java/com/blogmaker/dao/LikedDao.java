package com.blogmaker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikedDao {

	private Connection con;

	public LikedDao(Connection con) {
		super();
		this.con = con;
	}
	//it will insert like in table with user and post
	public boolean insertLike(int pid,int uid) {

		boolean f=false;
		try {
			String q="insert into liked(pid,uid)values(?,?)";
			PreparedStatement pst=con.prepareStatement(q);
			pst.setInt(1, pid);
			pst.setInt(2, uid);
			pst.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		
		return f;
		
	}
	//it will count likes on post
	public int countLikes(int pid) {
		
		int count=0;
		try {
			String q="select count(*) from Liked where pid=?";
			PreparedStatement pst=con.prepareStatement(q);
			pst.setInt(1, pid);
			
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				count=rs.getInt("count(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return count;
	}
	//it will check user is liked post or not
	public boolean isLikedByUser(int pid,int uid) {
		boolean f=false;
		try {
			String q="select * from liked where pid=? and uid=?";
			PreparedStatement pst=con.prepareStatement(q);
			pst.setInt(1, pid);
			pst.setInt(2, uid);
			
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				f=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return f;
	}
	//it will delete the like
	public boolean disLikedByUser(int pid,int uid) {
		boolean f=false;
		try {
			PreparedStatement pst=con.prepareStatement("delete from liked where pid=? and uid=?");
			pst.setInt(1, pid);
			pst.setInt(2, uid);
			pst.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return f;
		
	}
}
