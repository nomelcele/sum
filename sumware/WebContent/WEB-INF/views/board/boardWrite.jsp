<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<div id="stboardWriter">
			<!-- <table id="stTitle">
				<tr>
					<td>현재 페이지 : 스터디게시판 작성폼</td>
				</tr>
			</table> -->
			
			<!-- heading(S) -->
			<h2 class="title-board"> ${sessionScope.bname } </h2>
			<!-- heading(E) -->
				<form action="saboardInsert" method="post" id="boardInsert">
					<input type="hidden" name="model" value="board">
					<input type="hidden" name="page" value="1">
					<input type="hidden" name="bmem" value="${sessionScope.v.memnum }">
					<input type="hidden" name="bgnum" value="${sessionScope.bbbgnum }">
					<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
					<input type="hidden" name="bname" value="${sessionScope.bname }">
					<input type="hidden" name="bimg">
					<input type="hidden" name="bsearch">
					<input type="hidden" name="div">
				<!-- board-write(S) -->
				<table id="stcontent" class="board-list board-write">
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
							<label id="bwriter" >${sessionScope.v.memname }</label>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="td content2"><textarea rows="10" cols="30"
								name="bcont" id="bcont" class="instyle"></textarea></td>
					</tr>
				</table>
				<!-- board-write(E) -->
				<!-- button-div(S) -->
				<div class="button-div center">
					<button type="button" onclick="javascript:formGo('insert')">글작성</button>
					<button type="button"onclick="location='sumware?model=board&submod=boardList&page=1&bdeptno=${sessionScope.v.memdept }&bgnum=${sessionScope.bbbgnum}&bname=${sessionScope.bname }'">리스트</button>
				</div>
			</form>
				<!-- button-div(E) -->
		</div>
