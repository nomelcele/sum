<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

</head>
<body>
	<div class="container">


<textarea rows="30" cols="30" id="msgWindow"></textarea>
<br/>
<input type="text" id="msgText">
<input type="button" onclick="sendMsg();" value="전송"></input>
<input type="button" onclick="closeWindow();" value="나가기"></input>


<script>
	//var sessionKey = Math.random();
	var sessionKey = "<%=request.getAttribute("key")%>";
	alert("sessionKey " + sessionKey);
	var msgWindow = document.getElementById("msgWindow");
	var msgSocket = new WebSocket("ws://localhost:80/sumware/msgSocket/"
			+ sessionKey)
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
		
	}
	function processMsg(message) {
		alert("message.date : "+message.data);
		alert("msgWindow : "+msgWindow);
		msgWindow.value += "receiver from server => " +message.data+"\n";
	}
	function proccessClose(message) {

	}
	function proccessError(message) {

	}
	function sendMsg() {
		var msg = document.getElementById("msgText");
		msgSocket.send(msg.value);
		msg.value = "";
	}
</script>

</div>
</body>
</html>