package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.dto.UserDto;
import com.ssafy.happyhouse.model.dto.NoticeDto;

public interface NoticeMapper {
	
//	REST
	public List<NoticeDto> noticeList();
	public NoticeDto getNotice(int articleNo);
	public int noticeRegister(NoticeDto noticeDto);
	public int noticeModify(NoticeDto noticeDto);
	public int noticeDelete(int articleNo);
}
