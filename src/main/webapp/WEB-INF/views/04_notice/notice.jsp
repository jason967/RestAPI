<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../common/common.css" />
<link rel="stylesheet" type="text/css" href="notice.css" />
<link rel="stylesheet" href="../plugin/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="../plugin/jqgrid/css/ui.jqgrid.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
<script src="../plugin/jqgrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script src="../plugin/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<script>
	$(document).ready(function() {
		makeTable("news", "tmpdata_news.jsp");
		makeTable("notice", "tmpdata_notice.jsp");
		resizeJqGridWidth('news', 'grid_container_news', $('#grid_container_news').width(), true);
		resizeJqGridWidth('notice', 'grid_container_notice', $('#grid_container_notice').width(), true);
	});
	
	// jqGrid 테이블 만들기
	function makeTable(id, data) {
		$("#" + id).jqGrid({
			url : data, //json으로 바꾸기
			datatype : "json",
			height : 150,
			colNames : [ '글번호', '날짜', '제목','내용'],
			colModel : [ {
				name : 'id',
				label : '글번호',
				align : 'right',
				width:100
			}, {
				name : 'date',
				label : '날짜',
				sortable:true,
				align : 'right'
			}, {
				name : 'title',
				label : '제목',
				align : 'center',
				width:500
			},{
				name:'desc',
				label:"내용",
				hidden:true
			} ],
			loadComplete:function(data){
				var numOfRecord= $("#"+id).jqGrid("getGridParam","records");
				if(numOfRecord == 0)
					$("#noData"+id).html("<br>게시글이 없습니다.<br>");
				//initPage(id,numOfRecord,"");//초기셋팅
			},
			onCellSelect : function(rowid, index, contents, event) {
				var selected = $(this).jqGrid('getRowData', rowid);
				$('#modify input[type=text]').val(selected.title);
				$('#modify textarea').text(selected.desc); // 게시글 내용 추가
				$('#modify').modal('show');
				//$("#"+id).editGridRow( rowid);
			},
			pager :"#pager_"+id, 
			resizable:true
		});

	}// end of makeTable
	
	function initPage(id, totalSize, currentPage) {
		if(currentPage=="")
			var currentPage = $("#"+id).getGridParam("page");
		var pageCount = 5;//한 페이지에 보여줄 데이터 갯수
		var totalPage = Math.ceil(totalSize/$("#"+id).getGridParam('rowNum')); // grid의 전체 페이지 수
		var totalPageList =  Math.ceil(totalPage/pageCount);
		var pageList = Math.ceil(currentPage/pageCount);//몇번째 리스트인지
		
		// 작성중
		// https://m.blog.naver.com/PostView.nhn?blogId=jaeik714&logNo=140187085974&proxyReferer=https:%2F%2Fwww.google.com%2F
		
	}
	// jqgrid테이블 크기 조정
	function resizeJqGridWidth(grid_id, div_id, width, tf){
		 // window에 resize 이벤트를 바인딩 한다. 
	     $(window).bind('resize', function() {
	     var resizeWidth = $('#'+div_id).width(); //jQuery-ui의 padding 설정 및 border-width값때문에 넘치는 걸 빼줌.
	         // 그리드의 width 초기화
	         $('#' + grid_id).setGridWidth( resizeWidth, tf);
	         // 그리드의 width를 div 에 맞춰서 적용
	         $('#' + grid_id).setGridWidth( resizeWidth , tf); //Resized to new width as per window. 
	      }).trigger('resize');
	 }// end of resizeJqGridWidth
</script>
<style>
.white {
	color: white;
}
</style>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<!--  start body -->
<body>
	<%@ include file="../common/topbar.jsp"%>
	<section class="container">
		<!-- 뉴스 section, 글쓰기 버튼  -->
		<div class="list">
			<button class="blue whiteFont"
				style="font-weight: bold; border-radius: 50px; background-color: #00519e; color: white;">최근뉴스</button>
			<button data-toggle="modal" data-target="#write"
				style="float: right;">글쓰기</button>
		</div>

		<!-- 뉴스 테이블  -->
		<div id="grid_container_news">
			<table class="table table-hover" id="news"></table>
			<div id="noData_news"></div>
			<div id="pager_news"></div>
		</div>

		<!-- 공지 section, 글쓰기 버튼  -->
		<div class="list">
			<button class="orange whiteFont"
				style="font-weight: bold; border-radius: 50px; color: white;">공지사항</button>
			<button data-toggle="modal" data-target="#write"
				style="float: right;">글쓰기</button>
		</div>
		<!-- 공지테이블  -->
		<div id="grid_container_notice">
			<table class="table table-striped table-hover" id="notice"></table>
			<div id="noData_news"></div>
			<div id="pager_notice"></div>
		</div>

	</section>
<%@ include file="../common/bottombar.jsp"%>
</body>

<!--  모달 -->
<div class="modal" id="modify">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">글 수정</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group" style="text-align: center; display: grid">
					<input type="text" ><br>
					<textarea rows="10" cols="50" style="height: 300px;" autofocus></textarea>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>


<div class="modal" id="write">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">글 작성</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="form-group" style="text-align: center; display: grid">
					<input type="text" placeholder="제목을 입력하세요."><br>
					<textarea rows="10" cols="50" style="height: 300px;"
						placeholder="내용을 입력하세요." ></textarea>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer"
				style="display: inline-block; text-align: center;">
				<button type="button" class="center-block btn btn-warning"
					data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
			</div>

		</div>
	</div>
</div>
</html>