<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">업무추가</h4>
				</div>
				<form action="sumware" method="post" name="f" id="f" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="mod" value="todo">
						<input type="hidden" name="submod" value="addTodo">
						<table>
							<tr>
							<td>
								<select name="tomem" >
									<option value="">팀장 선택</option>
									<c:forEach var="tNameList" items="${teamNameList}">
									<option value="${tNameList.memnum }">${tNameList.memname}</option>
									
									</c:forEach>
								</select>
							</td>
							</tr>
							<tr>
							<td>
								<input type="date" name="tostdate"> ~ <input type="date" name="toendate">
							</td>
							</tr>
							<tr>
							<td>
								<input type="text" id="totitle" name="totitle" placeholder="업무 제목">
							</td>
							</tr>
							<tr>
							<td>
								<input type="text" id="tocont" name="tocont" placeholder="업무 내용">
							</td>
							</tr>
							<tr>
							<td>
								<input type="file" id="tofile" name="tofile">
							</td>
							</tr>
							<tr>
							<td>
								<input type="text" id="tocomm" name="tocomm" placeholder="남길 말">
							</td>
							</tr>
							<tr>
								<td>
								<input type="hidden" name="todept" value="${sessionScope.v.memdept }">
								<input type="hidden" name="toconfirm" value="n">
								</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class=btn btn-default" data-dismiss="modal" onclick="submit()">추가</button>
					</div>
				</form>
			</div>
			<!-- Modal end content -->
		</div>
	</div>