package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.Notice;

public interface NoticeService {

	List<Notice> getNotices() throws Exception;

	public Notice getNotice(String idx) throws Exception;

	public boolean registerNotice(Notice notice) throws Exception;

	public boolean updateNotice(Notice notice) throws Exception;

	boolean deleteNotice(String idx) throws Exception;

}
