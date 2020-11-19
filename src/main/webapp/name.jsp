<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

	<h2> 단일 파라미터 전송</h2>
	<form method="post" action="${pageContext.request.contextPath}/name/hello.do">
		name : <input type="text" name="name" /> <br/>
		<input type="submit" value="전송"/> 
		<input type="reset" value="취소"/> 
	</form>
	
	<hr/>
	
	<h2> 여러 파라미터 전송</h2>
<%-- 	<form method="post" action="${pageContext.request.contextPath}/person/hello1.do"> --%>
	<form method="post" action="${pageContext.request.contextPath}/person/hello2.do">
		name : <input type="text" name="name" /> <br/>
		age : <input type="text" name="age" /> <br/>
		<input type="submit" value="전송"/> 
		<input type="reset" value="취소"/> 
	</form>

</body>
</html>