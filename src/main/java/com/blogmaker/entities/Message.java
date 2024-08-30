package com.blogmaker.entities;

public class Message {
	public String content;
	public String type;
	public String Cssclass;
	
	public Message(String content, String type, String cssclass) {
		super();
		this.content = content;
		this.type = type;
		Cssclass = cssclass;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCssclass() {
		return Cssclass;
	}

	public void setCssclass(String cssclass) {
		Cssclass = cssclass;
	}
	
	
}
