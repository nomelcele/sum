<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/top.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<table class="table table-condensed table-hover">
				<tr>
					<td>선택</td>
					<td>보낸사람</td>
					<td>제목</td>
					<td>보낸날짜</td>
				</tr>
				<c:forEach var="mList" items="${list}">
					<tr>
						<td><input type="checkbox" name="num" id="num"></td>
						<td>${mList.mailmem}</td>
						<td>${mList.mailtitle}</td>
						<td>${mList.maildate}</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	<%@include file="/footer.jsp" %>