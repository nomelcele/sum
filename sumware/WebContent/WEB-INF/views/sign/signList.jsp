<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<div>검색</div>
	<div>
		<input type="button" id="signWriteFListBtn" value="문서작성" onclick="signFormListModal()">
		<table>
			<tr>
				<td>번호</td>
				<td>문서 종류</td>
				<td>제목</td>
				<td>기안자</td>
				<td>기안일</td>
				<td>결재상태</td>						
			</tr>
		</table>
	</div>
	<div class='modal' id='signModal' role='dialog'>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">결재 문서 선택하기</h4>
				</div>
				<div class="modal-body" id="signModalBody">
				</div>
			</div>
		</div>
	</div>
</div>