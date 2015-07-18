<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="resources/css/boardCSS.css" />
<form action="saboardWrite" method="post" id="writeForm">
	<input type="hidden" id="bgnum" name="bgnum" value="${sessionScope.bbbgnum}">
	<input type="hidden" name="bname" value="${sessionScope.bname}">
	<input type="hidden" id="bdeptno" name="bdeptno" value="${sessionScope.v.memdept}">
	<input type="hidden" name="submod" value="writeForm">
</form>
		<h2 class="heading-page">${sessionScope.bname }</h2>
		<!-- board-form(S) -->
		<div class="board-form">
			<div class="left">
			<c:choose>
				<c:when test="${not empty sessionScope.v.memdept}">
					<input type="text" id="bsearch" name="bsearch" placeholder="search" onkeyup="boardSearch(${sessionScope.bbbgnum},${sessionScope.v.memdept})">
				</c:when>
				<c:otherwise>
					<input type="text" id="bsearch" name="bsearch" placeholder="search" onkeyup="boardSearch(${sessionScope.bbbgnum},${sessionScope.adminv.memdept})">				
				</c:otherwise>
			</c:choose>				
				<div id="boardView" style="position:absolute; z-index:1;"></div>
			</div>
			<div class="right">
			<c:if test="${empty sessionScope.adminv.memdept}">
				<button type="button" onclick="javascript:formGo('write')" class="btn btn-info">글쓰기</button>
			</c:if>			
			</div>
		</div>
		<!-- board-form(E) -->

		<!-- board-list(S) -->
		<table class="board-list">
			<!-- table cell width setting(S) -->
			<colgroup>
				<col style="width: 50px" />
				<col />
				<col style="width: 80px" />
				<col style="width: 80px" />
				<col style="width: 50px;" />
			</colgroup>
			<!-- table cell width setting(E) -->
			<thead>
				<tr>
					<td>글번호</td>
					<td>글제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
			</thead>
			<%-- 반복 구간 시작 --%>
			<tbody>
				<c:forEach items="${list }" var="vlist">
					<tr>
						<td style="text-align: center;">${vlist.bnum }</td>
						<c:choose>
							<c:when test="${not empty sessionScope.v.memdept}">
								<td style="text-align: left"><span onclick="javascript:detail(${vlist.bnum },${sessionScope.bbbgnum},'${sessionScope.bname }',${sessionScope.v.memdept })" style="cursor: pointer;">${vlist.btitle }</span></td>
							</c:when>
							<c:otherwise>
								<td style="text-align: left"><span onclick="javascript:detail(${vlist.bnum },${sessionScope.bbbgnum},'${sessionScope.bname }',${sessionScope.adminv.memdept })" style="cursor: pointer;">${vlist.btitle }</span></td>
							</c:otherwise>
						</c:choose>						
						<td style="text-align: center;">${vlist.bwriter }</td>
						<td style="text-align: center;">${vlist.bdate }</td>
						<td style="text-align: center;">${vlist.bhit }</td>
					</tr>
				</c:forEach>
			</tbody>
			<%-- 반복 구간 끝 --%>
		</table>
		<!-- board-list(E) -->

	<c:choose>
		<c:when test="${not empty sessionScope.v.memdept}">
		<!-- paging(S) -->
		<div class="paging" id="paging">
		<form action="saboardList" method="post" id="plist">
		<input type="hidden" name="model" value="board">
		<input type="hidden" name="bgnum" value="${sessionScope.bbbgnum}"> 
		<input type="hidden" name="bname" value="${sessionScope.bname }"> 
		<input type="hidden" id="bdeptno" name="bdeptno" value="${sessionScope.v.memdept }">
		<input type="hidden" name="page" id="page">
		<input type="hidden" name="bsearch" value="${sessionScope.boardSearch}">
		<input type="hidden" name="div" value="${sessionScope.boardDiv }">
			<!-- 이전 페이지로 보내주는 화살표 -->
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<%-- <button type="button" class="paging-prev">&lt;&lt;</button> --%>
					<a class="page-first" href="">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<!-- 클릭시 해당 페이질 바로 이동!!!! -->
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach
						begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
						end="${pageInfo.totalPages}" varStatus="num">
						<a href="">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			<!-- 다음 페이지로 보내주는 화살표 -->
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="">&gt;&gt;</a>
		<input type="hidden" name="page" value="${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }"> 
				</c:otherwise>
			</c:choose>
		</form>
		</div>
		<!-- paging(E) -->	
		</c:when>
		<c:otherwise>
			<!-- paging(S) -->
			<!-- 관리자 페이지의 게시판 열람에서 접근했을 때의 페이지 처리  -->	
			<div class="paging" id="paging">
			<input type="hidden" name="page" id="page">
			<input type="hidden" id="adminBgnum" value="${sessionScope.bbbgnum}">
			<input type="hidden" id="adminDeptno" value="${sessionScope.adminv.memdept}">
			<input type="hidden" id="adminBsearch" value="${sessionScope.boardSearch}">
			<input type="hidden" id="adminDiv" value="${sessionScope.boardDiv }">
				<c:choose>
					<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
					<c:otherwise>
						<a class="page-first" href="javascript:goPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock },'adminBoardPage')">&lt;&lt;</a>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
						<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
							<a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'adminBoardPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
				        </c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
				            <a href="javascript:goPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count },'adminBoardPage')">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
				        </c:forEach>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
					<c:otherwise>
						<a class="page-last" href="javascript:goPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 },'adminBoardPage')">&gt;&gt;</a>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- paging(E) -->
		</c:otherwise>
	</c:choose>

		