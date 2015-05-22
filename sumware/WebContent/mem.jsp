<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<div class="container">
		<div class="row">
			<div class="col-lg-12" id="content">
				<div class="panel">
					<div class="panel-heading" style="border-bottom-color: #000;">회원가입</div>
					<div class="panel-body">
						<div class="row">
							<div class="col col-lg-8">
								<form class="form-horizontal" role="form" method="post"
									action="javascript:alert( 'success!' );">
									<div class="form-group" id="Id">
										<label for="inputId" class="col-lg-3 control-label">아이디</label>
										<div class="col-lg-5">
											<input type="text" class="form-control onlyAlphabetAndNumber"
												id="id" data-rule-required="true"
												placeholder="30자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다."
												maxlength="30">
										</div>
										<div>
											<button class="btn btn-default">중복검사</button>
										</div>
									</div>
									<div class="form-group" id="divPassword">
										<label for="inputPassword" class="col-lg-3 control-label">패스워드</label>
										<div class="col-lg-7">
											<input type="password" class="form-control" id="password"
												name="excludeHangul" data-rule-required="true"
												placeholder="패스워드" maxlength="30">
										</div>
									</div>
									<div class="form-group" id="divPasswordCheck">
										<label for="inputPasswordCheck" class="col-lg-3 control-label">패스워드
											확인</label>
										<div class="col-lg-7">
											<input type="password" class="form-control"
												id="passwordCheck" data-rule-required="true"
												placeholder="패스워드 확인" maxlength="7">
										</div>
									</div>

									<div class="form-group" id="divNickname">
										<label for="inputNickname" class="col-lg-3 control-label">주소</label>
										<div class="col-lg-7">
											<input type="text" class="form-control" id="address"
												data-rule-required="true" placeholder="주소" maxlength="15">
										</div>
									</div>

									<div class="form-group" id="divEmail">
										<label for="inputEmail" class="col-lg-3 control-label">이메일</label>
										<div class="col-lg-7">
											<input type="text" class="form-control" id="eail"
												data-rule-required="true" placeholder="이메일" maxlength="40">
										</div>
									</div>

									<div class="form-group">
										<div class="col-lg-offset-5 col-lg-10">
											<button type="submit" class="btn btn-default">확인</button>
											<button type="submit" class="btn btn-default">취소</button>
										</div>
									</div>
								</form>
							</div>

						</div>
					</div>
					<!--/panel-body-->
				</div>

			</div>
		</div>
	</div>
</div>