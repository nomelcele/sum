<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/top.jsp" %>
<div id="wrap" class="board">
		<!-- lnb-area(S) -->
		<div class="lnb-area">
		<%@include file="/contentLeft.jsp" %>
		</div>
		<!-- lnb-area(E) -->
		
		<!-- contents(S) -->
		<div class="contents">
			<%-- <!-- board-detail(S) -->
			<!-- board-detail(E) --> --%>
			
			<!-- heading-page(S) -->
			<h2 class="heading-page">게시글 보기</h2>
			<!-- heading-page(E) -->
			
			<!-- board-detail(S) -->
			<table class="board-detail board-list">
				<!-- table cell width setting -->
				<colgroup>
					<col style="width:80px">
					<col>
					<col style="width:65px">
					<col style="width:120px">
  					<col style="width:65px">
  					<col style="width:100px">
					<col style="width:65px">
					<col style="width:100px">
				</colgroup>
				<!-- table cell width setting -->
				<tbody class="info">
					<tr>
						<th>작성자</th>
						<td>${list.bwriter }</td>
						<th>작성일</th>
						<td>${list.bdate }</td>
						<th>글번호</th>
						<td>${list.bnum }</td>
						<th>조회수</th>
						<td>${list.bhit }</td>
					</tr>
					<tr>
						<th>글제목</th>
						<td colspan="7" class="board-detail-title">${list.btitle }</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td colspan="8" class="board-detail-article">
							<div><div>${list.bcont}</div></div>
						</td>
					</tr>
				</tbody>
			</table>
			
			
			<div class="button-div">
				<div class="left">
					<button type="button">글삭제</button>
				</div>
				<div class="right">
					<button type="button">수정</button>
					<button type="button" onclick="location='sumware?model=board&submod=boardList&page=1'">목록</button>
					<button type="button" onclick="location='sumware?model=board&submod=writeForm'">새글쓰기</button>
				</div>
			</div>
			
<!-- comment(S) -->
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
			<form action="sumware" id="cform" method="post">
				<input type="hidden" name="model" value="board">
				<input type="hidden" name="submod"  value="boardDetail">
				<input type="hidden" name="childmod" value="commInsert">
				<input type="hidden" name="memnum" value="${sessionScope.v.memnum }">
				<input type="hidden" name="bnum" value="${list.bnum }">
				<input type="hidden" name="no" value="${list.bnum }">
				<div class="comment-write">
					<textarea name="comment"rows="10" cols="10" placeholder="댓글 내용을 입력해 주세요."></textarea>
					<button class="btn-comm">댓글 등록</button>
				</div>
			</form>
				<!-- comment-write(E) -->
			</div>
<!-- comment(E) -->
		</div>
		<!-- contents(E) -->
</div>
<%@include file="/footer.jsp" %>