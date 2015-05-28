<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	
	var sessionKey = "${key}";
	var msgSocket = new WebSocket("ws://192.168.7.234:80/sumware/msgSocket/"+sessionKey);
	
	msgSocket.onopen = function processOpen(message) {
		joinMsg(message);
	}
	msgSocket.onmessage = function processMessage(message) {
		processMsg(message);
	}
// 	msgSocket.onclose = function processClose(message) {
// 		proccessClose(message);
		
// 	}
// 	msgSocket.onerror = function processError(message) {
// 		proccessError(message);
// 	}
	function joinMsg(message) {
		refuseMsg();
	}
	function processMsg(message) {
		msgWindow.value += message.data + "\n";
		
	}
// 	function proccessClose(message) {
// 		sendcloseMsg();
// 	}
// 	function proccessError(message) {

// 	}
// 	function sendMsg() {

// 	}
	function refuseMsg(){
// 		var sendjoinmsg = document.getElementById("msgText");
		var refuseMessage = "${sessionScope.v.memname }님이 대화를 거절하였습니다."+"\n";
		
		msgSocket.send(refuseMessage);
// 		sendjoinmsg.value = "";
		refuseMessage = "";
		closeWindow();
	}	
	function closeWindow(){
		setTimeout("window.close()", 5);
	}
</script>

</body>
</html>