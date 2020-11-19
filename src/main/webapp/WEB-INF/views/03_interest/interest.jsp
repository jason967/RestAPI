<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style>
.category {
	margin-right: 20px;
}
</style>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>관심지역</title>
<script>
	var selected = null;
	$(document).ready(
			function() {
				//관심지역 리스트 보이기
				$("#interestListView").empty();
				<c:forEach items="${list}" var="interest" varStatus="status">
				$("#interestListView").append(
						"<span class='address m-4'>"
								+"<button type='button' class='btn btn-primary m-1 showBizInfo' id='${interest.dongName}'>"
								+ '${interest.sidoName}' + ' '
								+ '${interest.gugunName}' + " "
								+ "${interest.dongName}"
								+"</button><button class='interestBtn' style='color: red; border-color:#007bff'>X</button></span>");
				</c:forEach>

				$.get("${pageContext.request.contextPath}/biz", {
					act : "large"
				}, function(data, status) {
					$.each(data, function(index, vo) {
						$("#BigStore").append(
								"<option value='"+vo.large_code+"'>"
										+ vo.large_name + "</option>");
					});//each
				}//function
				, "json");//get

				$("#BigStore").change(
						function() {
							$.get("${pageContext.request.contextPath}/biz", {
								act : "mid",
								large_code : $("#BigStore").val()
							}, function(data, status) {
								$("#MidStore").empty();
								$("#MidStore").append(
										'<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#MidStore")
											.append(
													"<option value='"+vo.mid_code+"'>"
															+ vo.mid_name
															+ "</option>");
								});//each
							}//function
							, "json");//get
						});//change

				$("#MidStore").change(
						function() {
							$.get("${pageContext.request.contextPath}/biz", {
								act : "small",
								mid_code : $("#MidStore").val()
							}, function(data, status) {
								$("#SmallStore").empty();
								$("#SmallStore").append(
										'<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									console.log("vo: " + vo.small_name);
									$("#SmallStore").append(
											"<option value='"+vo.small_code+"'>"
													+ vo.small_name
													+ "</option>");
								});//each
							}//function
							, "json");//get
						});//change
				$("#SmallStore").change(function() {
					showBizList(selected);
				});//change

				// 상가정보 api
				/* $.ajax({
						type:"GET",
						url:"http://apis.data.go.kr/B553077/api/open/sdsc/largeUpjongList?serviceKey=27q0dlxEWy1MC4qIUAzdHc5WMwJXbPRsZGiYjC4Agat9nZaM3W70ebOGbLmwvDBJHTdOT0ArTJ1EIAO%2Ff2M%2BTA%3D%3D",
						contentType : "application/json",
						dataType: 'xml',  // jsonp: cors정책 우회
						beforeSend:function(xhr){
							xhr.setRequestHeader("Access-Control-Allow-Origin", "*");
							xhr.setRequestHeader("Access-Control-Allow-Headers", "X-Requested-With");
							xhr.setRequestHeader('Ping-Other', 'pingpong');
							xhr.setRequestHeader('Content-Type', 'application/xml');
						},
						success:function (data){
							 //let myXML = data.responseText; // xml의 text 형식
						 	//	let JSON = $.xml2json(myXML); // convert format (xml to json)
				//
								console.log("data: "+data);
						}
					}); // get
				 */

				// 관심지역 주변 상가정보
				$(".showBizInfo").click(function() {
					selected = $(this).attr('id');
					$(".showBizInfo").css("background-color","#007bff").css("border-color","#007bff");
					$("#"+selected).css("background-color","#f39c12").css("border-color","#f39c12");
					showBizList(selected);
				});

				// 관심지역 삭제
				$(".interestBtn").click(function() {
					var text = $(this).prev().text();
					$("#deleteData").val(text);//전송데이터 설정
					$("#deleteInterest").modal();//삭제 확인 팝업창
				});

			});

	function addInterest() {
		$("#addSidoName").val($("#addSido option:selected").text());
		$("#addGugunName").val($("#addGugun option:selected").text());
		$("#addDongName").val($("#addDong option:selected").text());
		$("#addInterestForm").submit();
	}

	function deleteInterest() {
		$("#deleteInterestForm").submit();// deleteInterest.do로 form 전송
	}
	
	function showBizList(selected){
		console.log(selected == 0 ? ' ':selected);
		console.log($("#SmallStore").val() == 0 ? ' ':$("#SmallStore").val());
		$.get("${pageContext.request.contextPath}/biz", {
			act : "bizList",
			dong_name : selected == 0 ? null:selected,
			small_code : $("#SmallStore").val() == 0 ? null:$("#SmallStore").val()
		}, function(data, status) {
			$("#searchResult").empty();
			$.each(data, function(index, vo) {
				console.log("vo: "+vo.biz_name);
				let str = "<tr class="+vo.biz_id+">"
				+ "<td>" + vo.biz_name + "</td>"
				+ "<td>" + vo.category + "</td>"
				+ "<td>" + vo.dong_name + "</td>"
				+ "<td>" + vo.lng + "</td>"
				+ "<td>" + vo.lat
				+ "</td></tr>";
				$("#searchResult").append(str);
			});//each
			//geocode(data);
		}//function
		, "json");//get
	}
