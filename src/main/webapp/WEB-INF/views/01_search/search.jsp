<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../common/common.css">
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
#map {
	height: 60%;
	width: 100%;
}

html, body {
	height: 100%;
	margin: 0 auto;
	padding: 0;
}

#house_details {
	height: auto;
	width: 100%;
}

.info {
	line-height: 10px;
}
</style>
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4&callback=initMap"></script>

<script>
	var map;
	var multi = {lat: 37.5665734, lng: 126.978179};
			/* lat : 37.484235, lng : 126.930324}; */
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center : multi,
			zoom : 12
		});
		var marker = new google.maps.Marker({
			position : multi,
			map : map
		});
		//infowindow = new google.maps.InfoWindow();
		//changeDong();
		//changeField();
	}
	function addMarker(tmpLat, tmpLng, aptName, dong, flag) {
		var marker = new google.maps.Marker({
			position: new google.maps.LatLng(parseFloat(tmpLat),parseFloat(tmpLng)),
			label: aptName,
			title: aptName,
			address: dong
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(marker.getPosition());
			callHouseDealInfo(marker.title, marker.address);
		});
		marker.setMap(map);
	}
	function callHouseDealInfo(aptName, dong) {
		$.get("${pageContext.request.contextPath}/map"
				,{act:"detail", name:aptName, dong:dong}
				,function(data, status){
					$("#detailResult").empty();
					$.each(data, function(index, vo) {
						let str = "<tr class="+colorArr[index%3]+">"
						+ "<td>" + vo.no + "</td>"
						+ "<td>" + vo.dong + "</td>"
						+ "<td>" + vo.aptName + "</td>"
						+ "<td>" + vo.dealAmount + "</td>"
						$("#detailResult").append(str);
					});//each
				}//function
				, "json"
		);//get
		/* location.href = "${pageContext.request.contextPath}/map?act=detail&name="+aptName+"&dong="+dong; */
	}

	function showSide() {
		$(".aside").css("display", "inline-block");
	}

	function goToInterest() {
		location.href = "/HappyHouse_Web_Front_test/03_interest/interest.jsp";
	}
	
	$(document).ready(function() {
		var infowindow;
		$(".aside").css("display", "none");
	});
	
	$(document.body).delegate("#resultTabl tr", "click", function() {
		console.log("tlqkf");
	});
	
