<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<h2 class="heading-page">${sessionScope.bname }</h2>
		<!-- board-form(S) -->
		<div class="board-form">
			<div class="left">
				<input type="text" name="search" placeholder="search">
			</div>
			<div class="right">
				<button type="button"
					onclick="location='sumware?model=board&submod=writeForm&bgnum=${sessionScope.bbbgnum}&bname=${sessionScope.bname }&bdeptno=${sessionScope.v.memdept }'">글쓰기</button>
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
			<form action="boardDetail"  method="POST"  id="detailForm">
				<input type="hidden"  name="model" value="board">
				<input type="hidden"  name="no" value="${vlist.bnum}">
				<input type="hidden"  name="bgnum" value="${sessionScope.bbbgnum }">
				<input type="hidden"  name="bname" value="${sessionScope.bname }">
				<input type="hidden"  name="bdeptno" value="${sessionScope.v.memdept}">
						<td class="num">${vlist.bnum }</td>
						<td style="text-align: left">
						<a href="">${vlist.btitle }</a></td>
						<td style="text-align: center;">${vlist.bwriter }</td>
						<td style="text-align: center;">${vlist.bdate }</td>
						<td style="text-align: center;">${vlist.bhit }</td>
			</form>
					</tr>
				</c:forEach>
			</tbody>
			<%-- 반복 구간 끝 --%>
		</table>
		<!-- board-list(E) -->

		<!-- paging(S) -->
		<div class="paging">
			<c:set var="pageUrl" value="sumware?model=board&submod=boardList&bdeptno=${sessionScope.v.memdept }&bgnum=${sessionScope.bbbgnum}" />
			<%@include file="page.jsp"%>
		</div>
		<!-- paging(E) -->