<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/top.jsp" %>
<div id="wrap" class="board">
		<form action="sumware">
			<input type="hidden" name="model" id="model">
			<input type="hidden" name="submod" id="submod">
			<input type="hidden" name="page" id="page">
		</form>
		<!-- lnb-area(S) -->
		<div class="lnb-area">
		left
		</div>
		<!-- lnb-area(E) -->
		
		<!-- contents(S) -->
		<div class="contents">
			<%-- <!-- board-detail(S) -->
			<div class="board-list board-detail">
				<div class="left">
					<span>${list.bdate }</span>
				</div>
				<div class="right">
					<form action="sumware" method="post">
						<input type="hidden" name="model" id="model">
						<button name="submod" id="submod" value="javascript:formGo('update')">수정</button>
						<button name="submod" id="submod" value="javascript:formGo('list')">목록</button>
						<input type="hidden" name="submod" id="submod">
					</form>
				</div>
			</div>
			<!-- board-detail(E) --> --%>
			
			
			<!-- heading-page(S) -->
			<h2 class="heading-page">게시글 보기</h2>
			<!-- heading-page(E) -->
			
			<!-- board-detail(S) -->
			<table class="board-detail board-list">
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
				<!-- table cell width setting -->
				<!-- <thead>
					<tr>
						<td>글제목</td>
						<td>작성자</td>
						
						<td>글번호</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead> -->
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
			
			
			<!-- paging(S) -->
			<div class="button-div">
				<div class="left">
					<button type="button">글삭제</button>
				</div>
				<div class="right">
					<button type="button">수정</button>
					<button type="button" onclick="javascript:formGo('list')">목록</button>
					<button type="button" onclick="javascript:formGo('write')">새글쓰기</button>
				</div>
			</div>
			
	<%-- 	<c:set var="pageUrl" value="sumware?mod=board&submod=boardList"/>
			<%@include file="page.jsp" %> --%>
			
			<!-- paging(E) -->
		</div>
		<!-- contents(E) -->
</div>
<%@include file="/footer.jsp" %>