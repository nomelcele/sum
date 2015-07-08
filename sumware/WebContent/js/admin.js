/**
 * 
 */
// admin Login 부분!!!!!
// 로그인 3회....
function adminLogin() {
	$.ajax({
		url : "adminLogin",
		type : "GET",
		data : {
			memnum : $("#adminmemnum").val(),
			mempwd : $("#adminmempwd").val()
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
			} else {
				location = "admin.adminMain";
			}
		}
	});
}

// 관리자 로그아웃
function adminLogout(memnum) {
	$.ajax({
		url : "adminLogout",
		type : "GET",
		data : {
			memnum : memnum
		},
		success : function(result) {
			console.log("logout result: " + result);
			location = "admin.adminMain";
		}
	});
}

// 관리자 모드에서 left 메뉴선택
function adminSelectMenu(res) {
	// 사원 추가 버튼
	if (res == 'addMem') {
		$.ajax({
			type : "POST",
			url : "adminaddMemberForm",
			success : function(result) {
				$('.contents').html(result);
			}
		});

		// 게시판 추가 버튼
	} else if (res == 'addBoard') {
		$.ajax({
			type : "POST",
			url : "adminaddBoardForm",
			success : function(result) {
				$('.contents').html(result);
			}
		});
		// 사원 조회 버튼 또는 검색
	} else if (res == 'adminMemList') {
		$.ajax({
			type : "POST",
			url : "adminMemList",
			data : {
				memdept : $("#searchDept").val(),
				memname : $("#searchName").val()
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
		// 급여 조회 버튼 또는 검색
	} else if (res == 'adminPayInfoList') {
		$.ajax({
			type : "POST",
			url : "adminPayInfoList",
			data : {
				memname : $("#searchName").val()
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
	}
}

// 새 사원 추가에서 부서 선택 시 팀장 목록보여줌
function getMemMgr() {
	alert("팀장 찾아!")
	var memdeptval = $('#newdept').val();
	$.ajax({
		type : "post",
		url : "admingetMemMgr",
		data : {

			memdept : memdeptval,

		},
		success : function(result) {

			$("#mgrListTarget").html(result);
		}
	});
}

// 새 사원 추가 버튼 클릭시 정보 전송 및 메일 전송
function sendNewMember() {
	confirm("사원에게 메일을 전송하시겠습니까?")
	var pay = "";
	if ($('#newjob').val() == '부장') {
		$('#newauth').attr("value", "3");
		pay = 4000;
	} else if ($('#newjob').val() == '팀장') {
		$('#newauth').attr("value", "4");
		pay = 3000;
	} else if ($('#newjob').val() == '사원') {
		$('#newauth').attr("value", "5");
		pay = 2000;
	}
	var mail = $('#newmail').val() + "@" + $('#mailaddr').val();

	$.ajax({
		type : "POST",
		url : "adminaddMember",
		data : {
			memname : $('#newname').val(),
			memauth : $('#newauth').val(),
			memmail : mail,
			mempwd : $('#newpwd').val(),
			memdept : $('#newdept').val(),
			memjob : $('#newjob').val(),
			memmgr : $('#newmgr').val(),
			psalary : pay,
			pyearly : 0
		},
		success : function(result) {
			alert("사원에게 메일을 전송하였습니다.")
			$('.contents').html(result);
		},
		error : function(e) {
			alert("메일 전송이 실패하였습니다. 다시 시도 해 주세요!")
		}
	});
}

function selmail() {
	$('#mailaddr').val($('#selmail').val());
}

// 새 게시판 추가 버튼 클릭
function sendNewBoard() {
	confirm("게시판을 추가하시겠습니까?")

	$.ajax({
		type : "POST",
		url : "adminaddBoard",
		data : {
			bname : $('#newbname').val(),
			bdeptno : $('#newbdeptno').val()
		},
		success : function(result) {
			alert("게시판 추가가 완료되었습니다.")
			$('.contents').html(result);
		},
		error : function(e) {
			alert("게시판 추가를 실패하였습니다. 다시 시도 해 주세요!")
		}
	});
}

// 급여 관리!!!!
function adminPay(res, data) {
	if (res == 'adminPayInfoDetail') {
		$.ajax({
			type : "POST",
			url : "adminPayInfoDetail",
			data : {
				memnum : data
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
	}
}
