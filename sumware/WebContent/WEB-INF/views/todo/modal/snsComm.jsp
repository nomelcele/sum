<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- comment-list(S) -->
	<c:if test="${!empty commSnsList}">
	<ul class="comment-list"  id="snsCommList" onscroll="snsCommScroll(${commsns})"
	style="height: 400px; overflow-y:scroll; ">
	<c:forEach var="csl" items="${commSnsList }">
		<li>
			<img class="snscomment-img" src="resources/profileImg/${csl.coimg }" alt="" />
			<div>
				<strong>${csl.coname }</strong>
				<p>${csl.cocont }</p>
				<span class="date">${csl.codate }</span>
			</div>
			<!-- 작성자일 경우에만 노출 됨  -->
			<c:if test="${sessionScope.v.memnum eq csl.comem }">
			<span class="comment-btn">
				<button type="button" onclick="snsCommDelete(${csl.conum },${commsns})">삭제</button>
			</span>
			</c:if>
			<!-- 작성자일 경우에만 노출 됨  -->
		</li>
	</c:forEach>
	</ul>
		<div id="commloading" style="width: 100%; float:left; text-align: center;">
		</div>
	</c:if>

	<!-- comment-list(E) -->
	
	<!-- comment-write(S) -->
		<div class="modal-footer">
		<!-- comment-write(S) -->
		<div class="comment-write">
			<input style="width: 450px;"type="text" id="cocont" name="cocont" placeholder="댓글 내용을 입력해 주세요." onkeydown="enterCheck(2)">
			<button type="button" class="btn-snscomm" onclick="snsInsertComm(${commsns},${sessionScope.v.memnum})">등록</button>
		</div>
		</div>
	<!-- comment-write(E) -->