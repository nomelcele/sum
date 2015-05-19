<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div style="width:300px; height:700px; border:1px solid">
		<div id=profile>
			<table style="border:1px solid">
				<tr>
					<td rowspan='4' style="width:30px; height:70px; border:1px solid"><img src="profileImg/${sessionScope.v.memprofile }"></td><td>이름 : ${sessionScope.v.memname }</td>
				</tr>
				<tr>
					<td>직급 : ${sessionScope.v.memjob }</td>
				</tr>
				<tr>
					<td>부서 : ${sessionScope.v.dename }</td>
				</tr>
				<tr>
					<td>상급자 : ${sessionScope.v.mgrname }</td>
				</tr>
			
			
			</table>
			<div style="border:1px solid">
				
				<a href="">부서업무</a></br>
				<a href="">팀 업무</a></br>
				<a href="">업무관리</a></br>
				<a href="">업무추가</a></br>
			</div>
		
		</div>
	
	</div>
</body>
</html>