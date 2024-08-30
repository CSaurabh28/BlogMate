package com.blogmaker.entities;

public class Category {
		private int cid;
		private String cname;
		private String cdesc;
		
		public Category(int cid, String cname, String cdesc) {
			super();
			this.cid = cid;
			this.cname = cname;
			this.cdesc = cdesc;
		}

		public Category(String cname, String cdesc) {
			super();
			this.cname = cname;
			this.cdesc = cdesc;
		}

		public Category() {
			super();
			// TODO Auto-generated constructor stub
		}

		public int getCid() {
			return cid;
		}

		public void setCid(int cid) {
			this.cid = cid;
		}

		public String getCname() {
			return cname;
		}

		public void setCname(String cname) {
			this.cname = cname;
		}

		public String getCdesc() {
			return cdesc;
		}

		public void setCdesc(String cdesc) {
			this.cdesc = cdesc;
		}
		
		
		
}
