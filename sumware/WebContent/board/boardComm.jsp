<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- CommentPage(S) --%>
<div class="wrap2">

	<h2 class="tit-comment">댓글 작성하기</h2>
	<!-- comment-list(S) -->
	<ul class="comment-list">
		<li>
			<img class="comment-img" src="img/pic.PNG" alt="" />
			<div>
				<strong>홍길동</strong>
				<p>댓글내용입니다.</p>
				<span class="date">2015-05-26</span>
			</div>
			<!-- 작성자일 경우에만 노출 됨  -->
			<span class="comment-btn">
				<button type="button">수정</button>
				<button type="button">삭제</button>
			</span>
			<!-- 작성자일 경우에만 노출 됨  -->
		</li>
		<li>
			<img class="comment-img" src="img/pic.PNG" alt="" />
			<div>
				<strong>홍길동</strong>
				<p>댓글내용입니다.</p>
				<span class="date">2015-05-26</span>
			</div>
		</li>
	</ul>
	<!-- comment-list(E) -->
	
	<!-- comment-write(S) -->
	<div class="comment-write">
		<textarea rows="10" cols="10" placeholder="댓글 내용을 입력해 주세요."></textarea>
		<button type="button" class="btn-comm">댓글 등록</button>
	</div>
	<!-- comment-write(E) -->
</div>