<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
	function gogo() {
		$('#userid').attr("value", "${sessionScope.v.meminmail}");
		$('#mailgogo').submit();
	}
	
	function write(){
		$('#mailwrite').submit();
	}
	
	$(function(){
		$('#logout').click(function(){
			$('#logoutForm').submit();
		});
	});
	
</script>
</head>
<body>
	<div>${sessionScope.v.memname }님</div>
	<div>
		<input type="button" id="logout" value="로그아웃">
	</div>
	<div>
		<ul>
			<li><a href="javascript:write()">메일 쓰기</a></li>
			<li><a href="javaScript:gogo()">받은 메일함</a></li>
			<li>보낸 메일함</li>
			<li>휴지통</li>
		</ul>
	</div>
	<form method="post" action="sumware" id="mailgogo">
		<input type="hidden" name="mod" value="mail"> 
		<input type="hidden" name="submod" value="mailList">
		<input type="hidden" id="userid" name="userid">
	</form>
	<form method="post" action="sumware" id="logoutForm">
		<input type="hidden" name="mod" value="login"> 
		<input type="hidden" name="submod" value="logout">
		<!-- 로그아웃 -->
	</form>
	<form method="post" action="sumware" id="mailwrite">
		<input type="hidden" name="mod" value="mail">
		<input type="hidden" name="submod" value="mailWriteForm">
	</form>
</body>
</html>