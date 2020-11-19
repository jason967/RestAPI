package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.Notice;

@Repository
@Mapper
public interface NoticeDAO {
	List<Notice> getNotices() throws Exception;

	// 공지사항 등록
	boolean setNotice(Notice notice) throws Exception;

	// 공지사항 데이터 불러옴
	Notice selectNotice(String idx) throws Exception;

	// 공지사항 수정
	boolean updateNotice(Notice notice) throws Exception;

	// 공지사항 삭제
	boolean deleteNotice(String idx) throws Exception;
}
