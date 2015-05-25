<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/top.jsp" %>
<script>
	$(function(){
		$('#mod').click(function(){
			$(this).attr("value","board");
			$('#submod').attr("value","writeForm");
			$('form').submit();
		});
	});
</script>
	<div id="wrap" class="board">
		<!-- lnb-area(S) -->
		<div class="lnb-area">
		left
		</div>
		<!-- lnb-area(E) -->
	
	
		<!-- contents(S) -->
		<div class="contents">
			<!-- board-form(S) -->
			<div class="board-form">
				<div class="left">
					<!-- 넣고싶은거 -->
				</div>
				<div class="right">
					<form action="sumware" method="post">
						<button name="model" id="mod">글쓰기</button>
						<input type="hidden" name="submod" id="submod">
					</form>
				</div>
			</div>
			<!-- board-form(E) -->
			
			<!-- board-list(S) -->
			<table class="board-list">
				<!-- table cell width setting -->
				<colgroup>
					<col style="width:50px" />
					<col />
					<col style="width:100px" />
					<col style="width:70px" />
					<col style="width:50px;text-align:center" />
				</colgroup>
				<!-- table cell width setting -->
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
						<td style="text-align: left">${vlist.btitle }</td>
						<td>${vlist.bwriter }</td>
						<td>${vlist.bdate }</td>
						<td>${vlist.bhit }</td>
					</tr>
					</c:forEach>
				</tbody>
				<%-- 반복 구간 끝 --%>
			</table>
			<!-- board-list(E) -->
			
			
			<!-- paging(S) -->
			<div class="paging">
				<button type="button" class="paging-prev">&lt;&lt;</button>
				<ul>
					<li>1</li>
					<li>2</li>
					<li>3</li>
					<li>4</li>
					<li>5</li>
				</ul>
				<button type="button" class="paging-next">&gt;&gt;</button>
			</div>
	<%-- 	<c:set var="pageUrl" value="sumware?mod=board&submod=boardList"/>
			<%@include file="page.jsp" %> --%>
			
			<!-- paging(E) -->
			
			
		</div>
		<!-- contents(E) -->
	</div>
	
<%@include file="/footer.jsp" %>
