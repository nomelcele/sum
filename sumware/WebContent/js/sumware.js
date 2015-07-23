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
// -----------------------------------------	
function hateWorking(tonum) {
	console.log("거절했다~!!!!");
	$(".title" + tonum).toggle("slow");
}

// -----------------------------------------
function tosend(tonumval) {
	$.ajax({
		type : "post",
		url : "satoUpFk",
		data : {
			tomem : $('#inputSuccess' + tonumval).val(),
			toconfirm : "n",
			tonum : tonumval,
			tocomm : $('#tocomm' + tonumval).val()
		},
		success : function(result) {
			$("#menuTarget").html(result);
		}
	});

	alert("업무를 전송하였습니다.");
}

// -----------------------------------------

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

// ajax를 이용한 메뉴 선택
function selectMenu(sel,senddata) {
	if (sel == 'deptTodo') {
		// 부서업무 버튼
		$.ajax({
			type : "post",
			url : "satodoForm",
			data : {
				memdept : senddata
			},
			success : function(result) {
				$("#menuTarget").html(result);
			}
		});
	} else if (sel == 'giveJob1') {
		// 업무 부여 버튼(부장의 경우)
		$.ajax({
			type : "post",
			url : "saaddtodoForm",
			data : {
				memnum : senddata
			},
			success : function(result) {
				$("#menuTarget").html(result);
			},
			 error: function(a, b) {
                 alert("Request: " + JSON.stringify(a));
             }
		});
	} else if (sel == 'manageJob2') {
		// 업무 관리 버튼(팀장의 경우)
		$.ajax({
			type : "post",
			url : "sacheckTodoList",
			data : {
				memnum : senddata
			},
			success : function(result) {
				$("#menuTarget").html(result);
			}
		});
	} else if (sel == 'manageJob1') {
		// 업무 관리 버튼 (부장의 경우)
		$.ajax({
			type : "post",
			url : "safWMana",
			data : {
				memnum : senddata
			},
			success : function(result) {
				$("#menuTarget").html(result);
			}
		});
	} else if (sel == 'giveJob2') {
		// 업무 부여 버튼 (팀장의 경우)
		$.ajax({
			type : "post",
			url : "sagiveJobForm",
			data : {
				memnum : senddata
			},
			success : function(result) {
				$("#menuTarget").html(result);
			}
		});
	} else if (sel == 'teamTodoForm') {
		// 팀 업무 버튼
		$.ajax({
			type : "post",
			url : "sateamTodoForm",
			data : {
				memmgr : senddata
			},
			success : function(result) {
				$("#menuTarget").html(result);
			}
		});
	}
}

function todoConfirm(res) {
	if (res == 'rejectTodo') {
		$.ajax({
			type : "post",
			url : "sarejectTodo",
			data : {
				model : "todo",
				// 					submod:"checkTodoList",
				// 					childmod:"rejectTodo",
				tonum : $('#rtonum').val(),
				//memnum : "${sessionScope.v.memnum }",
				tostdate : $('#rtostdate').val(),
				toendate : $('#rtoendate').val(),
				totitle : $('#rtotitle').val(),
				todept : $('#rtodept').val(),
				tocomm : $('#rtocomm').val()

			},
			success : function(result) {
				setTimeout(function() {
					$("#menuTarget").html(result);
				}, 1000);
				alert("거절 완료되었습니다.");

			}
		});
		
	} else if (res == 'approveTodo') {
		$.ajax({
			type : "post",
			url : "saapproveTodo",
			data : {
				tonum : $('#atonum').val(),
				tostdate : $('#atostdate').val(),
				toendate : $('#atoendate').val(),
				totitle : $('#atotitle').val(),
				todept : $('#atodept').val(),
				tocomm : $('#atocomm').val()

			},

			success : function(result) {
				alert("승인 완료되었습니다.");
				setTimeout(function() {
					$("#menuTarget").html(result);
				}, 1000);

			}
		});
		
	} else if (res == 'successTodo') {
		$.ajax({
			type : "post",
			url : "sasuccessJob",
			data : {
				// 					submod:"successJob",
				tonum : $('#stonum').val(),
				tocomm : $('#stocomm').val(),
				//memmgr : "${sessionScope.v.memmgr}"
			},
			success : function(result) {
				setTimeout(function() {
					$("#menuTarget").html(result);
				}, 1000);
				alert("업무 완료 처리 되었습니다.");

			}
		});
		
	}
}

function todoFormGo(res) {
	//$('#model').attr("value", "todo");
	alert($('#tocont').val())
	if (res == 'approveTodo') {
		// 팀장업무관리에서 승인버튼
		$('#okForm').submit();
	} else if (res == 'rejectTodo') {
		// 팀장업무관리에서 거절버튼
		$('#rejectForm').submit();
		alert("거절 완료");
	} else if (res == 'addTodo') {
		if($('#tostdate').val() > $('#toendate').val()){
			alert("업무 기간을 다시 설정 해주세요.");
		}else if($('#totitle').val() == ""){
			alert("업무 주제를 입력해 주세요.");
		}else if($('#tostdate').val() == ""){
			alert("업무 시작일을 설정해 주세요.");
		}else if($('#selectTomem').val() == ""){
			alert("업무 담당자를 선택해 주세요.");
		}else if($('#tocont').val() == ""){
			alert("업무 내용을 입력해 주세요.");
		}else{
			//부장의 업무 추가 폼 작성 후 보내기버튼
			$('#addTodoForm').submit();
			alert("업무를 등록하였습니다.");
		}
		
		
	} else if (res == 'addMem') {
		if ($('#newjob').val() == '부장') {
			$('#newauth').attr("value", "3");
		} else if ($('#newjob').val() == '팀장') {
			$('#newauth').attr("value", "4");
		} else if ($('#newjob').val() == '사원') {
			$('#newauth').attr("value", "5");
		}
		$('#addMemForm').submit();
		alert("사원 추가가 완료되었습니다.");

	} else if (res == 'addBoard') {
		$('#addBoardForm').submit();
		alert("게시판 추가가 완료되었습니다.");
	}
}

function getJobDetail(tonum) {
	$("#memlisttarget" + tonum).toggle("slow");
	$("#detail" + tonum).toggle("slow");
	$.ajax({
		type : "post",
		url : "sashowmemlist",
		data : {
			jobtonum : tonum,
		},
		success : function(result) {
			$("#memlisttarget" + tonum).html(result);
		}
	});
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
	var option = "width=600, height=500, scrollbars=yes";
	window.open("saconfForm?memdept=0&memname=&page=1","Video Conference",option);
}
