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
	function formGoGo(res){
		if(res==1){
			$('#mod').attr("value","todo");
			$('#submod').attr("value","todoForm");
		}else if(res==2){
			$('#mod').attr("value","mail");
			$('#submod').attr("value","mailMain");
		}else if(res==3){
			$('#mod').attr("value","calendar");
			$('#submod').attr("value","calList");
		}else if(res==4){
			$('#mod').attr("value","board")
			$('#submod').attr("value","boardList")
		}
		$('form').submit();
	}
</script>
</head>
<body>
	<form action="sumware" method="post">
		<input type="hidden" id="mod" name="mod">
		<input type="hidden" id="submod" name="submod">
	</form>
	<div>
		${sessionScope.v.memname }님 로그인하셨습니다.
		<ul>
			<li><a href="javaScript:formGoGo(1)">Todo</a></li>
			<li><a href="javaScript:formGoGo(2)">Mail</a></li>
			<li><a href="javaScript:formGoGo(3)">Calendar</a>
			<li><a href="javaScript:formGoGo(4)">Board</a></li>
		</ul>
	</div>
</body>
</html>