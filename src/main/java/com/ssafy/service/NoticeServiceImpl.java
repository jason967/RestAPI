package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.Notice;
import com.ssafy.mapper.NoticeDAO;

@Service
public class NoticeServiceImpl implements NoticeService {

	private NoticeDAO noticeDao;

	@Autowired
	public void setNoticeDao(NoticeDAO noticeDao) {
		this.noticeDao = noticeDao;
	}

	@Override
	public List<Notice> getNotices() throws Exception {
		return noticeDao.getNotices();
	}

	@Override
	public Notice getNotice(String idx) throws Exception {
		return noticeDao.selectNotice(idx);
	}

	@Override
	public boolean registerNotice(Notice notice) throws Exception {
		return noticeDao.setNotice(notice);
	}

	@Override
	public boolean updateNotice(Notice notice) throws Exception {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public boolean deleteNotice(String idx) throws Exception {
		return noticeDao.deleteNotice(idx);
	}

}
