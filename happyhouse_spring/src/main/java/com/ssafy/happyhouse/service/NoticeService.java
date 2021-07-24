package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.NoticeDto;

public interface NoticeService {

//	글작성
	int registerArticle(NoticeDto noticeDto) throws Exception;
	
//	글목록
	List<NoticeDto> listArticle() throws Exception;
	
//	글수정을 위한 글얻기
	NoticeDto getArticle(int articleNo) throws Exception;
	
//	글수정
	int modifyArticle(NoticeDto noticeDto) throws Exception;
	
//	글삭제
	int deleteArticle(int articleNo) throws Exception;
	
}
