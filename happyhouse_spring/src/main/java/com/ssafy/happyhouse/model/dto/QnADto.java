package com.ssafy.happyhouse.model.dto;

import java.io.Serializable;

public class QnADto {

	private int articleno;
	private String userid;
	private String subject;
	private String content;
	private String regtime;
	private int user_idx;
	private String answer;

	public QnADto() {
	}
	
	public QnADto(int articleno, int user_idx, String subject, String content, String regtime) {
		super();
		this.articleno = articleno;
		this.user_idx = user_idx;
		this.subject = subject;
		this.content = content;
		this.regtime = regtime;
	}
	public int getArticleno() {
		return articleno;
	}
	public void setArticleno(int articleno) {
		this.articleno = articleno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Override
	public String toString() {
		return "BoardDto [articleno=" + articleno + ", userid=" + userid + ", subject=" + subject + ", content="
				+ content + ", regtime=" + regtime + ", user_idx=" + user_idx + ", answer=" + answer + "]";
	}
	
	
}
