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
		<div class="contents">
			<!-- board-detail(S) -->
			<div class="board-detail">
				<div class="left">
					<span>${sessionScope.bdate }</span>
				</div>
				<div class="right">
					<form action="sumware" method="post">
						<input type="hidden" name="model" id="model">
						<button name="submod" id="submod" value="javascript:formGo('update')">수정</button>
						<button name="submod" id="submod" value="javascript:formGo('list')">리스트</button>
						<input type="hidden" name="submod" id="submod">
					</form>
				</div>
			</div>
			<!-- board-detail(E) -->
			
			<table class="board-detail">
				<!-- table cell width setting -->
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
				<tbody>
					<tr>
						<td>${list.bcont}</td>
					</tr>
				</tbody>
			</table>
			
			
			<!-- paging(S) -->
			<div class="">
				<button>글수정</button>
				<button>리스트</button>
			</div>
	<%-- 	<c:set var="pageUrl" value="sumware?mod=board&submod=boardList"/>
			<%@include file="page.jsp" %> --%>
			
			<!-- paging(E) -->
			
			
		</div>
		<!-- contents(E) -->
</div>
<%@include file="/footer.jsp" %>