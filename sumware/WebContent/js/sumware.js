// $(function(){}) == document.ready
// $(window).onload(function(){}); == window.onload (이미지, js, 임포트된 외부 리소스 모두 로드
// 이후에 js 해석)
var c = 1;//로그인 실패 횟수
console.log("typeof:" + typeof (EventSource));
if (typeof (EventSource) != "undefined") {
	var eventSourceList = new EventSource("mesCountMsg");
	eventSourceList.onmessage = function(event) {
		$('#countRoomNum').html(event.data);
	};
} else {
	alert("해당 브라우저는 지원이 안됩니다.");
}
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
			$("#formff").attr("action","firsttodoForm").submit();
		
			break;
		case ("calendar"):
			$("#model").attr("value", $pageName);
			$("#formff").attr("action","calList").submit();
			break;
		case ("mail"):
			$("#model").attr("value",$pageName);
			$("#page").attr("value","1");
			$("#formff").attr("action","mailFromList").submit();
			break;
		case ("board"):
			$("#model").attr("value", $pageName);
			$("#bdeptno").attr("value", "${sessionScope.v.memdept}");
			$("#bname").attr("value", "공지사항");
			$("#bgnum").attr("value", "0");
			$("#page").attr("value", "1");
			$("#formff").attr("action","boardList").submit();
			break;
		default:
			openWin();
		break;
		}
	});
	
	// boardList 에서 boardDetail 로 넘어 갈때. ----------------------------------
	$('.board-list tbody tr a').click(function(e){
//		alert("gkgkgk");
		e.preventDefault();
		$("#detailForm").submit();
	});
});

function logout(memnum) {
	$.ajax({
		url : "logout",
		type : "GET",
		data : {
			memnum : memnum
		},
		success : function(result) {
			console.log("logout result: " + result);
			location = "index";
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
		url : "toUpFk",
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
				snsSend();
			} else if (res == 2) {
				snsInsertComm();
			} else if (res == 3) {
				loginChk();
			}

			return;
		}
	}

}
//로그인 3회....
function loginChk() {
	$.ajax({
		url : "login",
		type : "GET",
		data : {
			memnum : $("#memnum").val(),
			mempwd : $("#mempwd").val()
		},
		success : function(result) {
			result = result.trim();
			if (result == 0) {
				alert(c + "회 로그인실패");
				c++;
				if (c > 3) {
					$.ajax({
						url : "getCap",
						type : "POST",
						success : function(result) {
							$('#capBody').html(result);
							$('#capModal').modal('toggle');
						}
					});
				}
			} else if (result == 1) {
				location = "firstLoginForm";
			} else {
				location = "home.index";
			}
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

function formSub(res) {
	if (res == 'd') {
		$('#dform').submit();
	} else {
		$('#cform').submit();
	}
}

function openWin() {
	var opt = "width=700, height=800, scrollbars=yes";
	window.open("messengerForm",
			"MessengerMain", opt);
}

function selectMenu(sel,senddata) {
	// 메뉴 선택
	if (sel == 'deptTodo') {
		// 부서업무 버튼
		$.ajax({
			type : "post",
			url : "todoForm",
			data : {
		
				memdept : senddata
			},
			success : function(result) {

				$("#menuTarget").html(result);

			}
		});
	} else if (sel == 'giveJob1') {
		// 부장일 때 업무 부여 버튼

		$.ajax({
			type : "post",
			url : "addtodoForm",
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
		// 팀장일 때 업무 관리 버튼
		$.ajax({
			type : "post",
			url : "checkTodoList",
			data : {
				memnum : senddata
			},
			success : function(result) {

				$("#menuTarget").html(result);

			}
		});
	} else if (sel == 'manageJob1') {
		// 부장일 때 업무 관리 버튼
		$.ajax({
			type : "post",
			url : "fWMana",
			data : {

				memnum : senddata
			},
			success : function(result) {

				$("#menuTarget").html(result);

			}
		});
	} else if (sel == 'giveJob2') {
		// 팀장일 때 업무 부여
		$.ajax({
			type : "post",
			url : "giveJobForm",
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
			url : "teamTodoForm",
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
			url : "rejectTodo",
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
			url : "approveTodo",
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
			url : "successJob",
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
	if (res == 'approveTodo') {
		// 팀장업무관리에서 승인버튼
		$('#okForm').submit();
	} else if (res == 'rejectTodo') {
		// 팀장업무관리에서 거절버튼
		$('#rejectForm').submit();
		alert("거절 완료");
	} else if (res == 'addTodo') {
		//부장의 업무 추가 폼 작성 후 보내기버튼
		$('#addTodoForm').submit();
		alert("업무를 등록하였습니다.");
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
		url : "showmemlist",
		data : {
			jobtonum : tonum,
		},
		success : function(result) {
			$("#memlisttarget" + tonum).html(result);
		}
	});
}
