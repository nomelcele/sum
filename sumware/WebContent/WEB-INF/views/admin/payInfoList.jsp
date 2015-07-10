<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		onclick="adminSelectMenu('adminPayInfoList')"> <br />
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
				<td class="col-lg-1"></td>
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
					<td><input type="button" class="btn btn-default btn-sm"
						value="급여내역"
						onclick="adminPay('adminPayInfoDetail',${mList.memnum})"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>
<!-- List (E) -->




<!-- Modal(S) -->
<!-- <div class="modal fade" id="payDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"> -->
<!-- 	  <div class="modal-dialog" role="document"> -->
<!-- 	    <div class="modal-content"> -->
<!-- 	      <div class="modal-header"> -->
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
<!-- 				<h4 class="modal-title">급여 내역</h4> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<!-- 				<table class="table table-condensed table-hover"> -->
<!-- 					<tr> -->
<%-- 						<td rowspan="4" class="col-lg-2"><img src="../resources/profileImg/${memvo.memprofile}"></td> --%>
<%-- 						<td class="col-lg-1">이름</td><td class="col-lg-2">${memvo.memname}</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<%-- 						<td class="col-lg-1">직급</td><td class="col-lg-2">${memvo.memjob}</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<%-- 						<td class="col-lg-1">호봉</td><td class="col-lg-2">${payvo.pyearly}</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<%-- 						<td class="col-lg-1">연봉</td><td class="col-lg-2">${payvo.psalary}</td> --%>
<!-- 					</tr> -->
<!-- 				</table> -->
<!-- 				<table class="table table-condensed table-hover"> -->
<!-- 					<tbody> -->
<!-- 						<tr> -->
<!-- 							<td class="col-lg-1">날짜</td> -->
<!-- 							<td class="col-lg-1">월급</td> -->
<!-- 							<td class="col-lg-1">추가급</td> -->
<!-- 							<td class="col-lg-1">합계</td> -->
<!-- 							<td class="col-lg-1"></td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td class="col-lg-1">날짜</td> -->
<!-- 							<td class="col-lg-1">월급</td> -->
<!-- 							<td class="col-lg-1">추가급</td> -->
<!-- 							<td class="col-lg-1">합계</td> -->
<!-- 							<td class="col-lg-1"></td> -->
<!-- 						</tr> -->
<!-- 					</tbody> -->
<!-- 				</table> -->
			
<!-- 			</div> -->
			
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="submit" class="btn btn-default" data-dismiss="modal" -->
<!-- 					onclick="javascript:todoConfirm('rejectTodo')">보내기</button> -->
<!-- 			</div> -->
<!-- 		</div> -->

<!-- 	</div> -->
<!-- </div> -->
<!-- Modal(E) -->

		<!-- paging(S) -->
		<div class="paging" id="paging">
		<input type="hidden" name="page" id="page">
		<input type="hidden" id="memdept" name="memdept" value="${pdept}">
		<input type="hidden" id="memname" name="memname" value="${pname}">
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<a class="page-first" href="javascript:goPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock },'payListPage')">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'payListPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
			            <a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'payListPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="javascript:goPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 },'payListPage')">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- paging(E) -->
