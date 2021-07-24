package com.ssafy.happyhouse.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.FavoriteAreaDto;
import com.ssafy.happyhouse.model.dto.UserDto;

public interface UserService {

	public UserDto login(Map<String, String> map) throws Exception;
	
//	REST 
	public List<UserDto> userList();
	public UserDto userInfo(int userid);
	public int userRegister(UserDto userDto);
	public int userModify(UserDto userDto);
	public int userDelete(String userid);
	// favorite area
	public int addArea(FavoriteAreaDto favoriteAreaDto);
	List<FavoriteAreaDto> areaList(int userid);
	public int deleteArea(FavoriteAreaDto favoriteAreaDto);
	public Boolean checkDuplication(String userid);
	
}
