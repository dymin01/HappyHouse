package com.ssafy.happyhouse.model.dto;

public class NoticeDto {

	private int articleno;
	private String user_idx;
	private String userid;
	private String subject;
	private String content;
	private String regtime;
	
	public NoticeDto(int articleNo, String userId, String subject, String content, String regtime) {
		super();
		this.articleno = articleNo;
		this.userid = userId;
		this.subject = subject;
		this.content = content;
		this.regtime = regtime;
	}
	
	public NoticeDto() {
		// TODO Auto-generated constructor stub
	}

	public int getArticleno() {
		return articleno;
	}
	public void setArticleno(int articleNo) {
		this.articleno = articleNo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userId) {
		this.userid = userId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegtime() {
		return regtime;
	}
	public void setRegtime(String regtime) {
		this.regtime = regtime;
	}
	

	public String getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(String user_idx) {
		this.user_idx = user_idx;
	}

	@Override
	public String toString() {
		return "NoticeDto [articleNo=" + articleno + ", userId=" + userid + ", subject=" + subject + ", content="
				+ content + ", regtime=" + regtime + "]";
	}
	
}
