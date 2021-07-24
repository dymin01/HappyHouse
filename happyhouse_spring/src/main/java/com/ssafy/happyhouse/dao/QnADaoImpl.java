package com.ssafy.happyhouse.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssafy.happyhouse.model.dto.QnADto;
import com.ssafy.happyhouse.model.dto.SearchCondition;

@Repository
public class QnADaoImpl implements QnADao {

	private String ns = "com.ssafy.happyhouse.model.mapper.QnAMapper.";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<QnADto> findAllBoard() throws Exception {
		return sqlSession.selectList(ns+"findAllBoard");
	}

	@Override
	public QnADto findBoardById(int no) throws Exception {
		return sqlSession.selectOne(ns+"findBoardById", no);
	}

	@Override
	public void addBoard(QnADto qnADto) throws Exception {
		sqlSession.insert(ns+"addBoard", qnADto);
	}

	@Override
	public boolean updateBoard(QnADto board) throws Exception {
		
		sqlSession.update(ns+"updateBoard", board);
		return true;
	}

	@Override
	public boolean deleteBoard(int no) throws Exception {
		sqlSession.delete(ns+"deleteBoard", no);
		return true;
	}

	@Override
	public List<QnADto> searchBoard(SearchCondition condition) {
		return sqlSession.selectList(ns+"searchBoard", condition);
	}

}
