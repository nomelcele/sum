<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
			<!-- heading-page(S) -->
			<h2 class="heading-page">${sessionScope.bname }</h2>
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
						<td>${board.bwriter }</td>
						<th>작성일</th>
						<td>${board.bdate }</td>
						<th>글번호</th>
						<td>${board.bnum }</td>
						<th>조회수</th>
						<td>${board.bhit }</td>
					</tr>
					<tr>
						<th>글제목</th>
						<td colspan="7" class="board-detail-title">${board.btitle }</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td colspan="8" class="board-detail-article">
							<div><div>${board.bcont}</div></div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button-div">
				<div class="left">
					<c:if test="${sessionScope.v.memnum eq board.bmem }">
						<button type="button" onclick="javascript:formGo('d')">글삭제</button>
					</c:if>
				</div>
				<div class="right">
					<button type="button">수정</button>
					<button type="button" onclick="javascript:formGo('list')">목록</button>
					<button type="button" onclick="javascript:formGo('write')">새글쓰기</button>
				</div>
			</div>
			
<!-- comment(S) -->
			<div class="wrap2" id="coTarget">
				<h2 class="tit-comment">댓글 작성하기</h2>
				<!-- comment-list(S) -->
				<ul class="comment-list">
				<c:forEach var="clist" items="${clist }">
					<li>
						<img class="comment-img" src="resources/profileImg/${clist.coimg }" alt="" />
						<div>
							<strong>${clist.coname }</strong>
							<p>${clist.cocont }</p>
							<span class="date">${clist.codate }</span>
						</div>
						<!-- 작성자일 경우에만 노출 됨  -->
						<c:if test="${sessionScope.v.memname eq clist.coname }">
						<span class="comment-btn">
							<button type="button" onclick="javascript:commDelete(${clist.conum},${clist.coboard })">삭제</button>
						</span>
						</c:if>
						<!-- 작성자일 경우에만 노출 됨  -->
					</li>
				</c:forEach>
				</ul>
				<!-- comment-list(E) -->
				
				<!-- comment-write(S) -->
			<form action="commIn" id="cform" method="post">
				<input type="hidden" name="memnum" value="${sessionScope.v.memnum }">
				<input type="hidden" name="bnum" value="${board.bnum }">
				<input type="hidden" name="no" value="${board.bnum }">
				<input type="hidden" name="bgnum" value="${sessionScope.bbbgnum }">
				<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
				<input type="hidden" name="bname" value="${sessionScope.bname }">
				<div class="comment-write">
					<textarea name="cocont" id="cocont" rows="10" cols="10" placeholder="댓글 내용을 입력해 주세요."></textarea>
					<button class="btn-comm" type="button" onclick="javascript:commIn(${sessionScope.v.memnum},${board.bnum})">댓글 등록</button>
				</div>
			</form>
				<!-- comment-write(E) -->
			</div>
			
			
<!-- comment(E) -->
			<!-- 리스트 form -->
			<form action="boardList" method="post" id="listForm">
				<input type="hidden" name="model" value="board">
				<input type="hidden" name="page" value="1">
				<input type="hidden" name="bgnum" value="${sessionScope.bbbgnum }">
				<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
				<input type="hidden" name="bname" value="${sessionScope.bname }">
			</form>
			<!-- 글작성 form -->
			<form action="boardWrite" method="post" id="writeForm">
				<input type="hidden" name="bgnum" value="${sessionScope.bbbgnum}">
				<input type="hidden" name="bname" value="${sessionScope.bname}">
				<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept}">
				<input type="hidden" name="submod" value="writeForm">
			</form>
			<!-- 글 삭제 form -->
			<form action="boardDelete" method="post" id="dform">
				<input type="hidden" name="page" value="1">
				<input type="hidden" name="bmem" value="${sessionScope.v.memnum }">
				<input type="hidden" name="bgnum" value="${sessionScope.bbbgnum }">
				<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
				<input type="hidden" name="bname" value="${sessionScope.bname }">
				<input type="hidden" name="bnum" value="${board.bnum }">
			</form>