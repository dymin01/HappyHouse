package com.ssafy.happyhouse.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int registerArticle(NoticeDto noticeDto) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).noticeRegister(noticeDto);
	}

	@Override
	public List<NoticeDto> listArticle() throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).noticeList();
	}

	@Override
	public NoticeDto getArticle(int articleNo) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).getNotice(articleNo);
	}

	@Override
	public int modifyArticle(NoticeDto noticeDto) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).noticeModify(noticeDto);
	}

	@Override
	public int deleteArticle(int articleNo) throws Exception {
		return sqlSession.getMapper(NoticeMapper.class).noticeDelete(articleNo); 
	}

}
