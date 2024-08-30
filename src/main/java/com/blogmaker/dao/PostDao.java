package com.blogmaker.dao;

import java.sql.*;

import java.util.*;

import com.blogmaker.entities.Category;
import com.blogmaker.entities.Post;
import com.blogmaker.entities.user;
import com.mysql.cj.x.protobuf.MysqlxPrepare.Prepare;

public class PostDao {
	private Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}
	//fetching categories from db
	public ArrayList<Category> getCategories() {
		ArrayList<Category> list=new ArrayList<>();
		try {
			//fetch  categories from db
			String q="select * from categories";
			Statement st=con.createStatement();
			
			ResultSet rs=st.executeQuery(q);
			while(rs.next())
			{
				int cid=rs.getInt("cid");
				String cname=rs.getString("cname");
				String cdesc=rs.getString("cdesc");
				//make Category obj
				Category c=new Category(cid,cname,cdesc);
				//adding to the list of array
				list.add(c);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//insert to post table
	public boolean savePost(Post p) {
		boolean f=false;
		
		try {
			
			String q="insert into post(pTitle,pContent,pImg,cId,uId)values(?,?,?,?,?)";
			PreparedStatement pst=con.prepareStatement(q);
			pst.setString(1, p.getpTitle());
			pst.setString(2, p.getpContent());
			pst.setString(3, p.getpImg());
			pst.setInt(4, p.getCatId());
			pst.setInt(5, p.getuId());
			pst.executeUpdate();
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		
		return f;
		
	}
	//fetch all posts from table post and added to list
	public ArrayList<Post> getAllPosts() {
		ArrayList<Post> list=new ArrayList<Post>();
		try {
			PreparedStatement psmt=con.prepareStatement("select * from post order by pDate desc;");
			ResultSet rs=psmt.executeQuery();
			while(rs.next()) {
				int pId=rs.getInt("pId");
				String pTitle=rs.getString("pTitle");
				String pContent=rs.getString("pContent");
				String pImg=rs.getString("pImg");
				Timestamp date=rs.getTimestamp("pDate");
				int cid=rs.getInt("cId");
				int uid=rs.getInt("uId");
				Post post=new Post(pId,pTitle, pContent, pImg, date, cid, uid);
				list.add(post);
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return list;
	}
	//fetch posts by categories
	public ArrayList<Post> getPostByCategories(int catId) {
		ArrayList<Post> list=new ArrayList<Post>();
		try {
			PreparedStatement psmt=con.prepareStatement("select * from post where cid=?;");
			psmt.setInt(1, catId);
			ResultSet rs=psmt.executeQuery();
			
			while(rs.next()) {
				int pId=rs.getInt("pId");
				String pTitle=rs.getString("pTitle");
				String pContent=rs.getString("pContent");
				String pImg=rs.getString("pImg");
				Timestamp date=rs.getTimestamp("pDate");
				int cid=rs.getInt("cId");
				int uid=rs.getInt("uId");
				Post post=new Post(pId,pTitle, pContent, pImg, date, cid, uid);
				list.add(post);
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return list;
	}
	
	public Post getPostByPostId(int post_id) {
		Post p=null;
		try {
				String q="select * from post where pId=?";
				PreparedStatement pt=con.prepareStatement(q);
				pt.setInt(1, post_id);
				ResultSet rs=pt.executeQuery();
				while(rs.next()) {
					int pId=rs.getInt("pId");
					String pTitle=rs.getString("pTitle");
					String pContent=rs.getString("pContent");
					String pImg=rs.getString("pImg");
					Timestamp date=rs.getTimestamp("pDate");
					int cid=rs.getInt("cId");
					int uid=rs.getInt("uId");
					 p=new Post(pId,pTitle, pContent, pImg, date, cid, uid);
				}
				
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return p;
	}
	
	public boolean deletePostByPostId(int pid) {
		boolean f=false;
		try {
			PreparedStatement pst=con.prepareStatement("delete from post where pid=?");
			pst.setInt(1, pid);
			pst.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		
		return f;
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
	
	public ArrayList<Post> getPostByUser(int uid) {
		ArrayList<Post> list=new ArrayList<Post>();
		try {
			PreparedStatement psmt=con.prepareStatement("select * from post where uid=?;");
			psmt.setInt(1, uid);
			ResultSet rs=psmt.executeQuery();
			
			while(rs.next()) {
				int pId=rs.getInt("pId");
				String pTitle=rs.getString("pTitle");
				String pContent=rs.getString("pContent");
				String pImg=rs.getString("pImg");
				Timestamp date=rs.getTimestamp("pDate");
				int cid=rs.getInt("cId");
				
				Post post=new Post(pId,pTitle, pContent, pImg, date, cid, uid);
				list.add(post);
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return list;
	}
}
