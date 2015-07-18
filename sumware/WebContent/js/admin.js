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
				memname : $("#searchName").val(),
				page: 1
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
				memname : $("#searchName").val(),
				page:1
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
		// 급여 지급
	} else if(res == 'adminPayManagement'){
		$.ajax({
			type : "POST",
			url : "adminPayManagement",
			data : {
				memname : $("#searchName").val(),
				page:1
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
		// 게시판 열람 메인 페이지 접근
	} else if(res == 'adminBoardListMain'){
		$.ajax({
			type : "POST",
			url : "adminBoardListMain",
			success : function(result) {
				$('.contents').html(result);
					$.ajax({
						type: "POST",
						url: "admingetDeptBoardList",
						data: {
							bgnum: $("#searchDeptBoard").val(),
							bdeptno: $("#searchDept").val()
						},
						success: function(result){
							$('#deptBoard').html(result);
							// 초기 화면에는 공지사항 게시판이 나옴
						}
					});
			}
		});
		// 게시판 삭제
	} else if(res == 'adminDeleteBoardForm'){
		$.ajax({
			type : "POST",
			url : "adminDeleteBoardForm",
			success : function(result) {
				$('.contents').html(result);
			}
		});
	} else if(res =='addSignForm'){
		$.ajax({
			type : "POST",
			url : "adminaddSignForm",
			success : function(result) {
				$('.contents').html(result);
			}
		});
	} else if(res == 'FormList'){
		$.ajax({
			type : "POST",
			url : "adminFormList",
			data:{
				sfname:$('#searchName').val()
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
	}
}

// 새 사원 추가에서 부서 선택 시 팀장 목록보여줌
function getMemMgr() {
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
	if(!confirm("사원에게 메일을 전송하시겠습니까?")){
		return;
	}else{
	if ($('#newjob').val() == '부장') {
		$('#newauth').attr("value", "3");
	} else if ($('#newjob').val() == '팀장') {
		$('#newauth').attr("value", "4");
	} else if ($('#newjob').val() == '사원') {
		$('#newauth').attr("value", "5");
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
			psalary : $('#newpay').val(),
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
}

function selmail() {
	$('#mailaddr').val($('#selmail').val());
}

// 새 게시판 추가 버튼 클릭
function sendNewBoard() {
	if(!confirm("게시판을 추가하시겠습니까?")){
		return;
	}else{

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

// 사원 퇴사 처리
function resignMem(memnum){
	console.log("사번: "+memnum);
	if(!confirm("퇴사 처리하시겠습니까?")){
		return; // 취소를 할 경우 삭제되지 않는다.
	} else { // 확인 버튼을 누르면 퇴사 처리
		$('#authentication').modal('toggle');
		$('#authBtn').attr("onclick","javascript:authentication('deleteMem')")
		$('#senddata').val(memnum)
		
	}
}

// mem정보 가지고 모달창 띄우기
function getMemInfoForModal(id,res){
	$.ajax({
		type: "POST",
		url: "admingetMemInfoForModal",
		data: {
			memnum: res,
			cmd:id
		},
		success: function(result){
			$('#modalTarget').html(result);
			if(id=='prForm'){
				$('#prForm').modal('toggle');
			} else if(id=='giveBonus') {
				$('#giveBonus').modal('toggle');
			} else if(id=='giveSalary'){
				$('#giveSalary').modal('toggle');
			}
		}
	});
}


// 급여 변경하기위한 메서드
function payManage(res,data){
	if(!confirm("급여를 지급 하시겠습니까?")){
		return;
	}else{
	if(res == 'giveBonus'){
		$('#giveBonus').modal('toggle');
		setTimeout(function(){
			$.ajax({
				type: "POST",
				url: "admingiveBonus",
				data: {
					comdetail: $('#comdetail').val(),
					comamount:$('#comamount').val(),
					commem:data
				},
				success: function(result){
					alert("지급 처리가 완료되었습니다.");				
					$('.contents').html(result);
				}
				
			});
		}, 500)
		
	}else if(res='giveSalary'){
		$('#giveSalary').modal('toggle');
		setTimeout(function(){
			$.ajax({
				type: "POST",
				url: "admingiveSalary",
				data: {
					hismem:data,
					hisamount:$('#hisamount').val()
				},
				success: function(result){
					alert("지급 처리가 완료되었습니다.");				
					$('.contents').html(result);
				},
				error : function(e) {
					alert("지급 실패! 급여가 이미 지급되었습니다.")
				}
			});
		}, 500)
	}
	}
}



// 직급 변경, 부서 이동 처리
function prFormSaveChange(memnum){
	var newmemjob = $("#newmemjob").val();
	var newmemdept = $("#newmemdept").val();
	
	if(newmemjob == 0 && newmemdept == 0){
		alert("변경 사항을 선택하세요");
	} else if(newmemjob != 0){
		// 첫번째 탭에서 변경할 직급을 선택했을 때
		// 직급 변경 탭
		console.log("직급 변경 탭");
		
		if(!confirm("직급을 변경하시겠습니까?")){
			return; 
		} else {
			$("#prForm").modal('toggle');
			setTimeout(function(){
				// 직급에 따른 권한
				var memauthval = ""
					if($("#newmemjob").val() == '대표이사'){
						memauthval = 1;
					}else if($("#newmemjob").val() == '이사'){
						memauthval = 2;
					}else if($("#newmemjob").val() == '부장'){
						memauthval = 3;
					}else if($("#newmemjob").val() == '팀장'){
						memauthval = 4;
					}else if($("#newmemjob").val() == '사원'){
						memauthval = 5;
					}
				$.ajax({
					type: "POST",
					url: "adminPromoteMem",
					data: {
						memnum: memnum,
						memjob: $("#newmemjob").val(),
						psalary: $("#newpsalary").val(),
						memauth:memauthval
					},
					success: function(result){
						console.log("모달 닫기");
						$('.contents').html(result);
					}
				});
			},200);
			
		}
	} else if(newmemdept != 0){
		// 두번째 탭에서 변경할 부서를 선택했을 때
		// 부서 이동 탭
		console.log("부서 이동 탭");
		
		if(!confirm("부서를 변경하시겠습니까?")){
			return; // 취소를 할 경우 변경되지 않는다.
		} else { 
			$("#prForm").modal('toggle');
			setTimeout(function(){
				$.ajax({
					type: "POST",
					url: "adminMoveDept",
					data: {
						memnum: memnum,
						memdept: $("#newmemdept").val()
					},
					success: function(result){
						// 모달 꺼줘야 함
						console.log("모달 닫기");
						$('.contents').html(result);
					}
				});
			},200);
			
		}
	}
}
	
	// 급여 조회에서 년도 바꾸면 수행
	function changeyear(memnum){
		$.ajax({
			type: "POST",
			url: "adminPayInfoDetail",
			data: {
				memnum: memnum,
				hisdate:$('#hisdate').val()
			},
			success: function(result){
				$('.contents').html(result);
			}
		});
	}


	// 부서 번호를 통해 그 부서의 게시판 목록을 가져옴
	// 게시판 목록을 두번째 selectbox에 표시
		function getDeptBoards(){
			$.ajax({
				type: "POST",
				url: "admingetDeptBoards",
				data: {
					bdeptno: $("#searchDept").val()
				},
				success: function(result){
					$('#searchDeptBoard').html(result);
				}
			});
		}

		
		// 게시판 삭제
		function deleteBoard(){
			if(!confirm("게시판을 삭제하시겠습니까?")){
				return; 
			} else { 
				$('#authentication').modal('toggle');
				$('#authBtn').attr("onclick","javascript:authentication('deleteBoard')")
			}
		}

		function getPaymentDetail(memnum, hisdate){
			$.ajax({
				type: "POST",
				url: "admingetPaymentDetail",
				data: {
					commem: memnum,
					comdate:hisdate
				},
				success: function(result){
					$('#modalTarget').html(result);
					$('#paymentDetail').modal('toggle');
				}
			});
		}
		
		// 페이지 이동
		function goPage(page,fname){
			 $("#page").attr("value",page);
			 console.log("페이지: "+$("#page").val());
			
			if(fname == 'memListPage'){
				$.ajax({
					type : "POST",
					url : "adminMemList",
					data : {
						memdept : $("#memdept").val(),
						memname : $("#memname").val(),
						page: $("#page").val()
					},
					success : function(result) {
						$('.contents').html(result);
					}
				});
			}else if(fname == 'payListPage'){
				$.ajax({
					type : "POST",
					url : "adminPayInfoList",
					data : {
						memdept : $("#memdept").val(),
						memname : $("#memname").val(),
						page: $("#page").val()
					},
					success : function(result) {
						$('.contents').html(result);
					}
				});
			}else if(fname='payManagementPage'){
				$.ajax({
					type : "POST",
					url : "adminPayManagement",
					data : {
						memdept : $("#memdept").val(),
						memname : $("#memname").val(),
						page: $("#page").val()
					},
					success : function(result) {
						$('.contents').html(result);
					}
				});
			} else if(fname=='adminBoardPage'){
				// 게시판 열람 페이지 처리
				$.ajax({
					type : "POST",
					url : "saboardList",
					data : {
						bgnum: $("#adminBgnum").val(),
						bdeptno: $("#adminDeptno").val(),
						bsearch: $("#adminBsearch").val(),
						div: $("#adminDiv").val(),
						page: $("#page").val()
					},
					success : function(result) {
						$('#deptBoard').html(result);
					}
				});
			} 
		}
		
		// 문서 양식 커스터마이징
		function manageForm(chk){
			// 전체 체크일 경우에는 chk='checkall'로 모든 경우 수행
			switch(chk){
			case 'checkall':
			case 'writerchk':
				if($('#writerchk').attr("checked") == 'checked'){
					// 체크 햇을때
					$('#sgwriterTarget').html("기안자: <input type='text' id='sgwriter' readonly='readonly'>");
				}else{
					// 체크 푸를때
					$('#sgwriterTarget').html("");
				}
			case 'stendatechk':
				if($('#stendatechk').attr("checked") == 'checked'){
					$('#stendateTarget').html("기안일: <input type='date' id='startdate' name='startdate'> ~ <input type='date' id='enddate' name='enddate'>");
				}else{
					$('#stendateTarget').html("");
				}
			case 'stitlechk':
				if($('#stitlechk').attr("checked") == 'checked'){
					$('#stitleTarget').html("제목 : <input type='text' id='stitle' name='stitle' >");
				}else{
					$('#stitleTarget').html("");
				}
			case 'sdatechk':
				if($('#sdatechk').attr("checked") == 'checked'){
					$('#sdateTarget').html("<tr><td>일시</td></tr><tr><td><input type='text' id='sdate' name='sdate'></td></tr>");
				}else{
					$('#sdateTarget').html("");
				}
			case 'splacechk':
				if($('#splacechk').attr("checked") == 'checked'){
					$('#splaceTarget').html("<tr><td>장소</td></tr><tr><td><input type='text' id='splace' name='splace'></td></tr>");
				}else{
					$('#splaceTarget').html("");
				}
			case 'scontchk':
				if($('#scontchk').attr("checked") == 'checked'){
					$('#scontTarget').html("<tr><td>내용</td></tr><tr><td><textarea rows='15' cols='70' id='scont' name='scont' style='resize:none'></textarea></td></tr>");
				}else{
					$('#scontTarget').html("");
				}
			case 'sreasonchk':
				if($('#sreasonchk').attr("checked") == 'checked'){
					$('#sreasonTarget').html("<tr><td>사유</td></tr><tr><td><textarea rows='5' cols='70' id='sreason' name='sreason' style='resize:none'></textarea></td></tr>");
				}else{
					$('#sreasonTarget').html("");
				}
			case 'sps':
				if($('#sps').attr("checked") == 'checked'){
					$('#spsTarget').html("<tr><td>특이사항</td></tr><tr><td><textarea rows='5' cols='70' id='sps' name='sps' style='resize:none'></textarea></td></tr>");
				}else{
					$('#spsTarget').html("");
				}
			}
			
		}

		// 제작한 양식 추가
		function addForm(){
			var completeForm = $('#completeForm').html();
			if(!confirm("현재 양식을 추가하시겠습니까?")){
				return;
			}else{
				if($('#sfname').val()!=""){
					$.ajax({
						type : "POST",
						url : "adminaddForm",
						data : {
							sfname:$('#sfname').val(),
							sform:$('#completeForm').html()
						},
						success : function(result) {
							alert("양식을 추가하였습니다.")
							$('.contents').html(result);
						}
					});
				}else{
					alert("양식 이름을 입력해주세요.")
				}
				
			}
			
		}
		
		// 양식 삭제
		function deleteSignForm(sfnum){
			if(!confirm("양식을 삭제 하시겠습니까?")){
				return;
			}else{
				$.ajax({
					type : "POST",
					url : "admindeleteSignForm",
					data : {
						sfnum:sfnum
					},
					success : function(result) {
						alert("양식을 삭제하였습니다..")
						$('.contents').html(result);
					}
				});
			}
			
		}
		
		// 게시판 열람 페이지에서 게시물 삭제할 때 호출되는 함수
		function adminBoardDelete(){
			$.ajax({
				type : "POST",
				url : "saboardDelete",
				data : {
					bnum: $("#adminBnum").val(),
					bgnum: $("#adminBgnum").val(),
					bdeptno: $("#adminDeptno").val(),
					page: 1
				},
				success : function(result) {
					$('#deptBoard').html(result);
				}
			});
		}
		
		// 게시판 열람의 select 메뉴에서 선택한 게시판을 보여줌
		function getDeptBoardList(){
			$.ajax({
				type: "POST",
				url: "admingetDeptBoardList",
				data: {
					bgnum: $("#searchDeptBoard").val(),
					bdeptno: $("#searchDept").val()
				},
				success: function(result){
					$('#deptBoard').html(result);
				}
			});
		}
		
		// 체크박스 전체선택!!
		function checkAllElement(){
			//전체선택이란 체크박스가 체크되면
			if($('#checkAll').attr("checked")=="checked"){
				//공통적으로 가지고 있는 name을 이용 해서 모두 체크 후 메서드 실행
				$('input[name=check]').attr("checked",true);
				manageForm('checkall');
			}else{
				$('input[name=check]').attr("checked",false);
				manageForm('checkall');
			}
		}
		
		// 전체 사원 급여 지급
		function giveAllMemSal(){
			if(!confirm("전체 사원에게 급여를 지급하시겠습니까?")){
				return;
			}else{
				$.ajax({
					type: "POST",
					url: "admingiveAllMemSal",
					success: function(result){
						alert("지급 처리가 완료되었습니다.");				
						$('.contents').html(result);
					}
				});
			}
		}

		
		// 인증 후 각 DB 변경 업무 처리
		function authentication(job){
			$.ajax({
				type: "POST",
				url: "adminauthentication",
				data: {
					mempwd: $("#authpwd").val()
				},
				success: function(){
					$('#authentication').modal('toggle');
					setTimeout(function() {
						if (job == 'deleteBoard') {
								$.ajax({
									type : "POST",
									url : "admindeleteBoard",
									data : {
										bgnum : $("#searchDeptBoard").val()
									},
									success : function(result) {
										alert("삭제가 완료되었습니다.")
										$('.contents').html(result);
									}
								});
						}else if(job=='deleteMem'){
								$.ajax({
									type: "POST",
									url: "adminResignMem",
									data: {
										memnum: $('#senddata').val()
									},
									success: function(result){
										alert("퇴사 처리가 완료되었습니다.")
										$('.contents').html(result);
									}
								});
						}			
					},500);
				},
				error : function(e) {
					alert("인증 실패! 비밀번호가 틀렸습니다")
				}
			});
			
		}
		