<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/top.jsp" %>
<div id="wrap" class="board">
		<!-- lnb-area(S) -->
	<div class="lnb-area">
		left
	</div>
		<!-- lnb-area(E) -->
		<!-- contents(S) -->
<!-- <form id= "bform"action="sumware" method="post"> -->
<!-- 	<input type="hidden" name="model" id="model"> -->
<!-- 	<input type="hidden" name="submod" id="submod"> -->
	<div class="contents">
			<!-- board-form(S) -->
		<div class="board-form">
			<div class="left">
					<input type="text" name="search" placeholder="search">				
			</div>
			<div class="right">
						<button onclick="javascript:formGo('write')">글쓰기</button>
			</div>
		</div>
			<!-- board-form(E) -->
			
			<!-- board-list(S) -->
		<table class="board-list">
				<!-- table cell width setting(S) -->
			<colgroup>
					<col style="width:50px" />
					<col />
					<col style="width:80px" />
					<col style="width:80px" />
					<col style="width:50px;" />
			</colgroup>
				<!-- table cell width setting(E) -->
				<thead>
					<tr>
						<td>글번호</td>
						<td>글제목</td>
						<td>작성자</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead>
				<%-- 반복 구간 시작 --%>
				<tbody>
					<c:forEach items="${list }" var="vlist">
					<tr>
						<td class="num">${vlist.bnum }</td>
						<td style="text-align: left"><a href="sumware?model=board&submod=boardDetail&no=${vlist.bnum }">${vlist.btitle }</a></td>
						<td style="text-align: center;">${vlist.bwriter }</td>
						<td style="text-align: center;">${vlist.bdate }</td>
						<td style="text-align: center;">${vlist.bhit }</td>
					</tr>
					</c:forEach>
				</tbody>
				<%-- 반복 구간 끝 --%>
		</table>
			<!-- board-list(E) -->
			
			<!-- paging(S) -->
		<div class="paging">
			<c:set var="pageUrl" value="sumware?model=board&submod=boardList"/>
			<%@include file="page.jsp" %>
		</div>
				<!-- <button type="button" class="paging-prev">&lt;&lt;</button>
				<ul>
					<li>1</li>
					<li>2</li>
					<li>3</li>
					<li>4</li>
					<li>5</li>
				</ul>
				<button type="button" class="paging-next">&gt;&gt;</button> -->
			<!-- paging(E) -->
	</div>
<!-- </form> -->
		<!-- contents(E) -->
</div>
<%@include file="/footer.jsp" %>