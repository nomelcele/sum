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
				<input type="hidden" id="rtonum" value="${tolist.tonum }"> 
				<input type="hidden" id="rtostdate" value="${tolist.tostdate }">
				<input type="hidden" id="rtoendate" value="${tolist.toendate }">
				<input type="hidden" id="rtotitle" value="${tolist.totitle }">
				<input type="hidden" id="rtodept" value="${tolist.todept }">
				<div class="modal-body has-success">
					<label class="control-label"><i class="fa fa-thumb-tack"></i>남길 말</label> <input type="text"
						class="inputsuccess" name="tocomm" id="rtocomm">

				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default" data-dismiss="modal"
						onclick="javascript:todoConfirm('rejectTodo')">보내기</button>
				</div>
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
		
				<input type="hidden" id="atonum" value="${tolist.tonum }"> 
				<input type="hidden" id="atostdate" value="${tolist.tostdate }">
				<input type="hidden" id="atoendate" value="${tolist.toendate }">
				<input type="hidden" id="atotitle" value="${tolist.totitle }">
				<input type="hidden" id="atodept" value="${tolist.todept }">
				
				<div class="modal-body has-success">
					<label class="control-label"><i class="fa fa-thumb-tack"></i>남길 말</label> <input type="text"
						class="inputsuccess" name="tocomm" id="atocomm">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="javascript:todoConfirm('approveTodo')">보내기</button>
				</div>
		</div>

	</div>
</div>
<!-- Modal -->


<!-- successModal -->
<div id="successModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">업무 완료 처리</h4>
			</div>
			<form action="/successJob" method="post" id="successjob">
<!-- 				<input type="hidden" name="model" value="todo">  -->
<!-- 				<input type="hidden" name="submod" value="successJob">  -->
				<input type="hidden" name="tonum" id="stonum" value="${teamjoblist.tonum }"> 
		
				
				<div class="modal-body has-success">
					<label class="control-label"><i class="fa fa-thumb-tack"></i>남길 말</label> <input type="text"
						class="inputsuccess" name="tocomm" id="stocomm">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="javascript:todoConfirm('successTodo')">보내기</button>
				</div>
			</form>
		</div>

	</div>
</div>
<!-- Modal -->

