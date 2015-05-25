<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/top.jsp" %>
<c:if test="${param.submod eq 'writeForm' }">
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
	<script src="js/myckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			chkUpload();
		});
	</script>
</c:if>
<div id="wrap" class="board">
		<!-- lnb-area(S) -->
	<div class="lnb-area">
		left
	</div>
		<!-- lnb-area(E) -->
	
	
		<!-- contents(S) -->
	<div id="content2" class="contents">
		<div id="stboardWriter">
			<!-- <table id="stTitle">
				<tr>
					<td>현재 페이지 : 스터디게시판 작성폼</td>
				</tr>
			</table> -->
			
			<!-- heading(S) -->
			<h2 class="title-board">현재 페이지 : 스터디게시판 작성폼</h2>
			<!-- heading(E) -->
			
			
			<form action="sumware" method="post">
				<input type="hidden" name="model" id="model"> 
				<input type="hidden" name="submod" id="submod">
				<input type="hidden" name="page" id="page">
				
				<!-- board-write(S) -->
				<table id="stcontent" class="board-list board-write">
					<!-- <tr>
						<td colspan="2">스터디 게시판 작성폼</td>
					</tr> -->
					<colgroup>
						<col style="width:80px" />
						<col />
					</colgroup>
					<tr>
						<th>제목</th>
						<td class="td title">
							<input name="btitle" id="btitle">
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td class="td writer">
							<input name="bwriter" id="bwriter" readonly="readonly"value="${sessionScope.v.memname }" />
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="td content2"><textarea rows="10" cols="30"
								name="bcont" id="bcont" class="instyle"></textarea></td>
						<input type="hidden" name="bgnum" value="1">
						<input type="hidden" name="bmem" value="${sessionScope.v.memnum }">
					</tr>
				</table>
				<!-- board-write(E) -->
				
				<!-- button-div(S) -->
			<div class="button-div center">
				<button onclick="javascript:formGo('insert')">글작성</button>
				<button onclick="javascript:formGo('list')">리스트</button>
			</div>
				<!-- button-div(E) -->
			</form>
		</div>
	</div>
	<!-- contents(E) -->
</div>
<%@include file="/footer.jsp" %>