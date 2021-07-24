package com.ssafy.happyhouse.model.dto;

public class FavoriteAreaDto {

	private String user_idx;
	private String gugunname;
	private String guguncode;
	private String dongname;

	public FavoriteAreaDto() {
	}

	public FavoriteAreaDto(String user_idx, String gugunname, String guguncode, String dongname) {
		this.user_idx = user_idx;
		this.gugunname = gugunname;
		this.guguncode = guguncode;
		this.dongname = dongname;
	}

	public String getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(String user_idx) {
		this.user_idx = user_idx;
	}

	public String getGugunname() {
		return gugunname;
	}

	public void setGugunname(String gugunname) {
		this.gugunname = gugunname;
	}

	public String getGuguncode() {
		return guguncode;
	}

	public void setGuguncode(String guguncode) {
		this.guguncode = guguncode;
	}

	public String getDongname() {
		return dongname;
	}

	public void setDongname(String dongname) {
		this.dongname = dongname;
	}

	@Override
	public String toString() {
		return "FavoriteAreaDto [user_idx=" + user_idx + ", gugunname=" + gugunname + ", guguncode=" + guguncode
				+ ", dongname=" + dongname + "]";
	}

	
}
