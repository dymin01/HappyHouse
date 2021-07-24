package com.ssafy.happyhouse.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.GuguncodeDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidocodeDto;


@Repository
public class SidoGugunDongDaoImpl implements SidoGugunDongDao {

	String ns = "sidogugundong.";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<HouseInfoDto> getDongcodes(String gugun) throws SQLException {
		
		return sqlSession.selectList(ns+"getDongcodes", gugun);
	}
	
	@Override
	public List<SidocodeDto> getAllSidocode() throws SQLException {
		return sqlSession.selectList(ns+"getAllSidocode");
	}

	@Override
	public List<GuguncodeDto> getGuguncode(String sido) throws SQLException {
		return sqlSession.selectList(ns+"getGuguncode", sido);
	}

}
