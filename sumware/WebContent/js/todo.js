/**
 * 
 */

function insertJob(tonum) {

	if ($('#memjobName' + tonum).val() == "") {
		alert("사원을 선택해 주세요.");
	} else {
		$.ajax({
			type : "post",
			url : "sainsertMemJob",
			data : {
				jobmemnum : $('#memjobName' + tonum).val(),
				jobtonum : tonum,
				jobcont : $('#jobcont' + tonum).val()
			},
			success : function(result) {
				$("#membersjob" + tonum).html(result);
				$('#jobcont' + tonum).val("");
				alert("업무 지정이 완료되었습니다.");
			}
		});
	}
}

function getDetail(tonum) {

	$("#detail" + tonum).toggle("slow");

	$.ajax({
		type : "post",
		url : "sashowMembersJob",
		data : {
			jobtonum : tonum,
		},
		success : function(result) {
			$("#membersjob" + tonum).html(result);
		}
	});
}

//-----------------------------------------	
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
//ajax를 이용한 메뉴 선택
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
// -----------------------------------------

// SNS //////////////////////

function pageScoll() {
	var sctop = $('.chat').scrollTop();
	if (sctop > cheight) {
		$("#loading").html(
				"<img src='resources/img/loading.gif' alt='loading'>");
		setTimeout(function() {
			rowsPerPage += 5;
			cheight += ($('.chat').scrollTop() + 100);
			eventSource.close();
			$("#loading img").remove();
			push();

		}, 1000);

	}
}

function snsSend(memnum, memdept) {
	$(".chat").scrollTop(0);
	var fdata = {
//			smem : "${v.memnum}",
//			sdept : "${v.memdept}",
		smem : memnum,
		sdept : memdept,
		scont : $("#btn-input").val()
	};
	$('#btn-input').val("");
	$.ajax({
		type : "POST",
		url : "sainsertSns",
		data : fdata
	});
}
function snsComm(snum) {
	var rowsPerPage = 10;
	var data = {
		page : "1",
		rowsPerPage : rowsPerPage,
		snum : snum
	};
	$.ajax({
		type : "POST",
		url : "sasnsComm",
		data : data,
		success : function(result) {
			$("#wrapbody").html(result);
			$("#snsCommBtn").click();
			ch = $('#snsCommList').height() - 100;
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}
function snsInsertComm(snum, memnum) {
	var data = {
		comem : memnum,
//		comem : "${v.memnum}",
		page : "1",
		rowsPerPage : pageB,
		snum : snum,
		cocont : $('#cocont').val()
	};
	$.ajax({
		type : "POST",
		url : "sasnsCommInsert",
		data : data,
		success : function(result) {
			$("#wrapbody").html(result);
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}
function snsCommDelete(conum, commsns) {
	var data = {
		page : "1",
		rowsPerPage : pageB,
		snum : commsns,
		conum : conum
	};
	$.ajax({
		type : "POST",
		url : "sasnsCommDelete",
		data : data,
		success : function(result) {
			$("#wrapbody").html(result);
		}
	});

}
function snsCommScroll(snum) {
	var st = $('#snsCommList').scrollTop();
	console.log("st:" + st);
	console.log("ch:" + ch);
	if (st >= ch) {
		$("#commloading").html("<img src='img/loading.gif' alt='loading'>");
		setTimeout(function() {
			ch += $('#snsCommList').height() - 200;
			$("#commloading img").remove();

			pageB += 5;
			var page = pageB;
			var rowsPerPage = pageB;
			var data = {
				page : "1",
				rowsPerPage : rowsPerPage,
				snum : snum
			};
			$.ajax({
				type : "POST",
				url : "sasnsComm",
				data : data,
				success : function(result) {
					$("#wrapbody").html(result);
					$('#snsCommList').scrollTop(st);
				}
			});
		}, 1000);
	}
}
//SNS////////////