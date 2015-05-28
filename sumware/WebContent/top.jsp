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
<link type="text/css" href="css/common.css" rel="stylesheet" />
<!-- CSS 라이브러리(E)  -->
<!-- 자바스크립트 -->
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- 메인 -->
<c:if test="${param.submod eq 'writeForm' }">
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
	<script src="js/myckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			chkUpload();
		});
	</script>
</c:if>
<script>

	$(function() {
		var sel = "";
		var tonum = "";
		var res="";
		var tonumval="";
		selectMenu(sel);
		todoFormGo(res);
		tosend(tonumval);
		addTodo();
	});
	function openWin(){
		var opt= "width=700, height=800, scrollbars=yes";	
		window.open("sumware?model=messenger&submod=messengerForm","MessengerMain",opt);
	}
	function selectMenu(sel){
		// 메뉴 선택
			if(sel=='deptTodo'){
				// 부서업무 버튼
				$.ajax({
					type : "post",
					url : "sumware",
					data : {
						model:"todo", 
						submod:"todoForm",
						memdept:"${sessionScope.v.memdept}"
						},
					success : function(result){
					
							$("#menuTarget").html(result);

						}
					});
			}else if(sel=='giveJob1'){
				// 부장일 때 업무 부여 버튼
				$.ajax({
					type : "post",
					url : "sumware",
					data : {
						model:"todo", 
						submod:"addtodoForm",
						//memnum:"${sessionScope.v.memnum}"
						},
					success : function(result){
					
							$("#menuTarget").html(result);

						}
					});
			}else if(sel=='manageJob2'){
				// 팀장일 때 업무 관리 버튼
				$.ajax({
					type : "post",
					url : "sumware",
					data : {
						model:"todo", 
						submod:"checkTodoList",
						memnum:"${sessionScope.v.memnum}"
						},
					success : function(result){
					
							$("#menuTarget").html(result);

						}
					});
			}else if(sel=='manageJob1'){
				// 부장일 때 업무 관리 버튼
				$.ajax({
					type : "post",
					url : "sumware",
					data : {
						model:"todo", 
						submod:"fWMana",
						memnum:"${sessionScope.v.memnum}"
						},
					success : function(result){
					
							$("#menuTarget").html(result);

						}
					});
			}else if(sel=='giveJob2'){
				// 팀장일 때 업무 부여
				$.ajax({
					type : "post",
					url : "sumware",
					data : {
						model:"todo", 
						submod:"giveJobForm",
						memnum:"${sessionScope.v.memnum}"
						},
					success : function(result){
					
							$("#menuTarget").html(result);

						}
					});
			}else if(sel=='teamTodoForm'){
				// 팀 업무 버튼
				$.ajax({
					type : "post",
					url : "sumware",
					data : {
						model:"todo", 
						submod:"teamTodoForm",
						memmgr:"${sessionScope.v.memmgr}"
						},
					success : function(result){
					
							$("#menuTarget").html(result);

						}
					});
				
			}
	}
	
	function todoConfirm(res){
		if(res=='rejectTodo'){
			$.ajax({
				type : "post",
				url : "sumware",
				data : {
					model:"todo", 
					submod:"checkTodoList",
					childmod:"rejectTodo",
					tonum:$('#rtonum').val(),
					memnum:"${sessionScope.v.memnum }",
					tostdate:$('#rtostdate').val(),
					toendate:$('#rtoendate').val(),
					totitle:$('#rtotitle').val(),
					todept:$('#rtodept').val(),
					tocomm:$('#rtocomm').val()
					
					},
				success : function(result){
						setTimeout(function(){
							$("#menuTarget").html(result);
						}, 1000);
						

					}
				});
			alert("거절 완료되었습니다.");
		}else if(res=='approveTodo'){
			$.ajax({
				type : "post",
				url : "sumware",
				data : {
					model:"todo", 
					submod:"checkTodoList",
					childmod:"approveTodo",
					tonum:$('#atonum').val(),
					memnum:"${sessionScope.v.memnum }",
					tostdate:$('#atostdate').val(),
					toendate:$('#atoendate').val(),
					totitle:$('#atotitle').val(),
					todept:$('#atodept').val(),
					tocomm:$('#atocomm').val()
					
					},
				success : function(result){
						setTimeout(function(){
							$("#menuTarget").html(result);
						}, 1000);
						

					}
				});
			alert("승인 완료되었습니다.");
		}else if(res=='successTodo'){
			$.ajax({
				type : "post",
				url : "sumware",
				data : {
					model:"todo", 
					submod:"successJob",
					tonum:$('#stonum').val(),
					tocomm:$('#stocomm').val(),
					memmgr:"${sessionScope.v.memmgr}"
					},
				success : function(result){
						setTimeout(function(){
							$("#menuTarget").html(result);
						}, 1000);
						
					}
				});
			alert("업무 완료 처리 되었습니다.");
		}
		
	}
