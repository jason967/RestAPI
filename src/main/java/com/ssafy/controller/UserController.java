package com.ssafy.controller;

import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.domain.User;
import com.ssafy.service.UserService;

@RequestMapping("/user")
@Controller
public class UserController {
	@Autowired
	private UserService userService;

//	
//	public void setUserService(UserService userService) {
//		this.userService = userService;
//	}

	@GetMapping("/login.do")
	public String login(String id, String pwd, Model model, HttpSession session) throws SQLException {
		// 일단 아이디 혹은 비밀번호가 입력되었는지 확인
		System.out.println("로그인이 되려고 합니다!!");
		// 아이디가 입력되지 않는 경우
		if (id == null || id.trim().length() == 0) {
			model.addAttribute("errorMsg", "아이디를 입력하세요");
			return "login";
		}

		// 비밀 번호가 입력되지 않는 경우
		else if (pwd == null || pwd.trim().length() == 0) {
			model.addAttribute("errorMsg", "비밀번호를 입력하세요");
			return "login";
		}

		// 아이디, 비밀 번호 일치여부 판별
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);

		boolean result = userService.login(map);

		if (result) { // 로그인 성공
			session.setAttribute("id", id); // 로그인 상태정보 유지
			return "redirect:/";

		} else { // 로그인 실패
			model.addAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "login";
		}
	}

	// 로그 아웃
	// /user/logout.do
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@PostMapping("register.do")
	public String registerUser(User user, Model model, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		String sido = request.getParameter("sidoName");
		String interest = sido != null
				? sido + "_" + request.getParameter("gugunName") + "_" + request.getParameter("dongName")
				: null;
		System.out.println(interest);
		user.setInterest(interest);
		boolean result = result = userService.register(user);
		if (result) {
			System.out.println("회원가입 성공");
			userService.insertUserInterest(user.getId(), interest);
			return "redirect:/";
		} else {
			System.out.println("회원가입 실패");
			model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
			return "registerForm";

		}

	}

	@GetMapping("/loginForm.do")
	public String loginForm() {
		return "login";
	}

	@PostMapping("/registerForm.do")
	public String registerForm() {
		return "register";
	}
}
