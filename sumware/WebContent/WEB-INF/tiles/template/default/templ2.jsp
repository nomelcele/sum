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
<script>
$(function(){
	if("${empty v.meminmail}"=="false"){
		var notification = window.Notification || window.mozNotification || window.webkitNotification;
		// The user needs to allow this
		if ('undefined' === typeof notification)
		    alert('Web notification not supported');
		else
		    notification.requestPermission(function(permission){});
		console.log("meminmail:::${v.meminmail}");
		if (typeof (EventSource) != "undefined") {
			// push를 받을수 있는 브라우져인지 판단.
			eventSourceCount = new EventSource(
					"tmCount?mailreceiver=${v.meminmail}&memnum=${v.memnum}");
			eventSourceCount.onmessage = function(event) {
				var data = event.data;
				console.log("notification::"+data);
				if(data=="tx"){
					console.log("todo");
					Notify("todo","Good");
				}else if(data="m"){
					console.log("mail");
					Notify("mail","Good");
				}else if(data="tm"){
					console.log("todo&mail");
					Notify("todo","Good");
					setTimeout(function(){
						Notify("mail","Good");
					}, 3000);
				}
			};
		} else {
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
	}
	
	
});

// A function handler
function Notify(titleText, bodyText)
{
	console.log("Notify실행");
    if ('undefined' === typeof notification){
    	console.log("Notify지원안됨");
    	return false;
	}//Not supported....
    var noty = new notification( 
        titleText, {
            body: bodyText,
            dir: 'auto', // or ltr, rtl
            lang: 'EN', //lang used within the notification.
            tag: 'notificationPopup', //An element ID to get/set the content
            icon: '' //The URL of an image to be used as an icon
        }
    );
    noty.onclick = function () {
        console.log('notification.Click');
    };
    noty.onerror = function () {
        console.log('notification.Error');
    };
    noty.onshow = function () {
        console.log('notification.Show');
    };
    noty.onclose = function () {
        console.log('notification.Close');
    };
    return true;
}
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