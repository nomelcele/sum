<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<div>검색</div>
	<div>
		<input type="button" id="signWriteFListBtn" value="문서작성" onclick="signFormListModal()">
		<table>
			<tr>
				<td>번호</td>
				<td>문서 종류</td>
				<td>제목</td>
				<td>기안자</td>
				<td>기안일</td>
				<td>결재상태</td>						
			</tr>
			<c:forEach var="sg" items="${sgList }">
				<tr>
					<td>${sg.snum}</td>
					<td>${sg.sfname }</td>
					<td><a href="signDetail?snum=${sg.snum }">${sg.stitle }</a></td>
					<td>${sg.memname }</td>
					<td>${sg.startdate } ~ ${sg.enddate}</td>
					<c:choose>
						<c:when test="${!empty sg.sgreturncomm }">
							<td>반려문서</td>
						</c:when>
						<c:when test="${sg.ycount ne sg.count }">
							<td>진행중(${sg.ycount }/${sg.count })</td>		
						</c:when>
						<c:otherwise>
							<td>완료</td>
						</c:otherwise>
					</c:choose>
				</tr>		
			</c:forEach>
		</table>
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