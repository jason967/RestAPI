<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>주변탐방</title>
<script>
$(document).ready(function(){
	$.get("${pageContext.request.contextPath}/map"
		,{act:"sido"}
		,function(data, status){
			$.each(data, function(index, vo) {
				$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
			});//each
		}//function
		, "json"
	);//get
});//ready
$(document).ready(function(){
	$("#sido").change(function() {
		$.get("${pageContext.request.contextPath}/map"
				,{act:"gugun", sido:$("#sido").val()}
				,function(data, status){
					$("#gugun").empty();
					$("#gugun").append('<option value="0">선택</option>');
					$.each(data, function(index, vo) {
						$("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
					});//each
				}//function
				, "json"
		);//get
	});//change
	$("#gugun").change(function() {
		$.get("${pageContext.request.contextPath}/map"
				,{act:"hospital", gugun:$("#gugun").val()}
				,function(data, status){
					$("#searchResult").empty();
					$.each(data, function(index, vo) {
						let str = "<tr>"
						+ "<td>" + vo.hospitalName + "</td>"
						+ "<td>" + vo.address + "</td>"
						+ "<td>" + vo.tel + "</td>"
						+ "</td></tr>";
						$("#searchResult").append(str);
					}); // each
				}//function
				, "json"
			);
		
		$.get("${pageContext.request.contextPath}/map"
				,{act:"screening", gugun:$("#gugun").val()}
				,function(data, status){
					$("#searchResult2").empty();
					$.each(data, function(index, vo) {
						let str = "<tr>"
						+ "<td>" + vo.hospitalName + "</td>"
						+ "<td>" + vo.address + "</td>"
						+ "<td>" + vo.weektime + "</td>"
						/* + "<td>" + vo.tel + "</td>" */
						+ "<td>" + vo.possible + "</td>"
						+ "</td></tr>";
						$("#searchResult2").append(str);
					}); // each
				}//function
				, "json"
			);
	});//change
});//ready

</script>
</head>
<body>
	<%@ include file="../common/topbar.jsp"%>
	<div class="form-group form-inline ml-5 mt-1">
		<div class="category">
			<select type="button" class="btn btn-info m-3" id="sido"
				style="width: 100%">
				<option value="0">시/도 </option>
			</select>
		</div>
		<div class="category">
			<select type="button" class="btn btn-info  m-3" id="gugun"
				style="width: 100%">
				<option value="0">구/군</option>
			</select>
		</div>
	</div>

	<table id="resultTable"
		class="table table-bordered table-hover text-center">
		<thead>
			<tr>
				<th>병원명</th>
				<th>위치</th>
				<th>전화번호</th> 
			</tr>
		</thead>
		<tbody id="searchResult">
		</tbody>
	</table>
	</br></br>
	<table id="resultTable2"
		class="table table-bordered table-hover text-center">
		<thead>
			<tr>
				<th>병원명</th>
				<th>위치</th>
				<th>운영시간</th>
				<!-- <th>전화번호</th> --> 
				<th>검체채취 가능여부</th>
			</tr>
		</thead>
		<tbody id="searchResult2">
		</tbody>
	</table>

	<%@ include file="../common/bottombar.jsp"%>
</body>
</html>