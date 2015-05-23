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
	<div class="container">
		<table class="table table-condensed table-hover">
				<tr>
					<td>선택</td>
					<!-- 받은 메일함을 클릭했을 때 -->
					<c:if test="${tofrom eq '1' }">
						<td>보낸 사람</td>
					</c:if>
					<!-- 보낸 메일함을 클릭했을 때 -->
					<c:if test="${tofrom eq '2' }">
						<td>받는 사람</td>
					</c:if>
					<td>제목</td>
					<td>보낸 날짜</td>
				</tr>
				<c:forEach var="mList" items="${list}">
					<tr>
						<td><input type="checkbox" name="num" id="num"></td>
						<c:if test="${tofrom eq '1' }">
							<td>${mList.mailmem}</td>
						</c:if>
						<c:if test="${tofrom eq '2' }">
							<td>${mList.mailreceiver}</td>
						</c:if>
						<td>${mList.mailtitle}</td>
						<td>${mList.maildate}</td>
					</tr>
				</c:forEach>
		</table>
	</div>