// $(function(){}) == document.ready
// $(window).onload(function(){}); == window.onload (이미지, js, 임포트된 외부 리소스 모두 로드
// 이후에 js 해석)
$(function() {
	// DOM 요소 로드 이후에 실행되기 떄문에 이벤트가 뻑날일이 없음
	// Main 페이지에서 각 네비바의 태그들 클릭 시 발생.
	$(".navbar-nav li a").click(function(e) {
		// 앵커태그 새로고침 이벤트 방지
		e.preventDefault();
		$pageName = $(this).text().toLowerCase();
		switch ($pageName) {
		case ("main"):
			$("#formff").attr("action","home").submit();
			break;
		case ("todo"):
			$("#model").attr("value", $pageName);
			$("#formff").attr("action","safirsttodoForm").submit();
		
			break;
		case ("calendar"):
			$("#model").attr("value", $pageName);
			$("#formff").attr("action","sacalList").submit();
			break;
		case ("mail"):
			$("#model").attr("value",$pageName);
			$("#page").attr("value","1");
			$("#formff").attr("action","samailFromList").submit();
			break;
		case ("board"):
			$("#model").attr("value", $pageName);
			$("#bname").attr("value", "공지사항");
			$("#bgnum").attr("value", "0");
			$("#page").attr("value", "1");
			$("#bSearch").attr("value", "");
			$("#div").attr("value", "");
			$("#formff").attr("action","saboardList").submit();
			break;
		case ("sign"):
			$("#page").attr("value", "1");
			$("#formff").attr("action","sagetSignList").submit();
			break;
		case ("auction"):
			$("#formff").attr("action","saproductList").submit();
			break;
		case ("chart"):
			$("#formff").attr("action","sachart").submit();
			break;
		case ("conf"):
			goConfForm();
			break;
		case("salary"):
			$("#adminform").attr("action","adminSalaryPage").submit();
			break;
		case("employee"):
			$("#adminform").attr("action","adminEmployeePage").submit();
			break;
		case("sign form"):
			$("#adminform").attr("action","adminSignFormPage").submit();
			break;
		case("board(a)"):
			$("#adminform").attr("action","adminBoardPage").submit();
			break;
		default:
			openWin();
			break;
		}
	});
	$("#capForm").submit(function(e){
		e.preventDefault();
	});
});

function logout(memnum) {
	$.ajax({
		url : "logout",
		type : "POST",
		data : {
			memnum : memnum
		},
		success : function(result) {
			console.log("logout result: " + result);
			location = "home";
		}
	});
}


//엔터 체크
function enterCheck(res) {
	if (event.keyCode == 13) {
		var inputLength = $(this).length;
		if (inputLength > 0) {
			if (res == 1) {
				snsSend(arguments[1],arguments[2]);
			} else if (res == 2) {
				snsInsertComm();
			} else if (res == 3) {
				loginChk();
			}else if(res == 4){
				adminLogin();
			}

			return;
		}
	}

}
//로그인 3회....
function loginChk() {
	$('#loginF').submit();
}
function openCap(){
	$.ajax({
		url : "getCap",
		type : "POST",
		success : function(result) {
			$('#capBody').html(result);
			$('#capModal').modal('toggle');
		}
	});
}

//보안문자에서의 폼전달
function capClick() {
	$("#Captarget").load("viewCap", {
		password : $("#capPassword").val()
	}, function() {
		var captcha = $("#Captarget").text().trim();
		console.log(captcha)
		if (captcha == "ok") {
			location = "home";
		} else {
			alert("보안문자 확인해주세요.");
		}
	});
};

function openWin() {
	var opt = "width=700, height=800, scrollbars=yes";
	window.open("samessengerForm",
			"MessengerMain", opt);
}



//인증번호를 사원의 외부메일로 전송
function findPassWord(res){
	// 사번과 메일을 확인하여 인증코드를 메일로전송
	if(res=='sendNumber'){
		$.ajax({
			type: "POST",
			url: "sasendCode",
			data: {
				memnum: $('#findpwmemnum').val(),
				memmail: $('#findpwmemmail').val()
			},
			success: function(result){
				alert("인증번호를 메일로 전송하였습니다.")
				$('#findpwTarget').html(result);
			},
			error:function(a,b){
				alert("사원번호와 E-mail이 일치하는 사원이 없습니다. 다시 시도 해 주세요.")
			}
		});
	// 인증번호가 일치하는지 확인
	}else if(res=='checkCode'){
		$.ajax({
			type: "POST",
			url: "sacheckCode",
			data: {
				code: $('#mycode').val(),
			},
			success: function(result){
				alert("인증번호가 일치합니다. 비밀번호를 변경하여 주세요.")
				$('.changePwForm').show('slow');
			},
			error:function(a,b){
				alert("인증번호가 일치하지 않습니다. 다시 시도 해 주세요.")
			}
		});
		
	// 새 비밀번호가 일치하는지 확인
	}else if(res =='confirmnewPW'){
		if($('#newpw').val() == $('#checknewpw').val()){
			$('#checkPwTarget').html("<p style='color:blue'>비밀번호 일치</p>");
			$('#changeBtn').attr("disabled",false);
		}else{
			$('#checkPwTarget').html("<p style='color:red'>비밀번호 불일치</p>");
			$('#changeBtn').attr("disabled",true);
		}
	}else{
		alert(res+"  "+$('#checknewpw').val())
		$.ajax({
			type: "POST",
			url: "sachangePW",
			data: {
				memnum: res,
				mempwd: $('#checknewpw').val()
			},
			success: function(result){
				alert("비밀번호 변경이 완료되었습니다.")
				// 모달 종료
				$('#findPW').modal('toggle');
			}
		});
	}
}

//회의방 만들기
function goConfForm(){
	var option = "width=1200, height=550, scrollbars=yes";
	window.open("saconfForm?memdept=0&memname=&page=1","Video Conference",option);
}
