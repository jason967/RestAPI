package com.ssafy.service;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.domain.User;

public interface UserService {

	// 로그인
	boolean login(Map<String, String> map) throws SQLException;

	// 회원 등록
	boolean register(User user) throws SQLException;

	// 단일 유저 불러옴
	User getUser(String id) throws SQLException;

	// 회원 수정
	boolean updateUser(User user) throws SQLException;

	// 회원 삭제
	boolean deleteUser(User user) throws SQLException;
	
	boolean insertUserInterest(String id, String interest) throws SQLException;

}