</script>
<title>실거래가 조회</title>
</head>
<body>
	<%@ include file="../common/topbar.jsp"%>
	<div class="container-fluid" style="margin-top: 30px">
		<div class="row" style="height: 900px;">
			<div class="col-sm-9">
				
				<section id="index_section" class="form-inline" style="margin-left: 30%;">
				<%-- <form action="${pageContext.request.contextPath}/map" class="form-inline" style="margin-left: 30%;"> --%>
				<script>
				let colorArr = ['table-primary','table-success','table-danger'];
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
								,{act:"dong", gugun:$("#gugun").val()}
								,function(data, status){
									$("#dong").empty();
									$("#dong").append('<option value="0">선택</option>');
									$.each(data, function(index, vo) {
										$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
									});//each
								}//function
								, "json"
						);//get
					});//change
					$("#dong").change(function() {
						$.get("${pageContext.request.contextPath}/map"
								,{act:"apt", dong:$("#dong").val()}
								,function(data, status){
									$("#searchResult").empty();
									$.each(data, function(index, vo) {
										let str = "<tr class="+colorArr[index%3]+">"
										+ "<td>" + vo.no + "</td>"
										+ "<td>" + vo.dong + "</td>"
										+ "<td>" + vo.aptName + "</td>"
										+ "<td>" + vo.jibun + "</td>"
										+ "<td>" + vo.code
										+ "</td><td id='lat_"+index+"'></td><td id='lng_"+index+"'></td></tr>";
										$("#searchResult").append(str);
										$("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
									});//each
									geocode(data);
								}//function
								, "json"
						);//get
					});//change
				});//ready
				
				function searchByName() {
					$.get("${pageContext.request.contextPath}/map"
							,{act:"searchByAptName", aptName:$("#aptName").val()}
							,function(data, status){
								$("#searchResult").empty();
								$.each(data, function(index, vo) {
									let str = "<tr class="+colorArr[index%3]+">"
									+ "<td>" + vo.no + "</td>"
									+ "<td>" + vo.dong + "</td>"
									+ "<td>" + vo.aptName + "</td>"
									+ "<td>" + vo.jibun + "</td>"
									+ "<td>" + vo.code
									+ "<td>" + vo.dealAmount + "</td>"
									+ "</td><td id='lat_"+index+"'></td><td id='lng_"+index+"'></td></tr>";
									$("#searchResult").append(str);
									$("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>");
								});//each
								geocode(data);
							}//function
							, "json"
					);//get
				} //click
		
				
				function geocode(jsonData) {
					let idx = 0;
					$.each(jsonData, function(index, vo) {
						let tmpLat;
						let tmpLng;
						$.get("https://maps.googleapis.com/maps/api/geocode/json"
								,{	key:'AIzaSyA1BhXPeUWPvbopt-VhOGqgcPLOOyTfsG4'
									, address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
								}
								, function(data, status) {
									//alert(data.results[0].geometry.location.lat);
									tmpLat = data.results[0].geometry.location.lat;
									tmpLng = data.results[0].geometry.location.lng;
									$("#lat_"+index).text(tmpLat);
									$("#lng_"+index).text(tmpLng);
									addMarker(tmpLat, tmpLng, vo.aptName, vo.dong);
								}
								, "json"
						);//get
					});//each
				}
				</script>
					<button class="blue whiteFont" style="font-weight: bold; border-radius: 50px; background-color: #00519e; color: white;">실거래가</button>
					<input type="text" placeholder="아파트이름" id="aptName" name="aptName" class="form-control">
					<input type="button" id="aptNameBtn" class="form-control" value="검색" onclick="searchByName()">
					
					<select id="sido" name="region" class="form-control">
						<option value="0">선택</option>
					</select>
					<select id="gugun" name="dong" class="form-control dropdown dong">
						<option value="0">선택</option>
					</select>
					<select id="dong" name="dong" class="form-control dong">
						<option value="0">선택</option>
					</select>
					<table id="resultTable" class="table table-bordered table-hover text-center">
						<thead>
							<tr>
								<th>번호</th>
								<th>법정동</th>
								<th>아파트이름</th>
								<th>지번</th>
								<th>지역코드</th>
								<th>위도</th>
								<th>경도</th>
							</tr>
						</thead>
						<tbody id="searchResult">
						</tbody>
					</table>  
				</section>
				<div id="map" class="map container-fluid"></div>
				<div class="modal" id="house_details">
					<div class="modal-dialog" style="position: relative;">
						<div class="modal-content" style="width:fit-content; width:800px;">

							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">아파트 검색 상세</h4>

							</div>

							<!-- Modal body -->
							<div class="modal-body row">
								<div class="col-sm-6">
									<img src="../img/무악동현대.jpg" alt="주택사진" />
								</div>
								<div class="col-sm-6" style="background-color: lavenderblush;">
									<div class="form-group form-inline justify-content-between">
										<label for="makeId">주택명</label> <label class="form-control" id="hName">행복주택 </label>
									</div>
									<div class="form-group form-inline justify-content-between">
										<label for="makePwd">거래금액</label> <label class="form-control" id="hPrice">2,000 </label>
									</div>

									<div class="form-group form-inline justify-content-between">
										<label for="makeName">월세금액</label> <label class="form-control" id="hMPrice">없음 </label>
									</div>
									<div class="form-group form-inline justify-content-between">
										<label for="makeName">거래일</label> <label class="form-control" id="hDate">2019.09.28</label>
									</div>

								</div>
							</div>

							<!-- Modal footer -->
							<div class="modal-footer" style="display: inline-block; text-align: center;">
								<button type="button" class="center-block btn btn-warning" data-dismiss="modal">주변정보 확인</button>
								<button type="button" class="btn btn-primary" data-dismiss="modal" onClick="goToInterest()">관심장소 등록</button>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-sm3">
				<h2>거래정보</h2>
				<h5>행복주택</h5>
			<table class="table mt-2">
					<thead>
						<tr>
							<th>번호</th>
							<th>법정동</th>
							<th>아파트이름</th>							
							<th>거래가</th>
						</tr>
					</thead>
					<tbody id="detailResult">
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%@ include file="../common/bottombar.jsp"%>
</body>
</html>





