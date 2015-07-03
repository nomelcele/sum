<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2 class="tit-comment">댓글 작성하기</h2>
<ul class="comment-list">
	<c:forEach var="colist" items="${clist }">
		<li>
			<img class="comment-img" src="resources/profileImg/${colist.coimg }" alt="" />
			<div>
				<strong>${colist.coname }</strong>
				<p>${colist.cocont }</p>
				<span class="date">${colist.codate }</span>
			</div>
			<c:if test="${sessionScope.v.memname eq colist.coname }">
				<span class="comment-btn">
					<button type="button">수정</button>
					<button type="button">삭제</button>
				</span>
			</c:if>
		</li>
	</c:forEach>
</ul>

<div class="comment-write">
	<textarea name="cocont" rows="10" cols="10" placeholder="댓글 내용을 입력해 주세요."></textarea>
	<button class="btn-comm" type="button"
		onclick="javascript:formSub('c')">댓글 등록</button>
</div>
