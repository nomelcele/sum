<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
function getMemMgr(){
	var memdeptval = $('#newdept').val();
	$.ajax({
		type : "post",
		url : "sumware",
		data : {
			model:"join", 
			submod:"getMemMgr",
			memdept:memdeptval,
			
			},
		success : function(result){
		
				$("#mgrListTarget").html(result);
			}
		});
}


</script>



		<div class="wrap-layout board">
			<div class="lnb-area" id="lnb-area">
				<!-- left menu !!!! 들어갈 자리 -->
			</div>

			<form action="sumware" method="post" id="addMemForm">
				<input type="hidden" name="model" value="join">
				<input type="hidden" name="submod" value="addMember">
				<input type="hidden" name="newauth" value="" id="newauth">
				<div class="contents">
				<div class="chat-panel panel panel-default" style="width: 60%">
					<div class="panel-heading">
						<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
							사원 추가</strong>
					</div>
					<div class="panel-body">
						<div class="form-group has-success">
							<label class="control-label">이 름</label> 
							<input type="text" class="form-control" id="newname" name="newname" style="width: 120px">
						</div>

						<div class="form-group has-success">
							<label class="control-label">메 일</label> 
							<input type="text" class="form-control" id="newmail" name="newmail" autocomplete="off" style="width: 200px; ">
						</div>

						<div class="form-group has-success">
							<label class="control-label">비밀번호</label> 
							<input type="password" class="form-control" id="newpwd" name="newpwd" style="width: 120px; autocomplete:off">
						</div>

						<div class="form-group has-success">
							<label class="control-label">부 서</label> 
							<select name="newdept" class="form-control" id="newdept" style="width: 120px" onchange="javascrpt:getMemMgr()">
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
								<select name="newjob" class="form-control" id="newjob" style="width: 120px">
										<option value="">직급 선택</option>								
										<option value="팀장">팀 장</option>
										<option value="부장">부 장</option>
										<option value="사원">사 원</option>
								</select>
						</div>

						<div class="form-group has-success">
							<button type="button" class="btn btn-outline btn-success" onclick="javascript:todoFormGo('addMem')" id = "sendFormToAdd">추 가</button>
						</div>

					</div>
				</div>
				</div>
			</form>
		</div>
