<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-sm bg-light fixed-top shadow">
	<div class="container">
		<a class="navbar-brand" href="main.jsp">Woong's house</a>
		<ul id="header_nav_confirmon" class="navbar-nav justify-content-end">
			<!-- style="display: none;"> -->

			<c:choose>
				<%--주석 달고 싶으면 jsp 주석 써야댐 --%>
				<c:when test="${id!=null }">
					<li class="nav-item"><a class="nav-link text-secondary"
						href="#">${id }님 로그인 중 </a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="notice.do">공지사항</a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="interest.do">관심 지역</a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="logout.do">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="searchHospital.jsp">안전 병원 검색</a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="searchJinryo.jsp">코로나 진료소 검색</a></li>

					<li class="nav-item"><a class="nav-link text-secondary"
						href="mypage.do">마이페이지</a></li>
					<c:if test="${id=='admin' }">
						<li class="nav-item"><a class="nav-link text-secondary"
							href="userlist.do">회원 목록</a></li>
					</c:if>
				</c:when>
				<c:otherwise>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="notice.do">공지사항</a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="register.jsp">회원가입</a></li>
					<li class="nav-item"><a class="nav-link text-secondary"
						href="${pageContext.request.contextPath}/login.jsp">로그인</a></li>
				</c:otherwise>
			</c:choose>

			<li class="nav-item"><a class="nav-link text-secondary"
				href="search.jsp">검색</a></li>

			<li class="nav-item"><a class="nav-link text-secondary"
				href="sitemap.jsp">사이트 맵</a></li>
		</ul>
	</div>
</nav>