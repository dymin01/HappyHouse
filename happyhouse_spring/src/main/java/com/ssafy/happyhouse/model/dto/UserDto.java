package com.ssafy.happyhouse.model.dto;

public class UserDto {

	private String userid;
	private String user_idx;
	private String username;
	private String userpwd;
	private String email;
	private String address;
	private String joindate;
	private String age;
	private String role;

	public UserDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public UserDto(String userId, String user_idx,  String userName, String userPwd, String email, String address, String joindate, String age) {
		super();
		this.userid = userId;
		this.user_idx = user_idx;
		this.username = userName;
		this.userpwd = userPwd;
		this.email = email;
		this.address = address;
		this.joindate = joindate;
		this.setAge(age);
	}


	public UserDto(String userId, String user_idx, String userName, String userPwd, String email, String address, String age) {
		super();
		this.userid = userId;
		this.user_idx = user_idx;
		this.username = userName;
		this.userpwd = userPwd;
		this.email = email;
		this.address = address;
		this.setAge(age);
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userId) {
		this.userid = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String userName) {
		this.username = userName;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userPwd) {
		this.userpwd = userPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getJoindate() {
		return joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	@Override
	public String toString() {
		return "MemberDto [userid=" + userid + ", username=" + username + ", userpwd=" + userpwd + ", email=" + email
				+ ", address=" + address + ", joindate=" + joindate + "]";
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public String getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(String user_idx) {
		this.user_idx = user_idx;
	}
	
}