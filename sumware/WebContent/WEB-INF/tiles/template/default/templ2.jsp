<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<title>SumWare</title>
<!-- CSS 라이브러리(S)  -->
<spring:url value="resources/css/common.css" var="css" />
<spring:url value="resources/font-awesome/css/font-awesome.css"	var="font" />
<spring:url value="resources/font-awesome/css/font-awesome.min.css"	var="font2" />
<spring:url value="resources/css/bootstrap.min.css" var="boot" />
<link rel="stylesheet" type="text/css" href="${css }" />
<link rel="stylesheet" type="text/css" href="${font }" />
<link rel="stylesheet" type="text/css" href="${font2}" />
<link rel="stylesheet" type="text/css" href="${boot}" />
<!-- CSS 라이브러리(E)  -->
<!-- 자바스크립트 -->
<!-- todo일 때 sns부분 -->
<!-- 모달 -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="js/sumware.js"></script>
<script src="js/http.js"></script>
<!-- <script src="js/bootstrap.min.js"></script> -->
<script src="js/notification.js"></script>
<script>
$(function(){
	if("${not empty param.fail }"=="true"){
		capCount = "${sessionScope.capCount}";
		alert("로그인 "+capCount+"회 실패");
		if(capCount>3){
			openCap();
		}
	}
	if("${empty v.meminmail}"=="false"){
		//메신저
		console.log("Messenge typeof:" + typeof (EventSource));
		if (typeof (EventSource) != "undefined") {
			var eventMesSourceList = new EventSource("samesCountMsg");
			eventMesSourceList.onmessage = function(event) {
				$('#countRoomNum').html(event.data);
			};
		} else {
			alert("해당 브라우저는 지원이 안됩니다.");
		}
		// The user needs to allow this
		console.log("meminmail:::${v.meminmail}");
		if (typeof (EventSource) != "undefined") {
			// push를 받을수 있는 브라우져인지 판단.
			eventSourceCount = new EventSource(
					"satmCount?mailreceiver=${v.meminmail}&memnum=${v.memnum}");
			eventSourceCount.onmessage = function(event) {
				var data = event.data;
				console.log("notification::"+data);
				if(data=="tx"){
					console.log("todo");
					Notify("todo","새로운 업무가 등록되었습니다.","safirsttodoForm?model=todo");
				}else if(data=="m"){
					console.log("mail");
					Notify("mail","새로운 메일이 도착하였습니다.","samailFromList?model=mail&page=1");
				}else if(data=="tm"){
					console.log("todo&mail");
					Notify("todo","새로운 업무가 등록되었습니다.","safirsttodoForm?model=todo");
					setTimeout(function(){
						Notify("mail","새로운 메일이 도착하였습니다.","samailFromList?model=mail&page=1");
					}, 3000);
				}
			};
		} else {
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
		
		if(typeof(EventSource)!="undefined"){
			console.log("conf notification");
			eventSourceConf = new EventSource("saconfNotify?confmem=${v.memnum}");
			eventSourceConf.onmessage = function(event){
				Notify("Conference","회의에 초대되셨습니다.",event.data);
			}
		} else {
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
	}
	
	
});
</script>
</head>
<body>
	<tiles:insertAttribute flush="true" name="header" />
	<div class="content">
		<!-- body -->
		<tiles:insertAttribute flush="true" name="body" />
	</div>
	<!-- footer -->
	<tiles:insertAttribute flush="true" name="footer" />
</body>
</html>