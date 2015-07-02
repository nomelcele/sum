<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
function getMemMgr(){
	var memdeptval = $('#newdept').val();
	$.ajax({
		type : "post",
		url : "getMemMgr",
		data : {

			memdept:memdeptval,
			
			},
		success : function(result){
		
				$("#mgrListTarget").html(result);
			}
		});
}


</script>
			<form action="addMember" method="post" id="addMemForm">
				<input type="hidden" name="memauth" value="" id="newauth">
				<div class="contents">
				<div class="chat-panel panel panel-default" style="width: 60%">
					<div class="panel-heading">
						<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
							사원 추가</strong>
					</div>
					<div class="panel-body">
						<div class="form-group has-success">
							<label class="control-label">이 름</label> 
							<input type="text" class="form-control" id="memname" name="memname" style="width: 120px">
						</div>

						<div class="form-group has-success">
							<label class="control-label">메 일</label> 
							<input type="text" class="form-control" id="newmail" name="memmail" autocomplete="off" style="width: 200px; ">
						</div>

						<div class="form-group has-success">
							<label class="control-label">비밀번호</label> 
							<input type="password" class="form-control" id="newpwd" name="mempwd" style="width: 120px; autocomplete:off">
						</div>

						<div class="form-group has-success">
							<label class="control-label">부 서</label> 
							<select name="memdept" class="form-control" id="newdept" style="width: 120px" onchange="javascrpt:getMemMgr()">
											<option value="">부서 선택</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
						<div class="form-group has-success" id="mgrListTarget">
						</div>
						<div class="form-group has-success">
							<label class="control-label">직 급</label> 
								<select name="memjob" class="form-control" id="newjob" style="width: 120px">
										<option value="">직급 선택</option>								
										<option value="팀장">팀 장</option>
										<option value="부장">부 장</option>
										<option value="사원">사 원</option>
								</select>
						</div>

						<div class="form-group has-success">
							<input type="button" class="btn btn-outline btn-success" onclick="javascript:todoFormGo('addMem')" id = "sendFormToAdd" value="추 가">
						</div>

					</div>
				</div>
				</div>
			</form>
		
