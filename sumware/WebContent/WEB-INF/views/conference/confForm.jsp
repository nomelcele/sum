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
<script src="js/conference.js"></script>
</head>
<body>
	<div class="panel-body">
		<label class="control-label">제목</label> 
		<br/>
		<input type="text" id="confTitle" name="confTitle" class="form-control" style="width: 250px; display:inline;">
		<input type="button" id="moveBtn" onclick="moveConfRoom()" class="btn btn-default btn-sm" value="방 만들기">
		<br/><br/>
		<div style="display:inline; float:left; width:550px; margin-right:25px;">
			<label class="control-label">참석자</label>
			<input type="button" class="btn btn-default btn-sm" value="삭제" onclick="deleteFromList()" style="float: right;">
			<!-- 회의에 참석할 사원 선택 -> 사원 리스트 보여주기(+ 검색) -->
			
			<!-- 참석자 리스트 (S) -->
			<div>
			<br/>
				<table class="table table-condensed table-hover" id="attendeeList">
					<tbody id="alBody">
						<tr style="background-color: #F5F5F5;">
							<td class="col-lg-1"><input type="checkbox" name="all" onclick="checkAll(this,'chk2')"></td>
							<td class="col-lg-1"><span>이름</span></td>
							<td class="col-lg-1"><span>부서</span></td>
							<td class="col-lg-1"><span>직급</span></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 참석자 리스트 (E) -->
		</div>
		
		<div style="display:inline; float:left; width:550px; margin-right:25px;">
			<!-- Search (S) -->
			<div class="form-group">
				<select id="searchDept" class="form-control" style="width: 100px; display: inline;">
					<option value="0">부서</option>
					<option value="100">인사부</option>
					<option value="200">총무부</option>
					<option value="300">영업부</option>
					<option value="400">전산부</option>
					<option value="500">기획부</option>
				</select> 
				<input type="text" id="searchName" placeholder="이름" class="form-control" style="width: 100px; display: inline;">
				<input type="button" class="btn btn-default btn-sm" value="검색" onclick="getMemberListForConf()"> 
				 <br />
			</div>
			<!-- Search (E) -->

			<!-- List (S) -->
			<div id="memSearchForm">
				<table class="table table-condensed table-hover" id="memberList">
					<tbody>
						<tr style="background-color: #F5F5F5;">
							<td class="col-lg-1"><input type="checkbox" name="all" onclick="checkAll(this,'chk')"></td>
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
			
			<!-- List (E) -->
			
					<!-- paging(S) -->
					<div id="paging" style="text-align:center;">
						<input type="hidden" name="page" id="page"> 
						<input type="hidden" id="memdept" name="memdept" value="${pdept}">
						<input type="hidden" id="memname" name="memname" value="${pname}">
						<c:choose>
							<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
							<c:otherwise>
								<a class="page-first" href="javascript:goMemPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock })">&lt;&lt;</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
								<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
									<a href="javascript:goMemPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count })">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
									<a href="javascript:goMemPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count })">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
								</c:forEach>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
							<c:otherwise>
								<a class="page-last" href="javascript:goMemPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 })">&gt;&gt;</a>
							</c:otherwise>
						</c:choose>
					</div>
					</div>
					<!-- paging(E) -->
		</div>
	</div>
</body>
</html>