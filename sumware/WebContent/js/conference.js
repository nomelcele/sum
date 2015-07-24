/**
 * 
 */
	function getMemberListForConf() {
		// 참석자를 선택하기 위해서 사원 리스트 불러오기
		$.ajax({
			type : "POST",
			url : "saconfSearch",
			data : {
				memdept : $("#searchDept").val(),
				memname : $("#searchName").val(),
				page : 1
			},
			success : function(result) {
				$('#memSearchForm').html(result);
			}
		});
	}

	function checkAll(obj,name) {
		// 체크박스 전체 선택(해제)을 해주는 메서드
		var chkArr;
		console.log(name);
		if(name=='chk'){
			chkArr = document.getElementsByName("chk");
		} else {
			chkArr = document.getElementsByName("chk2");
		}
		var len = chkArr.length;

		for (var i = 0; i < len; i++) {
			if (obj.checked) {
				chkArr[i].checked = true;
				if(name=='chk'){
					// 참석자 리스트로 올리기
					
				}
			} else {
				chkArr[i].checked = false;
				if(name=='chk'){
					// 참석자 리스트에서 삭제
				}
			}
		}
		
	}
	
	function goToList(obj,memnum,memname,dename,memjob){
		// 1. 다시 체크박스 클릭했을 때 참석자 리스트에서 사라져야 함
		// 2. 검색 버튼 눌렀을 때 참석자 리스트는 초기화 안 되게 변경
		var row;
		
		// 이미 id(memnum)가 같은 행이 있으면 추가되지 않아야 함
		// -> 참석자 리스트의 id 조회
		var chkArr = document.getElementsByName("chk2");
		var res = 0;
		for(var i=0; i<chkArr.length; i++){
			if(memnum == chkArr[i].value){
				res += 1;
			}
		}
		
			if(obj.checked){
				if(res == 0){ // id가 같은 행이 존재하지 않는 경우
					var row = "<tr id='t"+memnum+"'><td><input type='checkbox' name='chk2' id='chk2' value='"+
					memnum+"'></td>"+"<td>"+memname+"</td>"+"<td>"+dename+"</td>"+"<td>"+memjob+"</td></tr>"
					$("#attendeeList").append(row);
				}
			} else {
				row = document.getElementById(memnum);
				row.parentNode.removeChild(row);
			}
		
	}
	
	// ajax 데이터로 배열을 보내기 위한 설정
	jQuery.ajaxSettings.traditional = true;

	function moveConfRoom(){
		// 로컬 ip
		var roomUrl = "http://192.168.7.124:8001?"+$("#confTitle").val();
		var chkArr = document.getElementsByName("chk2");
		var members = [];
		for(var i=0; i<chkArr.length; i++){
			members.push(chkArr[i].value);
		}
		
		$.ajax({
			type : "POST",
			url : "saconfMemAdd",
			data : {
				confurl: roomUrl,
				confmems: members
			},
			success : function(result) {
				// $('#memSearchForm').html(result);
			}
		});
		
		var option = "width=600, height=500, scrollbars=yes";
		window.open(roomUrl,"Video Conference",option);
		// 화상회의 페이지 띄우기
		// 로컬 영역 ip
	}
	
	function deleteFromList(){
		// 참석자 리스트에서 체크된 항목 삭제
		var chkArr = document.getElementsByName("chk2");
		var len = chkArr.length;
		var delArr = [];
		
		for(var i=0; i<len; i++){
			var obj = chkArr[i];
			if(obj.checked){
				delArr.push(obj);
			}
		}
		
		for(var j=0; j<delArr.length; j++){
			document.getElementById("t"+delArr[j].value).remove();
		}
	}
	
	// 멤버 리스트 페이지 처리
	function goMemPage(page){
		$("#page").attr("value",page);
		
		$.ajax({
			type : "POST",
			url : "saconfSearch",
			data : {
				memdept : $("#searchDept").val(),
				memname : $("#searchName").val(),
				page : $("#page").val()
			},
			success : function(result) {
				$('#memSearchForm').html(result);
			}
		});
	}