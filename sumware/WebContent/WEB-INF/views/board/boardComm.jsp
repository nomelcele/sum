<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="resources/css/boardCSS.css" />
		<c:if test="${empty sessionScope.adminv.memdept}">
			<h2 class="tit-comment">댓글 작성하기</h2>
			</c:if>
			<c:if test="${not empty sessionScope.adminv.memdept}">
				<h2 class="tit-comment">댓글 목록</h2>
			</c:if>
<ul class="comment-list">
	<c:forEach var="colist" items="${clist }">
		<li>
			<img class="comment-img" src="resources/profileImg/${colist.coimg }" alt="" />
			<div>
				<strong>${colist.coname }</strong>
				<p>${colist.cocont }</p>
				<span class="date">${colist.codate }</span>
			</div>
			<c:if test="${sessionScope.v.memname eq colist.coname || not empty sessionScope.adminv.memdept}">
				<span class="comment-btn">
					<button type="button" onclick="javascript:commDelete(${colist.conum},${colist.coboard })">삭제</button>
				</span>
			</c:if>
		</li>
	</c:forEach>
</ul>
<!-- boardComm.jsp -->
<div class="comment-write">
<c:if test="${empty sessionScope.adminv.memdept}">
	<textarea name="cocont" id="cocont" rows="10" cols="10" placeholder="댓글 내용을 입력해 주세요."></textarea>
	<button class="btn-comm" type="button"
		onclick="javascript:commIn(${sessionScope.v.memnum},${board})">댓글 등록</button>
</c:if>
</div>
