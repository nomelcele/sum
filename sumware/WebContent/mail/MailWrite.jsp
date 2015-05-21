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
	<fieldset>
	<legend>메일 전송</legend>
	<form method="post" action="sumware?mod=mail&submod=mailWrite"> <!-- 메일 전송 처리 -->
		<input type="hidden" name="fromMem" value="${sessionScope.v.memnum}">
		<!-- 보내는 사람의 사원 번호(현재 로그인한 사원의 사원 번호) -->
		<table>
			<tr>	
				<td>받는 사람</td>
				<td><input type="text" name="toMem" id="toMem" style="width: 300px;"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" id="title" style="width: 400px;"></td>
			</tr>
			<!-- 첨부파일 
			추후 체크에디터 넣을 예정 -->
			<tr>
				<td>내용</td>
				<td><textarea name="content" id="content" style="width: 600px; height: 400px;"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="전송">
				</td>
			</tr>
		</table>
	</form>
	</fieldset>
	</div>
</body>
</html>