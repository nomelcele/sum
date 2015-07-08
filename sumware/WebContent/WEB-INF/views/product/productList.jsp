<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2 class="heading-page">중고경매장터</h2>
<div class="left">
	<a href="javascript:" class="btn btn-info"> <span
		class="glyphicon glyphicon-pencil"></span> 상품 등록
	</a>
</div>

<div style="margin-top: 10px;">
	<table class="table table-condensed table-hover" id="listTable">
		<tbody>
			<tr style="background-color: #F5F5F5;">
				<td class="col-lg-1">
					<input type="checkbox" name="all" onclick="checkAll(this)">
				</td>
				<td class="col-lg-1"><span></span></td>
				<td class="col-lg-1"><span>받는 사람</span></td>
				<td class="col-lg-6"><span>제목</span></td>
				<td class="col-lg-2"><span>보낸 날짜</span></td>
			</tr>
			<c:forEach var="mList" items="${list}">
				<tr>
					<td><input type="checkbox" name="chk" id="chk" value="${mList.mailnum}"></td>
					<td><a href="javascript:mailDetailGo(${mList.mailnum})">${mList.mailtitle}</a></td>
					<td>${mList.maildate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>





<!-- paging(S) -->
<div class="paging" id="paging">
	<form action="boardList" method="post" id="plist">
		<input type="hidden" name="model" value="board"> <input
			type="hidden" name="bgnum" value="${sessionScope.bbbgnum}"> <input
			type="hidden" name="bname" value="${sessionScope.bname }"> <input
			type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
		<input type="hidden" name="page" id="page"> <input
			type="hidden" name="bsearch" value="${sessionScope.boardSearch}">
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
				<input type="hidden" name="page"
					value="${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">
			</c:otherwise>
		</c:choose>
	</form>
</div>
<!-- paging(E) -->