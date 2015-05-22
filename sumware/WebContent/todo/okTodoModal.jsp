<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<!-- Modal -->
	<div id="okModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">거절</h4>
				</div>
				<form action="sumware" method="post">
					<input type="hidden" name="model" value="todo"> <input
						type="hidden" name="submod" value="checkTodoList"> <input
						type="hidden" name="childmod" value="approveTodo"> <input
						type="hidden" name="tonum" value="${tolist.tonum }"> <input
						type="hidden" name="memnum" value="${sessionScope.v.memnum }">
					<div class="modal-body has-success">
						<label class="control-label">남길 말</label>
						<textarea rows="3"></textarea>
						<input type="text" class="inputsuccess" name="tocomm" value="aa">



					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-default" data-dismiss="modal">보내기</button>
					</div>
				</form>
			</div>

		</div>
	</div>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>