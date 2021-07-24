package com.ssafy.happyhouse.model.dto;

public class SidocodeDto {
	
	private String sido_code;
	private String sido_name;
	
	public SidocodeDto() {
		super();
	}
	
	public SidocodeDto(String sidoCode, String sido_name) {
		super();
		this.sido_code = sido_code;
		this.sido_name = sido_name;
	}

	public String getSido_code() {
		return sido_code;
	}

	public void setSido_code(String sido_code) {
		this.sido_code = sido_code;
	}

	public String getSido_name() {
		return sido_name;
	}

	public void setSido_name(String sido_name) {
		this.sido_name = sido_name;
	}
	

}