/**
 * 회원정보 입력 js 파일
 */
var progress = null;
var xhr = null;

//<%--파일을 업로드한다.--%>

function fileUpload(){
	var uploadFile = document.getElementById("fileimg");
	// 업로드 시작 -> xhr.download..
	xhr.upload.onloadstart = function (e) {
		// onloadstart: 감지
		// display: none인 것을 보이게 한다.
	};
	xhr.onreadystatechange = function(){
		// callback
		if(xhr.readyState == 4 && xhr.status == 200){
// 			alert("사진경로"+xhr.responseText.trim());
			$('#memprofile').attr("value",xhr.responseText.trim());
			alert("사원정보가 업데이트 되었습니다.");
			myform.submit();
			
		}
	};
	
	xhr.open("POST","joinupload",true); // 크로스 도메인으로 데이터를 보내는 것이 가능해졌다.
	xhr.setRequestHeader("X-File-Name", // 헤더로 파일의 이름이 간다.
			encodeURIComponent(uploadFile.files[0].name));
	xhr.send(uploadFile.files[0]); // post 방식이니까 send로 파라미터 전송
}

	$(function() {
		
		if(window.ActiveXObject){ // IE
			xhr = new ActivexObject("Microsoft.XMLHTTP");
		} else { // Cross
			xhr = new XMLHttpRequest();
		}
		// upload 버튼을 클릭하면 파일을 업로드한다.
		// querySelector: jQuery 타입의 selector를 만들어준다.
		
		
//		<%--아이디 중복검사 --%>
		
		$('#meminmail').keyup(
				function() {
					setTimeout(function() {
						$('#target').load(
								"/joinck?meminmail="
										+ $('#meminmail').val());
					}, 500);
				});

//		<%--본래 비밀번호 비밀번호 수정시 버튼 --%>

		$('#chbtn').click(function() {
			if($('#mempwd').val() == "${mempwd}" && "${sessionScope.v.mempwd }" == ""){
				// 첫 프로필 수정시
				$('.dhpwd').show("slow");
				
			}else if($('#mempwd').val() == "${sessionScope.v.mempwd }" && "${sessionScope.v.mempwd }" != ""){
				// 사원 프로필 수정시
				$('.dhpwd').show("slow");
				
			}	else {
		
				$('#targetpw').html('<p style="color: red;">비밀번호가 일치 하지 않습니다.</p>');
				setTimeout(function(){
					$('#targetpw').html(' ');
				}, 2000);
			}  
	});
//		<%--비밀번호 중복 검사 --%>
		$('#mempwd2').change(function() {
			if($('#mempwd1').val() != $('#mempwd2').val()){
				
				$('#mempwd1').val("");
				$('#mempwd2').val("");
				$('#mempwd1').focus();
				$('#targetpwd').html('<p style="color: red;">비밀번호가 일치 하지 않습니다.</p>');

			}else{
				$('#targetpwd').html('<p style="color: green;">비밀번호가 일치합니다.</p>');
				setTimeout(function(){
					$('#targetpwd').html(' ');
				}, 2000);
			}
		});

//		<%--우편번호 합치기 유호성 검사 --%>
		
		$('#btn').click(
				function() {
					var a1 = $("#sample6_postcode1").val() + "/"
							+ $("#sample6_postcode2").val() + "/"
							+ $("#sample6_address").val() + "/"
							+ $("#sample6_address2").val();
					$('#address').attr("value", a1);
					
					if($('#targetimg').attr("src")=="resources/img/imgx.jpg"){
						alert("프로필 사진을 등록해주세요!");	
					}else if($('#meminmail').val()==""){
						alert("아이디를 입력해주세요!");
						$('#meminmail').focus();
						
					}else if($('#mempwd').val()==""){
						alert("기존 비밀번호를 입력해주요!");
						$('#mempwd').focus();
						
					}else if($('#mempwd1').val==""){
						alert("새로운 비밀번호를 입력해주요!");
						$('#mempwd1').focus();
					}else if($('#mempwd2').val()==""){
						alert("비밀번호를 다시 입력해 주세요!");
						$('#mempwd2').focus();
					}else if($('#sample6_postcode1').val()==""){
						alert("우편번호를 입력해 주세요!");
						$('#sample6_postcode1').focus();
						
					}else if($('#sample6_address2').val()==""){
						alert("상세 주소를 입력해 주세요!");
						$('#sample6_address2').focus();
					}else{
						fileUpload();
					}					
					
				});

//		<%--이미지 업로드 이미지 --%>
		$('#fileimg').change(
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
								
				window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg만 업로드 가능)');
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
	


//<%--우편번호 찾기 --%>
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
