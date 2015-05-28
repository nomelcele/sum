<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- comment-list(S) -->
	<ul class="comment-list">
	<c:if test="${!empty commSnsList}">
	<c:forEach var="csl" items="${commSnsList }">
		<li>
			<img class="snscomment-img" src="profileImg/${csl.coimg }" alt="" />
			<div>
				<strong>${csl.coname }</strong>
				<p>${csl.cocont }</p>
				<span class="date">${csl.codate }</span>
			</div>
			<!-- 작성자일 경우에만 노출 됨  -->
			<c:if test="${sessionScope.v.memnum eq csl.comem }">
			<span class="comment-btn">
				<button type="button">수정</button>
				<button type="button">삭제</button>
			</span>
			</c:if>
			<!-- 작성자일 경우에만 노출 됨  -->
		</li>
	</c:forEach>
	</c:if>
	</ul>
	<!-- comment-list(E) -->
	
	<!-- comment-write(S) -->
	<div class="comment-write">
		<input style="width: 300px;"type="text" name="cocont" placeholder="댓글 내용을 입력해 주세요.">
		<button type="button" class="btn-snscomm" onclick="snsInsertComm(${csl.commsns})">등록</button>
	</div>
	<!-- comment-write(E) -->