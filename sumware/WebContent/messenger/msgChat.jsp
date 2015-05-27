<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ChatRoom</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<!--  
<input type="hidden" id="chatmodel"name="model">
		<input type="hidden" id="chatsubmod"name="submod">
		<input type="hidden" id="chatuserNum"name="userNum">
		<input type="hidden" id="roomKey" name="roomKey"
-->
<script>
	function closeWindow(){
		if(confirm("대화를 종료 하시겠습니까?") == true){	
			alert("대화창이 닫힙니다.")
			$('#chatmodel').attr('value','messenger');
			$('#chatsubmod').attr('value','closeChat');
			$('#chatuserNum').attr('value',"${userNum}");
			$('#roomKey').attr('value',"${key}");
			$('#resState').attr('value',"room");			
			$('#closeForm').submit();
			setTimeout("window.close()", 10);
			alert("창이 닫혀여~~");
		
		}else{
			return;
		}
	}
	



</script>


</head>
<body>

<div class="container">
	<div class="col-lg-9">
	<form action="sumware" method="post" id="closeForm" name="closeForm">
		<input type="hidden" id="chatmodel"name="model">
		<input type="hidden" id="chatsubmod"name="submod">
		<input type="hidden" id="chatuserNum"name="userNum">
		<input type="hidden" id="roomKey" name="roomKey">
		<input type="hidden" id="resState" name="resState">		
	</form>
	
	

<!-- 		db에 저장된 내용 출력 -->
		<div class="col-lg-7">
			<span>${key} 받는 사람 이름 출력</span>
		</div>
			
		<div class="col-lg-10" style="height: 450px; width: 500px;">
			<textarea class="form-control" rows="30" id="msgWindow" style="width: 450px"></textarea>
		</div>

<!-- 		메세지 입력  -->
		</br>
		<div class="col-lg-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="메세지를 입력하세여" id="msgText" />
				<span class="input-group-btn">			
					<button class="btn btn-default" type="button" onclick="sendMsg()">전송</button>
					<button class="btn btn-default" type="button" onclick="closeWindow()">나가기</button>					
				</span>
			</div>
		</div>
	</div>
</div>
<script>
	
// 	var reip="${ipAdd}";	
// 	var webs = "ws://192.168.7.234:80/sumware/msgSocket/";
// 	var msgSocket = new WebSocket("ws://192.168.7.234:80/sumware/msgSocket/"+sessionKey);
	
	var sessionKey = "${key}";
	var userNum="${userNum}";
	alert("sessionKey " + sessionKey);
	var msgWindow = document.getElementById("msgWindow");	
	var msgSocket = new WebSocket("ws://localhost:80/sumware/msgSocket/"+sessionKey);
	
	msgSocket.onopen = function processOpen(message) {
		joinMsg(message);
		
	}
	msgSocket.onmessage = function processMessage(message) {
		processMsg(message);
	}
	msgSocket.onclose = function processClose(message) {
		proccessClose(message);
		
	}
	msgSocket.onerror = function processError(message) {
		proccessError(message);
	}
	function joinMsg(message) {
		alert("상대방이 입장하였습니다.");
	}
	function processMsg(message) {
		alert("msgWindow"+msgWindow);
		msgWindow.value += message.data + "\n";
		
	}
	function proccessClose(message) {

	}
	function proccessError(message) {

	}
	function sendMsg() {
		var msg = document.getElementById("msgText");
		var sendCont = "${sessionScope.v.memname } : "+msg.value+"\n";
// 		console.log("보낸 메세지 : "+sendCont);
		
		msgSocket.send(sendCont);
		msg.value = "";
		senCont = "";
	}
	

	
	
	
</script>



</body>
</html>