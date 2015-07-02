/**
 * 
 */
// 메일 (메뉴)
function mailFormGo(res) {
	if (res == 'write' ){
		$("#mailform").attr("action","mailWriteForm").submit();
	} else if (res == 'fromlist') { // 받은 메일함
		$("#mailform").attr("action","mailFromList").submit();
		
//		location = "mailFromList?usernum=${sessionScope.v.memnum}"
//				+ "&userid=${sessionScope.v.meminmail}&page=1";

	} else if (res == 'tolist') { // 보낸 메일함
		$("#mailform").attr("action","mailToList").submit();
		
//		location = "mailToList?usernum=${sessionScope.v.memnum}"
//				+ "&userid=${sessionScope.v.meminmail}&page=1";

	} else if (res == 'mylist') { // 내게 쓴 메일함
		$("#mailform").attr("action","mailMyList").submit();
		
//		location = "mailMyList?usernum=${sessionScope.v.memnum}"
//				+ "&userid=${sessionScope.v.meminmail}&page=1";

	} else if (res == 'trashcan') { // 휴지통
		$("#mailform").attr("action","mailTrashcan").submit();
		
//		location = "mailTrashcan?usernum=${sessionScope.v.memnum}"
//				+ "&userid=${sessionScope.v.meminmail}&page=1";
	}
}

// ------------------------------------
// ------------------------------------
// mailList.jsp 스크립트
function mailWriteFormGo(){
	$("#listform").attr("action","mailWriteForm").submit();
}

function mailTrashGo(){
	$("#delvalue").attr("value","2");
	$("#listform").submit();
//		location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
//				"&userid=${sessionScope.v.meminmail}&delvalue=2&tofrom=${tofrom}"+
//				"&page=1&chk="+$("#chk:checked").serialize();
	
}

function maildeleteGo(){
	// 휴지통에서 체크된 메일들을 영구 삭제
	if(!confirm("선택한 메일을 영구 삭제하겠습니까?")){
		return; // 취소를 할 경우 삭제되지 않는다.
	} else { // 확인 버튼을 누르면 메일 삭제
		$("#delvalue").attr("value","3");
		$("#listform").submit();
//			location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
//			"&userid=${sessionScope.v.meminmail}&delvalue=3&tofrom=${tofrom}"+
//			"&page=1&chk="+$("#chk:checked").serialize();
	}
}

function mailRecover(){
	// 휴지통에서 체크된 메일들을 복구(메일함으로 이동시킴)
	// 체크된 메일들의 delete 속성을 1로 변경
	$("#delvalue").attr("value","1");
	$("#listform").submit();
//		location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
//		"&userid=${sessionScope.v.meminmail}&delvalue=1&tofrom=${tofrom}"+
//		"&page=1&chk="+$("#chk:checked").serialize();
}

function checkAll(obj){
	// 체크박스 전체 선택(해제)을 해주는 메서드
	var chkArr = document.getElementsByName("chk");
	var len = chkArr.length;
	
	for(var i=0; i<len; i++){
		if(obj.checked){
			chkArr[i].checked = true;
		} else {
			chkArr[i].checked = false;
		}
	}
}

function mailDetailGo(mailnum){
	// 상세 보기 페이지로 이동시켜주는 함수
	$("#mailnum").attr("value",mailnum);
	$("#listform").attr("action","mailDetail").submit();
}

//------------------------------------
//------------------------------------
// mailWrite.jsp 스크립트
function mailSendFunc() {
	$("#mailWriteF").submit();
}




//------------------------------------
//------------------------------------
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
		console.log("startSuggest 함수 들어옴");
		loopKey = true;
	}
	check = true;
}

