<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Video Conference</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head>
<body>
	<div class="panel-body">
		<form action="savcMakeRoom" method="post">
			<label class="control-label">제목</label> 
			<input type="text" id="vcTitle" name="vcTitle" class="form-control" style="width: 250px"><br /> 
			<label class="control-label">참석자</label>
			<div class="form-group">
				<!-- 회의에 참석할 사원 선택 -> 사원 리스트 보여주기(+ 검색) -->
				<!-- Search (S) -->
				<select id="searchDept" class="form-control" style="width: 100px; display: inline;">
					<option value="0">부서</option>
					<option value="100">인사부</option>
					<option value="200">총무부</option>
					<option value="300">영업부</option>
					<option value="400">전산부</option>
					<option value="500">기획부</option>
				</select> <input type="text" id="searchName" placeholder="이름" class="form-control" style="width: 100px; display: inline;">
				<input type="button" class="btn btn-default btn-sm" value="검색" onclick="getMemberListForVc()"> <br />
			</div>
			<!-- Search (E) -->
			
			<!-- 참석자 리스트 (S) -->
			<div>
				<table class="table table-condensed table-hover" id="attendeeList">
					<tbody>
						<tr style="background-color: #F5F5F5;">
							<td class="col-lg-1"><input type="checkbox" name="all"
								onclick="checkAll(this,'chk2')"></td>
							<td class="col-lg-1"><span>이름</span></td>
							<td class="col-lg-1"><span>부서</span></td>
							<td class="col-lg-1"><span>직급</span></td>
						</tr>

<%-- 						<c:forEach var="mList" items="${list}"> --%>
<!-- 							<tr> -->
<!-- 								<td><input type="checkbox" name="chk" id="chk" -->
<%-- 									value="${mList.memnum}"></td> --%>
<%-- 								<td>${mList.memname}</td> --%>
<%-- 								<td>${mList.dename}</td> --%>
<%-- 								<td>${mList.memjob}</td> --%>
<!-- 							</tr> -->
<%-- 						</c:forEach> --%>
					</tbody>
				</table>
			</div>
			<!-- 참석자 리스트 (E) -->
			
			
			<!-- List (S) -->
			<div>
				<table class="table table-condensed table-hover" id="memberList">
					<tbody>
						<tr style="background-color: #F5F5F5;">
							<td class="col-lg-1"><input type="checkbox" name="all"
								onclick="checkAll(this,'chk')"></td>
							<td class="col-lg-1"><span>이름</span></td>
							<td class="col-lg-1"><span>부서</span></td>
							<td class="col-lg-1"><span>직급</span></td>
						</tr>

						<c:forEach var="mList" items="${list}">
							<tr>
								<td><input type="checkbox" name="chk" id="chk" value="${mList.memnum}" 
								onclick="goToList(this,${mList.memnum},'${mList.memname}','${mList.dename}','${mList.memjob}')"></td>
								<td>${mList.memname}</td>
								<td>${mList.dename}</td>
								<td>${mList.memjob}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- List (E) -->

			<!-- paging(S) 아직 안 됨 -->
			<div class="paging" id="paging">
				<input type="hidden" name="page" id="page"> 
				<input type="hidden" id="memdept" name="memdept" value="${pdept}">
				<input type="hidden" id="memname" name="memname" value="${pname}">
				<c:choose>
					<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
					<c:otherwise>
						<a class="page-first" href="javascript:goPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock },'memListPage')">&lt;&lt;</a>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
						<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
							<a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'memListPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
							<a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'memListPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
					<c:otherwise>
						<a class="page-last" href="javascript:goPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 },'memListPage')">&gt;&gt;</a>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- paging(E) -->

			<input type="button" id="moveBtn" onclick="moveVcRoom()" class="btn btn-default btn-sm" value="방 만들기">
		</form>
		<div id="test"></div>
	</div>
</body>
<script>
	function getMemberListForVc() {
		// 참석자를 선택하기 위해서 사원 리스트 불러오기
		$.ajax({
			type : "POST",
			url : "savcForm",
			data : {
				memdept : $("#searchDept").val(),
				memname : $("#searchName").val(),
				page : 1
			},
			success : function(result) {
				$('body').html(result);
			}
		});
	}

	function checkAll(obj,name) {
		// 체크박스 전체 선택(해제)을 해주는 메서드
		var chkArr;
		console.log(name);
		if(name=='chk'){
			chkArr = document.getElementsByName("chk");
		} else {
			chkArr = document.getElementsByName("chk2");
		}
		var len = chkArr.length;

		for (var i = 0; i < len; i++) {
			if (obj.checked) {
				chkArr[i].checked = true;
			} else {
				chkArr[i].checked = false;
			}
		}
		
	}
	
	function goToList(obj,memnum,memname,dename,memjob){
		// 1. 다시 체크박스 클릭했을 때 참석자 리스트에서 사라져야 함
		// 2. 검색 버튼 눌렀을 때 참석자 리스트는 초기화 안 되게 변경
		var row;
		
		if(obj.checked){
			console.log("사원 번호: "+memnum);
			console.log("사원 이름: "+memname);
			var row = "<tr id='"+memnum+"'><td><input type='checkbox' name='chk2' id='chk2' value='"+
			memnum+"'></td>"+"<td>"+memname+"</td>"+"<td>"+dename+"</td>"+"<td>"+memjob+"</td></tr>"
			$("#attendeeList").append(row);
		} else {
			row = document.getElementById(memnum);
			row.parentNode.removeChild(row);
		}
	}
	 
// 	$(function(){
// 		$.ajax({
// 			type : "GET",
// 			url: "http://192.168.56.1:8001",
// 			// http://stackoverflow.com/questions/20035101/no-access-control-allow-origin-header-is-present-on-the-requested-resource
// 			success : function(result) {
// 				$('#test').html(result);
// 			}
// 		});
// 	});
	
	function moveVcRoom(){
		var option = "width=600, height=500, scrollbars=yes";
		window.open("http://192.168.56.1:8001","Video Conference",option);
	}
</script>
</html>