<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link href="../css/join.css" rel="stylesheet"/>
<%--아이디 중복체크 --%>
<script>
	$(function() {

		$('#meminmail').keyup(
				function() {
					setTimeout(function() {
						$('#target').load(
								"join/joinck.jsp?meminmail="
										+ $('#meminmail').val());
					}, 1000);
				});

		$('#btn').click(
				function() {
					var a1 = $("#sample6_postcode1").val() + "/"
							+ $("#sample6_postcode2").val() + "/"
							+ $("#sample6_address").val() + "/"
							+ $("#sample6_address2").val();
					$('#address').attr("value", a1);
					console.log("addresss" + $('#address').val());

				});

		$('#memimg')
				.change(
						function() { // 파일 박스 안에서 변화를 감지해야 한다.
							console.log("이미지 선택했어");
							// 변화가 있을 때 function을 호출한다.
							// 확장자 . 기준으로 다음 요소를 선택해서 소문자로 변경한 후에 ext에 저장한다.
							var ext = $(this).val().split('.').pop()
									.toLowerCase();
							// pop(): 배열만 취급. 
							// 마지막 index의 value를 pop()이 리턴
							// ex) $(this).val() => img.jpg
							// pop()하면 jpg가 리턴됨!
							// toLowerCase(): String을 모두 소문자로 만들어준다.

							// 추출한 확장자가 배열에 존재하는지 체크
							if ($.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
								// 첫번째에 있는 인자값이 두번째에 있는 배열에 있는지 확인 후, 
								// 있으면 1, 없으면 -1을 리턴
								// inArray는 jQuery에서 제공하는 메서드
								resetFormElement($(this)); // 폼 초기화
								window
										.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg만 업로드 가능)');
							} else {
								var file = $(this).prop("files")[0];
								// prop에서 files라는 속성을 가져온 것
								// 자바스크립트의 uploadfile이 제공하는 것이 files
								// file 경로는 file:////경로 
								// 이 경로는 이미지 태그가 표현하지 못한다.

								blobURL = window.URL.createObjectURL(file);
								console.log("blobURL::::", blobURL);
								// 윈도우 자체에서 파일을 불러오는 경로값을 표현하려면
								// createObjectURL()을 사용해야 한다.

								$('#targetimg').attr('src', blobURL).css(
										'width', '200').css('height', '200');
								// attr() src 속성에  blobURL을 넣는다.
							}
						});
	});

	function resetFromElement($obj) { // 자바스크립트
		$obj.val("");
	}
</script>
<%--이건 자바스크립트 --%>
<script>
	function formgogo(res) {
		if (res == 1) {

		} else {

		}
	}

	function pwc() {
		if (document.myform.mempwd1.value != document.myform.mempwd2.value) {
			$('#targetpwd').html("<p style='color:red'>비밀번호가 일치하지 않습니다</p>")
			document.mempwd1.focus();
		}
	}
</script>

<%--우편번호 찾기 --%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById("sample6_postcode1").value = data.postcode1;
						document.getElementById("sample6_postcode2").value = data.postcode2;
						document.getElementById("sample6_address").value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_address2").focus();
					}
				}).open();
	}
</script>

<div>
	<%@include file="../top.jsp"%>
</div>
<div class="container">
	<div class="row info">
		<div class="col-xs-12 alert alert-info"></div>
	</div>

	<div class="resume">
		<header class="page-header">
			<h1 class="page-title">프로필 입력</h1>
			<small> <i class="fa fa-clock-o"></i> Last Updated on: <time>Sunday,
					October 05, 2015</time></small>
		</header>
		<div class="row">
			<div
				class="col-xs-12 col-sm-12 col-md-offset-1 col-md-10 col-lg-offset-2 col-lg-8">
				<div class="panel panel-default">
					<div class="panel-heading resume-heading">
						<div class="row">
							<div class="col-lg-12 col-lg-offset-4">
								<div class="col-xs-10 col-sm-4">
									<figure>
										<img class="img-circle img-responsive" alt="프로필 사진 "
											id="targetimg" src="http://placehold.it/200x200"
											style="width: 200px; height: 200px;">
									</figure>
									<div class="btn-group col-sm-offset-5"
										style="position: relative; overflow: hidden; padding-top: 10px;">
										<input type="file" id="memimg" name="memimg"
											style="position: absolute; right: 0px; top: 0px; opacity: 0; cursor: pointer;" />
										<img src="img/ion.JPG">
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="bs-callout bs-callout-danger">
						<form class="form-horizontal" role="form" method="post" action="sumware"
							name="myform">
							<input type="hidden" name="model" value="join">
							<input type="hidden" name="submod" value="join1">
							<h2>필수 입력 사항</h2>
							<hr>

							<!-- Text input-->
							<div class="form-group">
								<label class="col-sm-3 control-label" for="textinput">아이디</label>
								<div class="col-sm-6">
									<input type="text" id="meminmail" name="meminmail"
										placeholder="아이디" class="form-control">
									<div id="target"></div>
								</div>

							</div>

							<div class="form-group">
								<label class="col-sm-3 control-label" for="textinput">기존
									비밀번호</label>
								<div class="col-sm-6">
									<input type="password" placeholder="기존 비밀번호"
										class="form-control">
								</div>
								<input type="button" class="btn btn-default" value="비밀번호 변경" />
							</div>

							<div>
								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput">새
										비밀번호 </label>
									<div class="col-sm-6">
										<input type="password" placeholder="새 비밀번호"
											class="form-control" id="mempwd1" name="mempwd1">
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput"
										id="password" name="password">새 비밀번호 재 확인 </label>
									<div class="col-sm-6">
										<input type="password" placeholder="새 비밀번호 확인"
											class="form-control" id="mempwd2" name="mempwd2"
											onBlur="pwc()">
										<div id="targetpwd"></div>
									</div>

								</div>

							</div>

							<!-- Text input-->
							<div class="form-group">
								<label class="col-sm-3 control-label" for="textinput">우편번호</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="sample6_postcode1">
								</div>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="sample6_postcode2">
								</div>

								<input type="button" class="btn btn-default"
									onclick="sample6_execDaumPostcode()" value="우편번호 찾기" />

							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="textinput">주소</label>
								<div class="col-sm-6">
									<input type="text" placeholder="주소" class="form-control"
										id="sample6_address">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label" for="textinput">상세주소</label>
								<div class="col-sm-6">
									<input type="text" placeholder="상세주소" class="form-control"
										id="sample6_address2">
								</div>
							</div>


							<!-- Text input-->
							<div class="form-group">
								<label class="col-sm-3 control-label" for="textinput">이메일</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="memmail"
										name="memmail" placeholder="이메일@">
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-offset-5 col-sm-10">

									<button type="submit" class="btn btn-primary">
										<i class="fa fa-floppy-o"></i>
									</button>

								</div>
							</div>
						</form>
					</div>

				</div>

			</div>
		</div>

	</div>

</div>
<div>
	<%@include file="../footer.jsp"%>
</div>