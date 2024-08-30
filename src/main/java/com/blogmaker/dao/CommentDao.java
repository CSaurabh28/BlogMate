package com.blogmaker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.blogmaker.entities.Comments;
import com.blogmaker.entities.Post;
import com.blogmaker.entities.user;

public class CommentDao {
	
		Connection con;

		public CommentDao(Connection con) {
			super();
			this.con = con;
		}
		
		public Boolean insertComments(Comments c)
		{
			boolean f=false;
			try {
			String q="insert into comments(comment,uid,pid)values(?,?,?)";
			PreparedStatement pst=con.prepareStatement(q);
			pst.setString(1,c.getComment());
			pst.setInt(2, c.getUid());
			pst.setInt(3, c.getPid());
			
			pst.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
			return f;
		}
		
		public ArrayList<Comments> getCommentByPostId(int pid){
			ArrayList<Comments> comments=new ArrayList<Comments>();
			try {
				PreparedStatement psmt=con.prepareStatement("select * from comments where pid=?;");
				psmt.setInt(1, pid);
				ResultSet rs=psmt.executeQuery();;
				
				while(rs.next()) {
					int comId=rs.getInt("comId");
					String comment=rs.getString("comment");
					int uid=rs.getInt("uid");
					Timestamp date=rs.getTimestamp("comDate");
					
					Comments c=new Comments(comId, comment, pid, uid, date);
					comments.add(c);
					
					
					
				}
			} catch (Exception e) {
				e.printStackTrace();// TODO: handle exception
			}
			
			return comments;
		}
		
		public user getUserByUid(int uid) {
			user u=null;
			try {
				String q="select * from register where id=?";
				PreparedStatement pst=con.prepareStatement(q);
				pst.setInt(1, uid);
				ResultSet rs=pst.executeQuery();
				
				while(rs.next()) {
					String name=rs.getString("name");
					String mobile=rs.getString("mobile");
					String email=rs.getString("email");
					String profile=rs.getString("profile");
					u=new user(name, mobile, email, null, null, profile);
				}
				
			} catch (Exception e) {
				e.printStackTrace();// TODO: handle exception
			}
			return u;
			
		}
}
