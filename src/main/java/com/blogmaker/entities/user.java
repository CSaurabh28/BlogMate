package com.blogmaker.entities;
import java.sql.*;

public class user {
	private int id;
	private String name;
	private String mobile;
	private String email;
	private String password;
	private Timestamp rdate;
	private String profile;
	
	//constructor
	public user(int id, String name, String mobile, String email, String password, Timestamp rdate) {
		super();
		this.id = id;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.password = password;
		this.rdate = rdate;
	}
//default constructor
	public user() {
		
		// TODO Auto-generated constructor stub
	}

	public user(String name, String mobile, String email, String password, Timestamp rdate,String profile) {
		
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.password = password;
		this.rdate = rdate;
		this.profile = profile;
	}
	
	//getters and setters
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Timestamp getRdate() {
		return rdate;
	}
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	
	
	
	
	
	
	

}
