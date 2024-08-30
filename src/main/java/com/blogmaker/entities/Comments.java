package com.blogmaker.entities;

import java.sql.Timestamp;

public class Comments {
	public int comId;
	public String comment;
	public int pid;
	public int uid;
	Timestamp comdate;
	
	
	public int getComId() {
		return comId;
	}

	public void setComId(int comId) {
		this.comId = comId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}
	
	

	public Timestamp getComdate() {
		return comdate;
	}

	public void setComdate(Timestamp comdate) {
		this.comdate = comdate;
	}

	

	public Comments(int comId, String comment, int pid, int uid, Timestamp comdate) {
		super();
		this.comId = comId;
		this.comment = comment;
		this.pid = pid;
		this.uid = uid;
		this.comdate = comdate;
	}

	public Comments() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Comments(String comment, int pid, int uid, Timestamp comdate) {
		super();
		this.comment = comment;
		this.pid = pid;
		this.uid = uid;
		this.comdate = comdate;
	}

	
	
	
}
