<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/top.jsp"%>
<script>



</script>

		<div id="global" class="wrap-layout board">
			<div class="lnb-area" id="lnb-area">
			<%@include file="/contentLeft.jsp"%>
			</div>

			<form action="sumware" method="post" id="addBoardForm">
				<input type="hidden" name="model" value="join">
				<input type="hidden" name="submod" value="addBoard">
				<div class="contents">
				<div class="chat-panel panel panel-default" style="width: 60%">
					<div class="panel-heading">
						<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
							게시판 추가</strong>
					</div>
					<div class="panel-body">
						<div class="form-group has-success">
							<label class="control-label">게시판 이름</label> 
							<input type="text" class="form-control" name="bname" style="width: 120px">
						</div>
						<div class="form-group has-success">
							<label class="control-label">부 서</label> 
							<select name="bdeptno" class="form-control" style="width: 120px">
											<option value="">부서 선택</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
						<div class="form-group has-success">
							<button type="button" class="btn btn-outline btn-success" onclick="javascript:todoFormGo('addBoard')" id = "sendFormToAdd">추 가</button>
						</div>
					</div>
				</div>
				</div>
			</form>
		</div>



<%@include file="/footer.jsp"%>