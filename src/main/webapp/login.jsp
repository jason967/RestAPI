<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<jsp:include page="/menu.jsp"></jsp:include>
<jsp:include page="/footer.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/style.css" />
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<title>Welcome</title>
</head>
<body>
	
		<div class="welcome__wrapper">
			<header class="welcome-header">
				<h1 class="welcome-header__title">Woong's House</h1>
				<p class="welcome-header__text">재웅이네 집에 오신 것을 환영합니다.</p>
			</header>

			<form action="${root}/user/login.do" method="get" id="login-form">
				<input type="text" placeholder="아이디" name="id" /> 
				<input type="password" placeholder="비밀번호" name="pwd" /> 
				<input type="submit" value="로그인" />
			</form>
			<c:if test="${errorMsg !=null }">
				<div style="color: red">${errorMsg }</div>
			</c:if>

			<div class="find_form">
				<a href="searchId.html" rel="nofollow"> 아이디 찾기</a> | 
				<a href="searchPassword.html" rel="nofollow">비밀번호 찾기</a> | 
				<a href="join.html" rel="nofollow">회원가입</a>
			</div>
			<div class="enterprise-area">
				<img src="img/enter.png" />
			</div>
		</div>
	
</body>
</html>