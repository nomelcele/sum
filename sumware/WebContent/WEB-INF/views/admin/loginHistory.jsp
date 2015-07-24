<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Search (S) -->
		<div style="border: solid; padding-top: 15px; padding-left: 15px">
			<p><span style="font-weight: bold">부 서 : </span>
			<select id="searchDept">
				<option value="0">전 체</option>
				<option value="100">인사부</option>
				<option value="200">총무부</option>
				<option value="300">영업부</option>
				<option value="400">전산부</option>
				<option value="500">기획부</option>
			</select>
			<span style="font-weight: bold; margin-left: 15px">직 급 : </span>
			<select class="controls" id="searchJob">
				<option value="0">전 체</option>
				<option value="1">대표이사</option>
				<option value="2">이사</option>
				<option value="3">부장</option>
				<option value="4">팀장</option>
				<option value="5">사원</option>
			</select>
			<span style="font-weight: bold; margin-left: 15px">접속일 : </span>
				<input type="date" id="lostdate"> ~ <input type="date" id="loendate">
					<span style="font-weight: bold; margin-left: 15px">이 름 : </span>
					<input type="text" id="searchName" placeholder="사원 이름">
			</p>
			<p style="text-align: right">
				<input type="button" class="btn btn-default btn-sm" value="검색" style=" margin-right: 25px" onclick="adminSelectMenu('loginHistory')">
			</p>

		</div>
		<br/>
	<!-- Search (E) -->
	
	<!-- List (S) -->
    	<div>
			<table class="table table-condensed table-hover" id="listTable">
				<tbody>
					<tr style="background-color: #F5F5F5;">
						<td class="col-lg-1"><span>이름</span></td>
						<td class="col-lg-1"><span>부서</span></td>
						<td class="col-lg-1"><span>직급</span></td>
						<td class="col-lg-1" style="text-align: center"><span>로그인</span></td>
						<td class="col-lg-1" style="text-align: center"><span>로그아웃</span></td>
					</tr>
					
					<c:forEach var="log" items="${lgList}">
						<tr>
							<td>${log.memname}</td>
							<td>${log.dename}</td>
							<td>${log.memjob}</td>
							<td style="text-align: center">${log.lostdate}</td>
							<td style="text-align: center">${log.loendate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- List (E) -->
		
		<!-- paging(S) -->
		<div class="paging" id="paging">
		<input type="hidden" name="page" id="page">
		<input type="hidden" id="memdept" name="memdept" value="${pdept}">
		<input type="hidden" id="memname" name="memname" value="${pname}">
		<input type="hidden" id="pmemauth" name="pmemauth" value="${pauth}">
		<input type="hidden" id="plostdate" name="plostdate" value="${plostdate}">
		<input type="hidden" id="ploendate" name="ploendate" value="${ploendate}">
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<a class="page-first" href="javascript:goPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock },'loginHistoryPage')">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'loginHistoryPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
			            <a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'loginHistoryPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="javascript:goPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 },'loginHistoryPage')">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- paging(E) -->