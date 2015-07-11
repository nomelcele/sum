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
				<td class="col-lg-1"><span>부서</span></td>
				<td class="col-lg-1"><span>직급</span></td>
				<td class="col-lg-1"><span>호봉</span></td>
				<td class="col-lg-1"><span>연봉(만원)</span></td>
				<td class="col-lg-2"></td>
			</tr>

			<c:forEach var="mList" items="${list}">
				<tr>
					<td>${mList.memname}</td>
					<td>${mList.meminmail}</td>
					<td>${mList.dename}</td>
					<td>${mList.memjob}</td>
					<td>${mList.pyearly}</td>
					<td>${mList.psalary}</td>
					<td>
					<input type="button" class="btn btn-default btn-sm" value="추가급지급"
					onclick="javascript:getMemInfoForModal('giveBonus',${mList.memnum})">
					<input type="button" class="btn btn-default btn-sm" value="월급여지급"
					onclick="javascript:getMemInfoForModal('giveSalary',${mList.memnum})">
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>
<div id="modalTarget"></div>
<!-- List (E) -->


		<!-- paging(S) -->
		<div class="paging" id="paging">
		<input type="hidden" name="page" id="page">
		<input type="hidden" id="memdept" name="memdept" value="${pdept}">
		<input type="hidden" id="memname" name="memname" value="${pname}">
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<a class="page-first" href="javascript:goPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock },'payManagementPage')">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'payManagementPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
			            <a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'payManagementPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="javascript:goPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 },'payManagementPage')">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- paging(E) -->
		

