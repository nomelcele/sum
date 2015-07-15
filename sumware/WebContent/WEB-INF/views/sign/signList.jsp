<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<form method="post" action="getSignList">
		<input type="hidden" name="page" value="1">
	<div>검색</div>
	<div>
		<table class="table table-condensed table-hover">
			<tbody>
				<tr style="background-color: #F5F5F5;">
					<td class="col-lg-1"><span>번호</span></td>
					<td class="col-lg-1"><span>문서 종류</span></td>
					<td class="col-lg-4"><span>제목</span></td>
					<td class="col-lg-1"><span>기안자</span></td>
					<td class="col-lg-4"><span>기안일</span></td>
					<td class="col-lg-1"><span>결재상태</span></td>
				</tr>
				<c:forEach var="sg" items="${sgList }">
					<tr>
						<td class="col-lg-1"><span>${sg.snum}</span></td>
						<td class="col-lg-1"><span>${sg.sfname }</span></td>
						<td class="col-lg-4"><span><a href="signDetail?snum=${sg.snum }">${sg.stitle }</span></td>
						<td class="col-lg-1"><span>${sg.memname }</span></td>
						<td class="col-lg-4"><span>${sg.startdate } ~ ${sg.enddate}</span></td>
						<c:choose>
							<c:when test="${!empty sg.sgreturncomm }">
								<td class="col-lg-1"><span>반려문서</span></td>
							</c:when>
							<c:when test="${sg.ycount ne sg.count }">
								<td class="col-lg-1"><span>진행중(${sg.ycount }/${sg.count })</span></td>	
							</c:when>
							<c:otherwise>
								<td class="col-lg-1"><span>완료</span></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</form>
	<%-- 원래 위치 --%>
	<div class="paging">
		<c:set var="pageUrl" value="getSignList?signdiv=${signdiv}"/>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<%-- <button type="button" class="paging-prev">&lt;&lt;</button> --%>
					<a class="page-first" href="${pageUrl}&page=${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
			            <a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="${pageUrl}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
	</div>
	<div class='modal' id='signModal' role='dialog'>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">결재 문서 선택하기</h4>
				</div>
				<div class="modal-body" id="signModalBody">
				</div>
			</div>
		</div>
	</div>
</div>