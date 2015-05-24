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
<!-- <script> -->
// 	$(function(){
// 		$("#btnIn").click(function(){
			
// 			var fdata = {				
<%-- 				toNum:<%=request.getAttribute("toNum")%>,		 --%>
<%-- 				key:<%=request.getAttribute("key")%>, --%>

// 			};
// 			alert("초대하였습니다.");
// 			$.ajax({
// 				type:"POST",
// 				url:"main.jsp",
// 				data:fdata
// 			});
// 			// page이동을 방지
// 			return false;
// 		});
// 	});
<!-- </script> -->

</head>
<body>

<div class="container">
	<div class="col-lg-9">

<!-- 		db에 저장된 내용 출력 -->
		<div class="col-lg-7">
			<span><%=request.getAttribute("toNum")%>받는 사람 이름 출력</span>
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
					<button class="btn btn-default" type="button" id="btnIn">초대</button>
				</span>
			</div>
		</div>
	</div>
</div>
<script>
	//var sessionKey = Math.random();
	var sessionKey = "<%=request.getAttribute("key")%>";
	alert("sessionKey " + sessionKey);
	var msgWindow = document.getElementById("msgWindow");
	var msgSocket = new WebSocket("ws://192.168.0.4:80/sumware/msgSocket/"+sessionKey)
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
		alert("msgWindow"+msgWindow);
		msgWindow.value += "${sessionScope.v.memname } 님 : "+message.data + "\n";
		
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



</body>
</html>