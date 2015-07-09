<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<form action="done" method="post" id="doneForm">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">상품등록</h4>
			</div>
			<div class="modal-body auction">
				<table border="1">
				<tbody>
					<tr>
						<td colspan="2" style="text-align: left;">&nbsp;&nbsp;&nbsp;상품명</td>
					</tr>
					<tr>
						<td rowspan="3">
							<span id="imgTarget"></span>
							<input type="file"  onchange="preview(this)">
						</td>
						<td>상품명 및 상품 설명</td>
					</tr>
					<tr>
						<td>현재 입찰가</td>
					</tr>
					<tr>
						<td>입찰수</td>
					</tr>
				</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" id="doneBtn" class="btn btn-default" onclick="doneClick()">Done</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancle</button>
			</div>
		</div>
	</div>
	</form>
</div>