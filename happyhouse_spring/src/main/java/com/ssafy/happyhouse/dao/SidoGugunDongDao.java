package com.ssafy.happyhouse.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.dto.GuguncodeDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidocodeDto;


public interface SidoGugunDongDao {
	
	List<HouseInfoDto> getDongcodes(String gugun) throws SQLException;

	List<SidocodeDto> getAllSidocode() throws SQLException;
	
	List<GuguncodeDto> getGuguncode(String sido) throws SQLException;

}
