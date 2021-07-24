package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dao.SidoGugunDongDao;
import com.ssafy.happyhouse.model.dto.GuguncodeDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidocodeDto;

@Service
public class SidoGugunDongServiceImpl implements SidoGugunDongService {
	
	@Autowired
	private SidoGugunDongDao sidoGugunDongDao;
	
	@Override
	public List<HouseInfoDto> getDongcodes(String gugun) throws Exception {
		gugun = gugun == null ? "" : gugun;
		return sidoGugunDongDao.getDongcodes(gugun);
	}

	@Override
	public List<SidocodeDto> getAllSidocode() throws Exception {
		return sidoGugunDongDao.getAllSidocode();
	}

	@Override
	public List<GuguncodeDto> getGuguncode(String sido) throws Exception {
		return sidoGugunDongDao.getGuguncode(sido);
	}
}