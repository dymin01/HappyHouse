package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.GuguncodeDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidocodeDto;


public interface SidoGugunDongService {

	List<HouseInfoDto> getDongcodes(String gugun) throws Exception;
	List<SidocodeDto> getAllSidocode() throws Exception;
	List<GuguncodeDto> getGuguncode(String sido) throws Exception;
	
}
