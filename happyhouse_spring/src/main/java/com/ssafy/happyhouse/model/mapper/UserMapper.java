package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.UserDto;

public interface UserMapper {

	public UserDto login(Map<String, String> map) throws SQLException;
	
//	REST
	public List<UserDto> userList();
	public UserDto userInfo(int userid);
	public int userRegister(UserDto userDto);
	public int userModify(UserDto userDto);
	public int userDelete(String userid);
	
	public List<UserDto> checkDuplication(String userid);
	
}
