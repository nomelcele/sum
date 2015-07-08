<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@include file="modal.jsp" %> --%>
<!-- Search (S) -->
<div style="width:100%">
<div>
	<select id="searchDept">
		<option value="0">부서</option>
		<option value="100">인사부</option>
		<option value="200">총무부</option>
		<option value="300">영업부</option>
		<option value="400">전산부</option>
		<option value="500">기획부</option>
	</select>&nbsp; <input type="text" id="searchName" placeholder="이름"> <input
		type="button" class="btn btn-default btn-sm" value="검색"
		onclick="adminSelectMenu('adminPayManagement')"> <br />
	<br />
</div>
<!-- Search (E) -->

<!-- List (S) -->
<div>
	<table class="table table-condensed table-hover" id="listTable">
		<tbody>
			<tr style="background-color: #F5F5F5;">
				<!-- 						<td class="col-lg-1"><input type="checkbox" name="all" onclick="checkAll(this)"></td> -->
				<td class="col-lg-1"><span>이름</span></td>
				<td class="col-lg-1"><span>ID</span></td>
				<td class="col-lg-1"><span>생년월일</span></td>
				<td class="col-lg-2"><span>주소</span></td>
				<td class="col-lg-1"><span>부서</span></td>
				<td class="col-lg-1"><span>직급</span></td>
				<td class="col-lg-1"><span>입사일</span></td>
				<td class="col-lg-2"></td>
			</tr>

			<c:forEach var="mList" items="${list}">
				<tr>
					<td>${mList.memname}</td>
					<td>${mList.meminmail}</td>
					<td>${mList.membirth}</td>
					<td>${mList.memaddr}</td>
					<td>${mList.dename}</td>
					<td>${mList.memjob}</td>
					<td>${mList.memhire}</td>
					<td>
					<input type="button" class="btn btn-default btn-sm" value="추가급여지급"
					onclick="javascript:getMemInfoForModal(${mList.memnum})">
					<input type="button" class="btn btn-default btn-sm" value="월급지급"
					data-toggle="modal" data-target="#givePayment">
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>
<div id="modalTarget"></div>
<!-- List (E) -->

