<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SumWare</title>
<!-- CSS 라이브러리(S)  -->
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"/>
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<!-- <link href="css/main.css" rel="stylesheet"/> -->
<!-- <link href="css/join.css" rel="stylesheet"/> -->
<!-- <link href="css/boardList.css" rel="stylesheet"/> -->
<link type="text/css" href="css/common.css" rel="stylesheet"  />
<!-- CSS 라이브러리(E)  -->
<!-- 자바스크립트 -->
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- 메인 -->
<script>
	function openWin(){
		var opt= "width=700, height=1000, scrollbars=yes";
		var f = document.frmmain;
		f.model.value="messenger";
		f.submod.value="messengerForm";
		window.open("","MessengerMain",opt);
		f.target="MessengerMain";	
		f.submit();
	}
	
	function checkmsg(toNum){
		var requNum = toNum;
		var userNum = ${sessionScope.v.memnum };
		if(userNum == toNum){
			console.log("두 사람이 같습니다.");
			window.open("main.jsp", "");
		}else{
			console.log("두 사람은 다릅니다.");
			
		}
	}
</script>
<!-- /메인 -->
<script>
	function formGo(res){
		$('#model').attr("value", "board");
		if(res == 'insert'){
			$('#submod').attr('value','boardInsert');
			$('#page').attr('value','1');
		}else if(res == 'list'){
			$('#submod').attr('value','boardList');
			$('#page').attr('value','1');
		}else if(res == 'update'){
			$('#submod').attr("value","boardUpdate");
		}else if(res == 'write'){
			$('#submod').attr("value", "writeForm");
		}else if(res == 'commInsert'){
			$('#submod').attr("value","boardDetail");
			$('#childmod').attr("value","commInsert")
		}
		$('#bform').submit();
	}
	function todoFormGo(res){
		$('#model').attr("value","todo");
		if(res=='manageJob1'){
			$('#submod').attr("value","fWMana");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			$('#goTodo').submit();
		}else if(res=='giveJob1'){
			$('#submod').attr("value","addtodoForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			console.log("memnum",$('#memnum').val());
			$('#goTodo').submit();
		}else if(res==3){
			// 팀장업무관리에서 승인버튼
			$('#okForm').submit();
		}else if(res==4){
			// 팀장업무관리에서 거절버튼
			$('#rejectForm').submit();
		}else if(res=='manageJob2'){
			// 팀장일때 팀장관리 버튼
			$('#submod').attr("value","checkTodoList");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			$('#goTodo').submit();
		}else if(res== 'addTodo'){
			//부장의 업무 추가 폼 작성 후 보내기버튼
			$('#addTodoForm').submit();
			alert("업무를 등록하였습니다.");
		}else if(res=='giveJob2'){
			// 팀장이 사원들에게 업무를 부여하기 위한 폼
			$('#submod').attr("value","giveJobForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			
			$('#goTodo').submit();
		}else if(res=='todoForm'){
			// 부서업무 버튼
			$('#submod').attr("value","todoForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			$('#memdept').attr("value","${sessionScope.v.memdept}");
			$('#goTodo').submit();
			
		}else if(res=='teamTodoForm'){
			// 팀업무 버튼
			$('#submod').attr("value","teamTodoForm");
			$('#memmgr').attr("value","${sessionScope.v.memmgr}");
			$('#goTodo').submit();
		}
	}
	
	function mailFormGo(res){
		if(res=='write'){ // 메일 쓰기
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailWriteForm"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='fromlist'){ // 받은 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailFromList",
					userid: "${sessionScope.v.meminmail }" },
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='tolist'){ // 보낸 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailToList",
					usernum: "${sessionScope.v.memnum}"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='mylist'){ // 내게 쓴 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailMyList",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='trashcan'){ // 휴지통
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailTrashcan",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }"
				},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
 		} 
	}
</script>
<script> 
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
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send(method == 'POST' ? param : null);
	}
	
	var lastKey = "";
	var check = false;
	var loopKey = false;
	
	function startSuggest(){
		if(check == false){
			setTimeout("sendKeyword();",500);
			loopKey = true;
		}
		check = true;
	}
	
	function sendKeyword(){
		if(loopKey == false){
			return;
		}
		
		var key = f.toMem.value;
		
		if(key == '' || key == '  '){
			lastKey = '';
			document.getElementById("view").style.display = "none";
		} else if(key != lastKey){
			lastKey = key;
			var param = "key="+encodeURIComponent(key);
			// console.log("key: "+key);
			// 컨트롤러에서 처리하게 고칠 것
			sendRequest("mail/mailSuggest.jsp", param, res, "post");
			/* $.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailSug",
					key: key}
			}); */
		}
		
		setTimeout("sendKeyword();",500);
	}
	
	var jsonObj = null;
	function res(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				var response = xhr.responseText;
				jsonObj = JSON.parse(response);
				viewTable();
			} else {
				document.getElementById("view").style.display = "none";
				
			}
		}
	}
	
	function viewTable(){
		var vD = document.getElementById("view");
		var htmlTxt = "<table>";
		for(var i=0; i<jsonObj.length; i++){
			htmlTxt += "<tr><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
				+ i + ")'>" + jsonObj[i] +"</td></tr>";
		}
		htmlTxt += "</table>";
		vD.innerHTML = htmlTxt;
		vD.style.display = "block";
	}
	
	function select(index){
		f.toMem.value = jsonObj[index];
		document.getElementById("view").style.display = "none";
		check = false;
		loopKey = false;
	}
</script>

</head>

<nav class="navbar navbar">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#body"><img src="img/sum.png"
				alt="SumWare"></a> <a class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse"> <span
				class="glyphicon glyphicon-chevron-down"></span>
			</a>
		</div>
		<div class="nav navbar-right">
			<ul class="nav navbar-nav">
				<li><a href="sumware?model=index">메인</a></li>
				<li><a href="sumware?model=todo&submod=todoForm&memnum=${sessionScope.v.memnum}&memdept=${sessionScope.v.memdept}">Todo</a></li>
				<li><a href="sumware?model=mail&submod=mailMain">Mail</a></li>
				<li><a href="sumware?model=calendar&submod=calList">Calendar</a>
				<li><a href="sumware?model=board&submod=boardList&page=1">Board</a></li>
				<li><a href="javascript:openWin()">Messenger</a></li>
			</ul>
			<c:if test="${!empty sessionScope.v.memnum}">
				<ul class="nav navbar-right navbar-nav">
					<li><a href="sumware?model=login&submod=logout&memnum=${sessionScope.v.memnum}"><i class="fa fa-check fa-lg"></i>로그아웃</a></li>
				</ul>
			</c:if>
		</div>
	</div>
</nav>