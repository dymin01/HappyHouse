package com.ssafy.happyhouse.dao;

import java.util.List;

import com.ssafy.happyhouse.model.dto.QnADto;
import com.ssafy.happyhouse.model.dto.SearchCondition;

public interface QnADao {
	public List<QnADto> findAllBoard() throws Exception;
	
	public QnADto findBoardById(int no) throws Exception;
	
	public void addBoard(QnADto boarddto) throws Exception;
	
	public boolean updateBoard(QnADto board)throws Exception;
	
	public boolean deleteBoard(int no) throws Exception;

	public List<QnADto> searchBoard(SearchCondition condition);

}
