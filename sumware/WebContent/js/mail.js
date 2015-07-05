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


//------------------------------------
//------------------------------------
// 체크에디터 설정
function mailChkUpload(){
	CKEDITOR.replace('mailcont',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl : 'mailWrite'
	});
	CKEDITOR.on('dialogDefinition', function(ev){
		var dialogName = ev.data.name;
		var dialogDefinition = ev.data.definition;
		switch(dialogName){
		case 'image' : // Image Properties dialog
			// dialogDefinition.removeContents('info');
			dialogDefinition.removeContents('Link');
			dialogDefinition.removeContents('advanced');
			break;
		}
	});
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
	}
}

function mailRecover(){
	// 휴지통에서 체크된 메일들을 복구(메일함으로 이동시킴)
	// 체크된 메일들의 delete 속성을 1로 변경
	$("#delvalue").attr("value","1");
	$("#listform").submit();
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

//function mailReplyForm(){
//	var oriForm;
//	$("#orimail").attr("value",oriForm);
//	$("#detailform").submit();
//}

//function setMailOriForm(){
//	
//}




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
	// 4) 비동기식으로 요청을 보낸다.
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
		// 1) 0.5초 후 sendKeyword() 호출
		// delay 동안 아래의 코드 실행
		console.log("startSuggest 함수 들어옴");
		loopKey = true;
	}
	check = true;
}

function sendKeyword() {
	if (loopKey == false) {
		return;
	}

	// 2) f라는 name을 가진 form 태그 안에 있는
	// mailreceiver라는 이름을 가진 태그의 value를 가져온다.
	// (사용자가 입력한 값)
	var key = f.mailreceiver.value;

	if (key == '' || key == '  ') {
		// 3-1) 빈 값이나 공백이 있을 경우
		lastKey = '';
		// name이 view인 div를 보이지 않게 한다.
		// key값을 가지고 xml 파일에 있는 데이터를 검색한 후
		// 검색한 데이터들을 view에 나타나게 한다.
		document.getElementById("view").style.display = "none";
	} else if (key != lastKey) {
		// 3-2) 사용자가 입력한 값이 있을 경우
		lastKey = key;
		// 파라미터로 사용자가 입력한 문자열을 보낸다.
		var param = "key=" + key;
		// 4) 비동기식으로 요청을 보낸다.
		// url, 파라미터, 콜백함수, 보낼 방식
		sendRequest("mailSug", param, res, "post");
	}

	setTimeout("sendKeyword();", 500);
}

var jsonObj = null;
function res() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			// 10) 응답받은 데이터를 JSON 타입으로 변환
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
	// 11) 배열의 데이터를 하나씩 읽어서 view 내부에 있는 테이블에 나타나도록 코드 추가
	for (var i = 0; i < jsonObj.length; i++) {
		htmlTxt += "<tr style='background:white;'><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
				+ i + ")'>" + jsonObj[i] + "</td></tr>";
		console.log(jsonObj[i]);
	}
	htmlTxt += "</table>";
	vD.innerHTML = htmlTxt;
	vD.style.display = "block";
	vD.style.width = "250px";
}

function select(index) {
	f.mailreceiver.value = jsonObj[index];
	var str = f.mailreceiver.value.replace('&lt;','<').replace('&gt;','>');
	f.mailreceiver.value = str;
	console.log(f.mailreceiver.value);
	document.getElementById("view").style.display = "none";
	check = false;
	loopKey = false;
}