function sendKeyword() {
	if (loopKey == false) {
		return;
	}

	var key = f.mailreceiver.value;

	if (key == '' || key == '  ') {
		lastKey = '';
		document.getElementById("view").style.display = "none";
	} else if (key != lastKey) {
		lastKey = key;
		var param = "key=" + key
				+ "&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}";
		sendRequest("mailSug", param, res, "post");
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
	f.mailreceiver.value = jsonObj[index];
	document.getElementById("view").style.display = "none";
	check = false;
	loopKey = false;
}
// 메일

//function mailFormGo(res){
//		if(res=='write'){ // 메일 쓰기
//			$.ajax({
//				type: "post",
//				url: "sumware",
//				data: {model: "mail",
//					submod: "mailWriteForm"},
//				success: function(result){
//					$("#mainContent").html(result);
//				}
//			});
//		} else if(res=='fromlist'){ // 받은 메일함
//			$.ajax({
//				type: "post",
//				url: "sumware",
//				data: {model: "mail",
//					submod: "mailFromList",
//					usernum: "${sessionScope.v.memnum}",
//					userid: "${sessionScope.v.meminmail }" },
//				success: function(result){
//					$("#mainContent").html(result);
//				}
//			});
//		} else if(res=='tolist'){ // 보낸 메일함
//			$.ajax({
//				type: "post",
//				url: "sumware",
//				data: {model: "mail",
//					submod: "mailToList",
//					usernum: "${sessionScope.v.memnum}",
//					userid: "${sessionScope.v.meminmail }"},
//				success: function(result){
//					$("#mainContent").html(result);
//				}
//			});
//		} else if(res=='mylist'){ // 내게 쓴 메일함
//			$.ajax({
//				type: "post",
//				url: "sumware",
//				data: {model: "mail",
//					submod: "mailMyList",
//					usernum: "${sessionScope.v.memnum}",
//					userid: "${sessionScope.v.meminmail }"},
//				success: function(result){
//					$("#mainContent").html(result);
//				}
//			});
//		} else if(res=='trashcan'){ // 휴지통
//			$.ajax({
//				type: "post",
//				url: "sumware",
//				data: {model: "mail",
//					submod: "mailTrashcan",
//					usernum: "${sessionScope.v.memnum}",
//					userid: "${sessionScope.v.meminmail }"
//				},
//				success: function(result){
//					$("#mainContent").html(result);
//				}
//			});
// 		} 
//	}
	// 메일-suggest 관련 함수
//	
//	var lastKey = "";
//	var check = false;
//	var loopKey = false;
//	
//	function startSuggest(){
//		if(check == false){
//			setTimeout("sendKeyword();",500);
//			loopKey = true;
//		}
//		check = true;
//	}
//	
//	function sendKeyword(){
//		if(loopKey == false){
//			return;
//		}
//		
//		var key = f.toMem.value;
//		
//		if(key == '' || key == '  '){
//			lastKey = '';
//			document.getElementById("view").style.display = "none";
//		} else if(key != lastKey){
//			lastKey = key;
//			var param = "key="+encodeURIComponent(key);
//			// console.log("key: "+key);
//			// 컨트롤러에서 처리하게 고칠 것
//			sendRequest("mail/mailSuggest.jsp", param, res, "post");
//			/* $.ajax({
//				type: "post",
//				url: "sumware",
//				data: {model: "mail",
//					submod: "mailSug",
//					key: key}
//			}); */
//		}
//		
//		setTimeout("sendKeyword();",500);
//	}
//	
//	var jsonObj = null;
//	function res(){
//		if(xhr.readyState == 4){
//			if(xhr.status == 200){
//				var response = xhr.responseText;
//				jsonObj = JSON.parse(response);
//				viewTable();
//			} else {
//				document.getElementById("view").style.display = "none";
//				
//			}
//		}
//	}
//	
//	function viewTable(){
//		var vD = document.getElementById("view");
//		var htmlTxt = "<table>";
//		for(var i=0; i<jsonObj.length; i++){
//			htmlTxt += "<tr><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
//				+ i + ")'>" + jsonObj[i] +"</td></tr>";
//		}
//		htmlTxt += "</table>";
//		vD.innerHTML = htmlTxt;
//		vD.style.display = "block";
//	}
//	
//	function select(index){
//		f.toMem.value = jsonObj[index];
//		document.getElementById("view").style.display = "none";
//		check = false;
//		loopKey = false;
//	}
