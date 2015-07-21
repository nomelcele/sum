<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ChatRoom</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head>
<body>
<!-- 		db에 저장된 내용 출력 -->
<div class="col-lg-3" style="width: 100%">
	<div class="chat-panel panel panel-default">
	<form action="sacloseChat" method="post" id="closeForm" name="closeForm">
		<input type="hidden" id="chatuserNum"name="userNum">
		<input type="hidden" id="roomKey" name="roomKey">
		<input type="hidden" id="resState" name="resState">		
	</form>
		<div class="panel-heading">
			<i class="fa fa-bar-chart-o fa-fw"></i> <strong class="primary-font">${userName }님과 대화 중 입니다</strong>	
		</div>
		
		<div class="panel-body" id="scrollDiv">
			<textarea class="form-control" rows="20" id="msgWindow" name="textrareaChat"></textarea>
		</div>
		
		<div class="panel-footer">
			<div class="input-group">
				<input id="msgText" type="text" class="form-control input-sm" placeholder="메세지를 입력하세여" 
				onkeydown="javascript:enterCheck();">
				<span class="input-group-btn">
					<button class="btn btn-warning btn-sm" onclick="sendMsg()">Send</button>
					<button class="btn btn-warning btn-sm" onclick="closeWindow()">나가기</button>
				</span>
			</div>
		</div>
		
	</div>
</div>

<script>
	
	var sessionKey = "${key}";
	var userNum="${userNum}";
	var msgWindow = document.getElementById("msgWindow");
	var msgSocket = new WebSocket("ws://192.168.7.93:80/sumware/samsgSocket/"+sessionKey);
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
		sendjoinMsg();
	}
	function processMsg(message) {
		msgWindow.value += message.data + "\n";	
		$('#msgWindow').scrollTop(document.getElementById('msgWindow').scrollHeight);
	}
	function proccessClose(message) {
		sendcloseMsg();
	}
	function proccessError(message) {

	}
	function sendMsg() {
		var msgchat = document.getElementById("msgText");
		alert("메시지 내용:"+msgchat.value);
		var sendCont = "${sessionScope.v.memname } : "+msgchat.value+"\n";
		$('#msgWindow').scrollTop(document.getElementById('msgWindow').scrollHeight);
		msgSocket.send(sendCont);
		msgchat.value = "";
		senCont = "";
	}
	function sendjoinMsg(){
		var sendjoinmsg = document.getElementById("msgText");
		var joinMsg = "${sessionScope.v.memname }님이 입장하였습니다."+sendjoinmsg.value+"\n";
		
		msgSocket.send(joinMsg);
		sendjoinmsg.value = "";
		joinMsg = "";
	}
	function sendcloseMsg(){
		var sendclosemsg = document.getElementById("msgText");
		var closeMsg = "${sessionScope.v.memname }님이 퇴장하였습니다."+sendclosemsg.value+"\n";
		
		msgSocket.send(closeMsg);
		closeMsg.value = "";
		sendclosemsg = "";
	}
	function closeWindow(){
		if(confirm("대화를 종료 하시겠습니까?") == true){	
			sendcloseMsg();
			$('#chatuserNum').attr('value',"${userNum}");
			$('#roomKey').attr('value',"${key}");
			$('#resState').attr('value',"room");			
			$('#closeForm').submit();
			setTimeout("window.close()", 30);
		}else{
			return;
		}
	}	
	function enterCheck(){
		if(event.keyCode == 13){
			var inputLength = $('#msgText').val().length;
			if(inputLength > 0){				
				sendMsg();
				return;
			}
		}
	
	}
	
</script>
</body>
</html>