package com.ssafy.service;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.User;
import com.ssafy.mapper.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	private UserDAO userDao;

	@Autowired
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	// 로그인
	@Override
	public boolean login(Map<String, String> map) throws SQLException {
		return userDao.selectUser(map) != null;
	}

	// 회원가입
	@Override
	public boolean register(User user) throws SQLException {

		// 이미 해당 아이디가 존재하는 경우
		if (getUser(user.getId()) != null)
			throw new RuntimeException("아이디가 중복되었습니다.");

		// 아이디가 존재하지 않아 올바르게 회원가입이 되는 경우
		return userDao.insert(user) > 0;
	}

	// 단일 유저 정보 불러오기
	@Override
	public User getUser(String id) throws SQLException {
		return userDao.selectById(id);
	}

	@Override
	public boolean insertUserInterest(String id, String interest) throws SQLException {
		return userDao.insertInterest(id, interest);
	}

	// 회원 정보 수정
	@Override
	public boolean updateUser(User user) throws SQLException {
		return userDao.update(user) > 0;
	}

	// 회원 삭제 (회원 상태 0-> -1)
	@Override
	public boolean deleteUser(User user) throws SQLException {
		return userDao.delete(user) > 0;
	}

}
