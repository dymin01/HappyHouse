package com.ssafy.happyhouse.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dto.FavoriteAreaDto;
import com.ssafy.happyhouse.model.dto.UserDto;
import com.ssafy.happyhouse.model.mapper.FavoriteAreaMapper;
import com.ssafy.happyhouse.model.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public UserDto login(Map<String, String> map) throws Exception {
		if(map.get("userid") == null || map.get("userpwd") == null)
			return null;
		return sqlSession.getMapper(UserMapper.class).login(map);
	}

	@Override
	public List<UserDto> userList() {
		return sqlSession.getMapper(UserMapper.class).userList();
	}

	@Override
	public UserDto userInfo(int user_idx) {
		return sqlSession.getMapper(UserMapper.class).userInfo(user_idx);
	}

	@Override
	public int userRegister(UserDto userDto) {
		return sqlSession.getMapper(UserMapper.class).userRegister(userDto);
	}

	@Override
	public int userModify(UserDto userDto) {
		return sqlSession.getMapper(UserMapper.class).userModify(userDto);
	}

	@Override
	public int userDelete(String userid) {
		return sqlSession.getMapper(UserMapper.class).userDelete(userid);
	}

	@Override
	public List<FavoriteAreaDto> areaList(int user_idx) {
		return sqlSession.getMapper(FavoriteAreaMapper.class).areaList(user_idx);
	}
	
	@Override
	public int addArea(FavoriteAreaDto favoriteAreaDto) {
		return sqlSession.getMapper(FavoriteAreaMapper.class).addArea(favoriteAreaDto);
	}
	
	@Override
	public int deleteArea(FavoriteAreaDto favoriteAreaDto) {
		return sqlSession.getMapper(FavoriteAreaMapper.class).deleteArea(favoriteAreaDto);
	}
	
	@Override
	public Boolean checkDuplication(String userid) {
		if (sqlSession.getMapper(UserMapper.class).checkDuplication(userid).size() > 0) return false;
		return true;
	}

}
