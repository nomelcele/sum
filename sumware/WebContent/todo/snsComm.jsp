<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- comment-list(S) -->
	<c:if test="${!empty commSnsList}">
	<ul class="comment-list"  style="height:400px; overflow-y:scroll;">
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
				<button type="button" onclick="snsCommDelete(${csl.conum },${commsns})">삭제</button>
			</span>
			</c:if>
			<!-- 작성자일 경우에만 노출 됨  -->
		</li>
	</c:forEach>
	</ul>
		<button type="button" onclick="snsCommListPlus(${commsns})" style="width: 90%; height: 50px; text-align: center; margin-left: 30px;">더 보기</button>
	</c:if>

	<!-- comment-list(E) -->
	
	<!-- comment-write(S) -->
	</div>
		<div class="modal-footer">
		<!-- comment-write(S) -->
		<div class="comment-write">
			<input style="width: 450px;"type="text" id="cocont" name="cocont" placeholder="댓글 내용을 입력해 주세요.">
			<button type="button" class="btn-snscomm" onclick="snsInsertComm(${commsns})">등록</button>
		</div>
		</div>
	<!-- comment-write(E) -->