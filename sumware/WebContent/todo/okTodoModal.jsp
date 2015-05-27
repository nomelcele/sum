<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--reject Modal -->
<div id="rejectModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">거절</h4>
			</div>
			<form action="sumware" method="get" id="rejectForm">
				<input type="hidden" name="model" value="todo"> 
				<input type="hidden" name="submod" value="checkTodoList"> 
				<input type="hidden" name="childmod" value="rejectTodo"> 
				<input type="hidden" name="tonum" value="${tolist.tonum }"> 
				<input type="hidden" name="memnum" value="${sessionScope.v.memnum }">
				<input type="hidden" name="tostdate" value="${tolist.tostdate }">
				<input type="hidden" name="toendate" value="${tolist.toendate }">
				<input type="hidden" name="totitle" value="${tolist.totitle }">
				<input type="hidden" name="todept" value="${tolist.todept }">
					
				<div class="modal-body has-success">
					<label class="control-label">남길 말</label> <input type="text"
						class="inputsuccess" name="tocomm">

				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default" data-dismiss="modal"
						onclick="javascript:todoFormGo('rejectTodo')">보내기</button>
				</div>
			</form>
		</div>

	</div>
</div>
<!-- Modal -->

<!-- okModal -->
<div id="okModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">승인</h4>
			</div>
			<form action="sumware" method="post" id="okForm">
				<input type="hidden" name="model" value="todo"> 
				<input type="hidden" name="submod" value="checkTodoList"> 
				<input type="hidden" name="childmod" value="approveTodo"> 
				<input type="hidden" name="tonum" value="${tolist.tonum }"> 
				<input type="hidden" name="memnum" value="${sessionScope.v.memnum }">
				<input type="hidden" name="tostdate" value="${tolist.tostdate }">
				<input type="hidden" name="toendate" value="${tolist.toendate }">
				<input type="hidden" name="totitle" value="${tolist.totitle }">
				<input type="hidden" name="todept" value="${tolist.todept }">
				
				<div class="modal-body has-success">
					<label class="control-label">남길 말</label> <input type="text"
						class="inputsuccess" name="tocomm">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="javascript:todoFormGo('approveTodo')">보내기</button>
				</div>
			</form>
		</div>

	</div>
</div>
<!-- Modal -->


<!-- okModal -->
<div id="okModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">업무 완료 처리</h4>
			</div>
			<form action="sumware" method="post" id="successjob">
				<input type="hidden" name="model" value="todo"> 
				<input type="hidden" name="submod" value="successJob"> 
				<input type="hidden" name="tonum" value="${tolist.tonum }"> 
		
				
				<div class="modal-body has-success">
					<label class="control-label">남길 말</label> <input type="text"
						class="inputsuccess" name="tocomm">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="javascript:successJob()">보내기</button>
				</div>
			</form>
		</div>

	</div>
</div>
<!-- Modal -->

