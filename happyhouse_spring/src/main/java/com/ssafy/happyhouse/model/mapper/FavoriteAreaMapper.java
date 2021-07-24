package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.FavoriteAreaDto;

public interface FavoriteAreaMapper {
	
//	REST
	public List<FavoriteAreaDto> areaList(int user_idx);
	public int addArea(FavoriteAreaDto favoriteAreaDto);
	public int deleteArea(FavoriteAreaDto favoriteAreaDto);
}