</script>
</head>
<body>
	<%@ include file="../common/topbar.jsp"%>
	<div class="form-group form-inline" style="padding-top: 40px;">
		<button type="button" class="btn btn-primary ml-5 mb-1" disabled>관심지역</button>
		<div id="interestListView">
			<button type='button' class='btn btn-primary m-3'>관심지역 없음</button>
		</div>
		<button type="button" class="btn btn-dark loadData"
			data-toggle="modal" data-target="#addInfo">추가</button>
	</div>
	<div class="form-group form-inline ml-5 mt-1">
		<div class="category">
			<select type="button" class="btn btn-info m-3" id="BigStore"
				style="width: 100%">
				<option value="0">대분류</option>
			</select>
		</div>
		<div class="category">
			<select type="button" class="btn btn-info  m-3" id="MidStore"
				style="width: 100%">
				<option value="0">중분류</option>
			</select>
		</div>
		<div class="category">
			<select type="button" class="btn btn-info m-3" id="SmallStore"
				style="width: 100%">
				<option value="0">소분류</option>
			</select>
		</div>
	</div>

	<table id="resultTable"
		class="table table-bordered table-hover text-center">
		<thead>
			<tr>
				<th>상호명</th> <!--  상호명 + 지점명 -->
				<th>업종</th>
				<th>위치</th> 
				<th>위도</th>
				<th>경도</th>
			</tr>
		</thead>
		<tbody id="searchResult">
		</tbody>
	</table>
	
	<div class="modal" id="addInfo">
		<div class="modal-dialog" style="position: relative;">
			<div class="modal-content" style="width: fit-content;">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">관심지역 추가</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="addInterestForm" method="post" action="insertInterest.do">
						<div class="form-group form-inline"
							style="display: inline-block; text-align: center;">
							<div class="form-group form-inline justify-content-between">
								<label for="preferLocation">관심지역</label> <select id="addSido"
									class="form-control sido" name="sido">
									<option selected value="">선택</option>
								</select> <select id="addGugun" class="form-control gugun" name="gugun">
									<option selected value="">선택</option>
								</select> <select id="addDong" class="form-control dong" name="dong">
									<option selected value="">선택</option>
								</select>
							</div>
						</div>
						<input type="hidden" name="sidoName" id="addSidoName" /> <input
							type="hidden" name="gugunName" id="addGugunName" /> <input
							type="hidden" name="dongName" id="addDongName" />
						<!-- 지역명으로 전송하기 위해 히든 타입 생성 -->
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer"
					style="display: inline-block; text-align: center;">
					<button type="button" class="center-block btn btn-warning"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onClick="addInterest();">확인</button>
				</div>

			</div>
		</div>
	</div>



	<div class="modal" id="deleteInterest">
		<div class="modal-dialog" style="position: relative; width: 500px;">
			<div class="modal-content" style="width: fit-content;">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">관심지역 삭제</h4>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form id="deleteInterestForm" method="post"
						action="deleteInterest.do">
						<div class="form-group form-inline"
							style="display: inline-block; text-align: center; width: 400px;">
							<div class="form-group form-inline justify-content-between">
								<label for="preferLocation" style="width: 100%;">관심지역을
									삭제하시겠습니까?</label>
							</div>
						</div>
						<input type="hidden" name="interest" id="deleteData" />
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer"
					style="display: inline-block; text-align: center;">
					<button type="button" class="center-block btn btn-warning"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onClick="deleteInterest();">확인</button>
				</div>

			</div>
		</div>
	</div>
	<%@ include file="../common/bottombar.jsp"%>
</body>
</html>