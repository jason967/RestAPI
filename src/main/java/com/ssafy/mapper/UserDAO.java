package com.ssafy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.User;

@Mapper
public interface UserDAO {

	// 로그인 할 때
	String selectUser(Map<String, String> map);

	// 아이디로 유저 불러오기
	User selectById(String id);

	// 회원 가입할 때
	int insert(User user);

	// 회원 정보 수정
	int update(User user);

	// 회원 정보삭제, 회원 삭제
	// 회원 상태만 0-> -1로 바꿔줌 실질적으로 삭제 x
	int delete(User user);

	// 관심 지역 넣기
	boolean insertInterest(@Param("id") String id, @Param("interest") String interest);

}
