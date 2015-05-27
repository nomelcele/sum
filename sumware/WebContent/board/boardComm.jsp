<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- CommentPage(S) --%>
<div class="wrap2">
	<h2 class="tit-comment">댓글 작성하기</h2>
	<!-- comment-list(S) -->
	<ul class="comment-list">
	<c:forEach var="clist" items="${clist }">
		<li>
			<img class="comment-img" src="profileImg/${clist.coimg }" alt="" />
			<div>
				<strong>${clist.coname }</strong>
				<p>${clist.cocont }</p>
				<span class="date">${clist.codate }</span>
			</div>
			<!-- 작성자일 경우에만 노출 됨  -->
			<c:if test="${sessionScope.v.memname eq clist.coname }">
			<span class="comment-btn">
				<button type="button">수정</button>
				<button type="button">삭제</button>
			</span>
			</c:if>
			<!-- 작성자일 경우에만 노출 됨  -->
		</li>
	</c:forEach>
	</ul>
	<!-- comment-list(E) -->
	
	<!-- comment-write(S) -->
	<div class="comment-write">
		<textarea rows="10" cols="10" placeholder="댓글 내용을 입력해 주세요."></textarea>
		<button type="button" class="btn-comm">댓글 등록</button>
	</div>
	<!-- comment-write(E) -->
</div>