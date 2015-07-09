<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

				<input type="hidden" name="memauth" value="" id="newauth">

				<div class="chat-panel panel panel-default" style="width: 60%">
					<div class="panel-heading">
						<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
							사원 추가</strong>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="control-label">이 름</label> 
							<input type="text" class="form-control" id="newname" name="memname" style="width: 120px">
						</div>

						<div class="form-group">
							<label class="control-label">메 일</label> <br/>
							<input type="text" class="form-control" id="newmail"autocomplete="off" style="width: 120px; float:left "> 
							<span style="float:left">&nbsp;@&nbsp;</span> 
							<input type="text" class="form-control" id="mailaddr"autocomplete="off" style="width: 120px; float:left ">
							&nbsp;
							<select class="form-control" id="selmail"  onchange="javascript:selmail()"   style="width: 150px; display:inline">
											<option value="">메일 선택</option>								
											<option value="naver.com">naver.com</option>
											<option value="hanmail.com">hanmail.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="nate.com">nate.com</option>
											
							</select>
						</div>

						<div class="form-group">
							<label class="control-label">비밀번호</label> 
							<input type="password" class="form-control" id="newpwd" name="mempwd" style="width: 120px; autocomplete:off">
						</div>

						<div class="form-group">
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
						<div class="form-group" id="mgrListTarget">
						</div>
						<div class="form-group">
							<label class="control-label">직 급</label> 
								<select name="memjob" class="form-control" id="newjob" style="width: 120px">
										<option value="">직급 선택</option>								
										<option value="팀장">팀 장</option>
										<option value="부장">부 장</option>
										<option value="사원">사 원</option>
								</select>
						</div>
						<div class="form-group">
							<input type="button" class="btn btn-outline btn-default" onclick="javascript:sendNewMember()" id = "sendFormToAdd" value="추 가">
						</div>

					</div>
				</div>

		
