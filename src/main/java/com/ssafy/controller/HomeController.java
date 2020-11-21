package com.ssafy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class HomeController {

	@GetMapping("/")
	public String baseUrl(Model model) {
		model.addAttribute("msg", "테스트 페이지 입니다");
		return "index";
	}

	@RequestMapping("/searchPage.do")
	public String searchPage() {
		return "/01_search/search";
	}

	@RequestMapping("/surround.do")
	public String surroundPage() {
		return "/02_surround/surround";
	}

	@RequestMapping("/interest.do")
	public String interestPage() {
		return "/03_interest/interest";
	}

	@RequestMapping("/notice.do")
	public String noticePage() {
		return "/04_notice/notice";
	}

	@RequestMapping("/sitemap.do")
	public String siteMapPage() {
		return "/06_sitemap/sitemap";
	}

}
