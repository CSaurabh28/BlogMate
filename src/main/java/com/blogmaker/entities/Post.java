package com.blogmaker.entities;

import java.sql.Timestamp;

public class Post {
	private int pId;
	private String pTitle;
	private String pContent;
	private String pImg;
	private Timestamp pDate;
	private int catId;
	private int uId;
	
	public Post(int pId, String pTitle, String pContent, String pImg, Timestamp pDate, int catId,int uId) {
		super();
		this.pId = pId;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pImg = pImg;
		this.pDate = pDate;
		this.catId = catId;
		this.uId = uId;
	}
	public Post(String pTitle, String pContent, String pImg, Timestamp pDate, int catId,int uId) {
		super();
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pImg = pImg;
		this.pDate = pDate;
		this.catId = catId;
		this.uId = uId;
	}
	public Post() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getpTitle() {
		return pTitle;
	}
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public String getpImg() {
		return pImg;
	}
	public void setpImg(String pImg) {
		this.pImg = pImg;
	}
	public Timestamp getpDate() {
		return pDate;
	}
	public void setpDate(Timestamp pDate) {
		this.pDate = pDate;
	}
	public int getCatId() {
		return catId;
	}
	public void setCatId(int catId) {
		this.catId = catId;
	}
	public int getuId() {
		return uId;
	}
	public void setuId(int uId) {
		this.uId = uId;
	}
	
	
	
	
	
}
