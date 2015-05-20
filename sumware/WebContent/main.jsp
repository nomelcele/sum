<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		${sessionScope.v.memname }님 로그인하셨습니다.
		<ul>
			<li><a href="sumware?mod=todo&submod=todoForm">Todo</a></li>
			<li><a href="sumware?mod=mail&submod=mailMain">Mail</a></li>
		</ul>
	</div>
</body>
</html>