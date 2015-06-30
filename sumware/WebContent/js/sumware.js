/**
 * 
 */

// $(function(){}) == document.ready
// $(window).onload(function(){}); == window.onload (이미지, js, 임포트된 외부 리소스 모두 로드
// 이후에 js 해석)
$(function() {
	// DOM 요소 로드 이후에 실행되기 떄문에 이벤트가 뻑날일이 없음
	$(".navbar-nav li a").click(function(e) {
		// 앵커태그 새로고침 이벤트 방지
		e.preventDefault();
		var pageName = $(this).text().toLowerCase();
		switch (pageName) {
		case ("main"):
			window.location.href = "home";
			break;
		case ("todo"):
			window.location.href = "todo";
			break;
		case ("calendar"):
			window.location.href = "calList";
			break;
		case ("board"):
			$(".navbar-nav form").attr("action", "boardList");
			$(".navbar-nav input").attr("value", pageName);
			$(".navbar-nav form").submit();
			// window.location.href = "boardList";
			break;
		}
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
		url : "/toUpFk",
		data : {
			// model:"todo",
			// submod:"toUpFk",
			memnum : "${sessionScope.v.memnum }",
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
function getJobDetail(tonum) {
	$("#memlisttarget" + tonum).toggle("slow");
	$("#detail" + tonum).toggle("slow");
	$.ajax({
		type : "post",
		url : "/showmemlist",
		data : {
			// model:"todo",
			// submod:"showmemlist",
			jobtonum : tonum,
		},
		success : function(result) {
			$("#memlisttarget" + tonum).html(result);

		}
	});
}
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

//엔터 체크
function enterCheck(res) {
	if (event.keyCode == 13) {
		var inputLength = $(this).length;
		if (inputLength > 0) {
			if (res == 1) {
				snsSend();
			} else if (res == 2) {
				snsInsertComm();
			} else if (rse == 3) {
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
			alert(result);
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
				location = "home";
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
function selectMenu(sel) {
	// 메뉴 선택
	if (sel == 'deptTodo') {
		// 부서업무 버튼
		$.ajax({
			type : "post",
			url : "todoForm",
			data : {
				//						model:"todo", 
				// 						submod:"todoForm",
				memdept : "${sessionScope.v.memdept}"
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
				// 						model:"todo", 
				// 						submod:"addtodoForm",
				memnum : "${sessionScope.v.memnum}"
			},
			success : function(result) {

				$("#menuTarget").html(result);

			}
		});
	} else if (sel == 'manageJob2') {
		// 팀장일 때 업무 관리 버튼
		$.ajax({
			type : "post",
			url : "checkTodoList",
			data : {
				//  						model:"todo", 
				// 						submod:"checkTodoList",
				memnum : "${sessionScope.v.memnum}"
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
				//  						model:"todo", 
				// 						submod:"fWMana",
				memnum : "${sessionScope.v.memnum}"
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
				//  						model:"todo", 
				// 						submod:"giveJobForm",
				memnum : "${sessionScope.v.memnum}"
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
				//  						model:"todo", 
				// 						submod:"teamTodoForm",
				memmgr : "${sessionScope.v.memnum}"
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
				memnum : "${sessionScope.v.memnum }",
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

			}
		});
		alert("거절 완료되었습니다.");
	} else if (res == 'approveTodo') {
		$.ajax({
			type : "post",
			url : "approveTodo",
			data : {
				model : "todo",
				// 					submod:"checkTodoList",
				// 					childmod:"approveTodo",
				tonum : $('#atonum').val(),
				memnum : "${sessionScope.v.memnum }",
				tostdate : $('#atostdate').val(),
				toendate : $('#atoendate').val(),
				totitle : $('#atotitle').val(),
				todept : $('#atodept').val(),
				tocomm : $('#atocomm').val()

			},

			success : function(result) {
				setTimeout(function() {
					$("#menuTarget").html(result);
				}, 1000);

			}
		});
		alert("승인 완료되었습니다.");
	} else if (res == 'successTodo') {
		$.ajax({
			type : "post",
			url : "successJob",
			data : {
				model : "todo",
				// 					submod:"successJob",
				tonum : $('#stonum').val(),
				tocomm : $('#stocomm').val(),
				memmgr : "${sessionScope.v.memmgr}"
			},
			success : function(result) {
				setTimeout(function() {
					$("#menuTarget").html(result);
				}, 1000);

			}
		});
		alert("업무 완료 처리 되었습니다.");
	}

}
function todoFormGo(res) {
	$('#model').attr("value", "todo");
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
		url : "/showmemlist",
		data : {
			// 				model:"todo", 
			// 				submod:"showmemlist", 
			jobtonum : tonum,
		},
		success : function(result) {
			$("#memlisttarget" + tonum).html(result);

		}
	});
}
// 메일 
function mailFormGo(res) {
	if (res == 'write') { // 메일 쓰기
		location = "mailWriteForm?usernum=${sessionScope.v.memnum}"
				+ "&userid=${sessionScope.v.meminmail}";
		// 		$("#model").attr("value","mail");
		// 		$("#submod").attr("value","mailWriteForm");
		// 		$("#usernum").attr("value","${sessionScope.v.memnum}");
		// 		$("#userid").attr("value","${sessionScope.v.meminmail}");
		// 		$("#mailform").submit();

	} else if (res == 'fromlist') { // 받은 메일함
		location = "mailFromList?usernum=${sessionScope.v.memnum}"
				+ "&userid=${sessionScope.v.meminmail}&page=1";
		// 		$("#model").attr("value","mail");
		// 		$("#submod").attr("value","mailFromList");
		// 		$("#usernum").attr("value","${sessionScope.v.memnum}");
		// 		$("#userid").attr("value","${sessionScope.v.meminmail}");
		// 		$("#page").attr("value",1);
		// 		$("#mailform").submit();

	} else if (res == 'tolist') { // 보낸 메일함
		location = "mailToList?usernum=${sessionScope.v.memnum}"
				+ "&userid=${sessionScope.v.meminmail}&page=1";

	} else if (res == 'mylist') { // 내게 쓴 메일함
		location = "mailMyList?usernum=${sessionScope.v.memnum}"
				+ "&userid=${sessionScope.v.meminmail}&page=1";

	} else if (res == 'trashcan') { // 휴지통
		location = "mailTrashcan?usernum=${sessionScope.v.memnum}"
				+ "&userid=${sessionScope.v.meminmail}&page=1";
	}
}

function mailSendFunc() {
	$("#mailWriteF").submit();
}
// 메일-suggest 관련 함수
var xhr = null;
function getXMLHttpRequest() {
	if (window.ActiveXObject) {
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		xhr = new XMLHttpRequest();
	}
}
function sendRequest(url, param, callback, method) {
	// get/post 방식 결정
	getXMLHttpRequest();
	method = (method.toLowerCase() == 'get') ? 'GET' : 'POST';
	param = (param == null || param == '') ? null : param;
	if (method == 'GET' && param != null) {
		url = url + '?' + param;
	}

	xhr.onreadystatechange = callback;
	xhr.open(method, url, true);
	xhr.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
	xhr.send(method == 'POST' ? param : null);
}

var lastKey = "";
var check = false;
var loopKey = false;

function startSuggest() {
	if (check == false) {
		setTimeout("sendKeyword();", 500);
		loopKey = true;
	}
	check = true;
}

function sendKeyword() {
	if (loopKey == false) {
		return;
	}

	var key = f.toMem.value;

	if (key == '' || key == '  ') {
		lastKey = '';
		document.getElementById("view").style.display = "none";
	} else if (key != lastKey) {
		lastKey = key;
		var param = "model=mail&submod=mailSug&key="
				+ key
				+ "&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}";
		sendRequest("sumware", param, res, "post");
	}

	setTimeout("sendKeyword();", 500);
}

var jsonObj = null;
function res() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			var response = xhr.responseText;
			jsonObj = JSON.parse(response.trim());
			viewTable();
		} else {
			document.getElementById("view").style.display = "none";

		}
	}
}

function viewTable() {
	var vD = document.getElementById("view");
	var htmlTxt = "<table>";
	for (var i = 0; i < jsonObj.length; i++) {
		htmlTxt += "<tr><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
				+ i + ")'>" + jsonObj[i] + "</td></tr>";
	}
	htmlTxt += "</table>";
	vD.innerHTML = htmlTxt;
	vD.style.display = "block";
}

function select(index) {
	f.toMem.value = jsonObj[index];
	document.getElementById("view").style.display = "none";
	check = false;
	loopKey = false;
}
// 메일