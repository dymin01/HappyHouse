package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dao.QnADao;
import com.ssafy.happyhouse.model.dto.QnADto;
import com.ssafy.happyhouse.model.dto.SearchCondition;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnADao boardDao;
	
	@Override
	public List<QnADto> findAllBoard() throws Exception {
		return boardDao.findAllBoard();
	}

	@Override
	public void addBoard(QnADto boarddto) throws Exception {
		boardDao.addBoard(boarddto);
	}

	@Override
	public boolean updateBoard(QnADto board) throws Exception {
		return boardDao.updateBoard(board);
	}

	@Override
	public boolean deleteBoard(int no) throws Exception {
		return boardDao.deleteBoard(no);
	}

	@Override
	public QnADto findBoardById(int no) throws Exception {
		return boardDao.findBoardById(no);
	}

	@Override
	public List<QnADto> searchBoard(SearchCondition condition) {
		return boardDao.searchBoard(condition);
	}

}
