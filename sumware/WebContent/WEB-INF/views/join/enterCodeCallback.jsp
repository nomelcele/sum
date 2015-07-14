<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
				<div class="tabbable" id="findpwTarget">
					<div class="tab-content">

						<div class="form-group">
							<label class="control-label">인증번호</label> 
							<input type="text" id="mycode" class="form-control" style="width: 170px; display:inline"
								placeholder="인증 번호" >
							<button type="button" class="btn btn-default"  onclick="javascript:findPassWord('checkCode')">확인</button>
							<div id="succodeTarget"></div>
						</div>
						<div class="changePwForm" style="display:none">
						<hr>
							<label class="control-label" >변경 할 비밀번호</label> <input type="password"
								id="newpw" class="form-control" style="width: 170px">
								<br/>
							<label class="control-label">비밀번호 확인</label> <input type="password"
								id="checknewpw" class="form-control" onkeyup="javascript:findPassWord('confirmnewPW')" style="width: 170px">
						</div>
						<div id="checkPwTarget"></div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="changeBtn"
							onclick="javascript:findPassWord('${mvo.memnum}')" disabled="disabled">변경</button>
					</div>
				</div>