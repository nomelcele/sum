<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2 class="heading-page">중고경매장터</h2>
<div class="left" id="auctionBtn1">
	<button type="button" class="btn btn-info btn-lg" id="productWrite">상품등록</button> 
</div>
<form action="sawriteForm" id="aucForm">
<div style="margin-top: 10px;" class="auction">
	<table>
		<tbody>
			<tr>
				<th>상품이미지</th>
				<th>상품명</th>
				<th>시작가</th>
				<th>현재가격</th>
				<th>입찰 횟수</th>
				<th>판매자</th>
				<th>종료일시</th>
				<th>판매상태</th>
			</tr>
		<c:forEach var="list" items="${plist}">
			<tr>
				<td><img src="aucImg/${list.proimg }" style="width: 40px; height: 40px; cursor: pointer;" id="proimg" onclick="detailGo(${list.pronum})"></td>
				<td>${list.product}</td>
				<td>${list.startprice} 원</td>
				<td>${list.price} 원</td>
				<td>${list.procount}</td>
				<td>${list.memname}</td>
				<td>${list.enddate}</td>
				<c:choose>
					<c:when test="${list.status eq 'n' }">
						<td><button type="button" class="btn btn-theme btn-xs" style="width:76px" onclick="detailGo(${list.pronum})">판매중</button></td>
					</c:when>
					<c:otherwise>
						<td><button type="button" class="btn btn-theme04 btn-xs" style="width:76px">판매완료</button></td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</form>


<!-- paging(S) -->
<div class="paging" id="paging">
	<form action="saboardList" method="post" id="plist">
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

<div id="mTarget"></div>