</script>
<!-- /메인 -->
<script>

	function todoFormGo(res){
		$('#model').attr("value","todo");
		if(res=='approveTodo'){
			// 팀장업무관리에서 승인버튼
			
			$('#okForm').submit();
		}else if(res=='rejectTodo'){
			// 팀장업무관리에서 거절버튼
			$('#rejectForm').submit();
			alert("거절 완료");
		}else if(res== 'addTodo'){
			//부장의 업무 추가 폼 작성 후 보내기버튼
			$('#addTodoForm').submit();
			alert("업무를 등록하였습니다.");
		}
	}
	
	function startSuggest(){
		if(check == false){
			setTimeout("sendKeyword();",500);
			loopKey = true;
		}
		check = true;
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
	

	function getJobDetail(tonum){
		$("#memlisttarget"+tonum).toggle("slow");
		$("#detail"+tonum).toggle("slow");
		$.ajax({
			type : "post",
			url : "sumware",
			data : {model:"todo", 
				submod:"showmemlist", 
				jobtonum:tonum,
				},
			success : function(result){
				$("#memlisttarget"+tonum).html(result);
			
			}
		});
	}


<%-- 메일 --%>
function mailFormGo(res){
	if(res=='write'){ // 메일 쓰기
		$("#submod").attr("value","mailWriteForm");
		$("#mailform").submit();
// 		$.ajax({
// 			type: "post",
// 			url: "sumware",
// 			data: {model: "mail",
// 				submod: "mailWriteForm"},
// 			success: function(result){
// 				$("#mainContent").html(result);
// 			}
// 		});
	} else if(res=='fromlist'){ // 받은 메일함
		$("#submod").attr("value","mailFromList");
		$("#mailform").submit();
	} else if(res=='tolist'){ // 보낸 메일함
		$("#submod").attr("value","mailToList");
		$("#mailform").submit();
	} else if(res=='mylist'){ // 내게 쓴 메일함
		$("#submod").attr("value","mailMyList");
		$("#mailform").submit();
	} else if(res=='trashcan'){ // 휴지통
		$("#submod").attr("value","mailTrashcan");
		$("#mailform").submit();
	} 
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
		var param = "model=mail&submod=mailSug&key="+encodeURIComponent(key);
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
<%--/메일--%>
</script>
</head>
<nav class="navbar navbar">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="sumware?model=index"><img src="img/sum.png"
				alt="SumWare"></a> <a class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse"> <span
				class="glyphicon glyphicon-chevron-down"></span>
			</a>
		</div>
		<c:choose>
   			<c:when test="${empty sessionScope.v.memnum && empty memnum}">
      		<form class="form-inline" role="form" action="sumware" method="post">
         		<input type="hidden" name="model" value="login"> 
         		<input type="hidden" name="submod" value="login">
         		<div class="porm-group">
            		<label class="control-label-" for="memnum">사원번호</label> 
            		<input type="text" id="memnum" name="memnum" placeholder="사원번호"> 
            		<label class="control-label" for="mempwd">비밀번호</label> 
            		<input type="password" id="mempwd" name="mempwd" placeholder="비밀번호">
            		<button class="btn btn-xs btn-info">로그인</button>
         		</div>
      		</form>
   			</c:when>
   			<c:otherwise>
<!-- 		   	<div class="porm-group"> -->
<!-- 		    </div> -->
    		<div class="nav navbar-right">
				<ul class="nav navbar-nav">
					<li><a href="sumware?model=index">메인</a></li>
					<li><a href="sumware?model=todo&submod=firsttodoForm&memnum=${sessionScope.v.memnum}&memdept=${sessionScope.v.memdept}">Todo</a></li>
					<li><a href="sumware?model=mail&submod=mailMain">Mail</a></li>
					<li><a href="sumware?model=calendar&submod=calList">Calendar</a>
					<li><a href="sumware?model=board&submod=boardList&page=1&bdeptno=${sessionScope.v.memdept }">Board</a></li>
					<li><a href="javascript:openWin()">Messenger</a></li>
				</ul>
				<ul class="nav navbar-right navbar-nav user-name">
			        <li><span class="control-label-" for="sabun"> <strong>${sessionScope.v.memname}</strong> 님 환영합니다.</span></li>
					<li><a href="sumware?model=login&submod=logout&memnum=${sessionScope.v.memnum}"><i class="fa fa-check fa-lg"></i>로그아웃</a></li>
				</ul>
			</div>
   			</c:otherwise>
   		</c:choose>
	</div>
</nav>