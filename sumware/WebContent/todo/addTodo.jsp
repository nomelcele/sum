<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
$(function(){
	$('#f').submit(function(){
		// alert안해주고 바로 클로즈하면 파라미터 안보내짐..
		alert("추가되었습니다.");
		window.close();
	});
});
	

</script>
<body>
	<h1>업무추가</h1>
		<form action="sumware" method="post" name="f" id="f" enctype="multipart/form-data">
		<input type="hidden" name="mod" value="todo">
		<input type="hidden" name="submod" value="addTodo">
		<table>
			<tr>
			<td>
				<select name="tomem" >
					<option value="">팀장 선택</option>
					<c:forEach var="tNameList" items="${teamNameList}">
					<option value="${tNameList.memnum }">${tNameList.memname}</option>
					</c:forEach>
				</select>
			</td>
			</tr>
			<tr>
			<td>
				<input type="date" name="tostdate"> ~ <input type="date" name="toendate">
			</td>
			</tr>
			<tr>
			<td>
				<input type="text" id="totitle" name="totitle" placeholder="업무 제목">
			</td>
			</tr>
			<tr>
			<td>
				<input type="text" id="tocont" name="tocont" placeholder="업무 내용">
			</td>
			</tr>
			<tr>
			<td>
				<input type="file" id="tofile" name="tofile">
			</td>
			</tr>
			<tr>
			<td>
				<input type="text" id="tocomm" name="tocomm" placeholder="남길 말">
			</td>
			</tr>
			<tr>
				<td><input type="submit" value="추가" >
				<input type="hidden" name="todept" value="${sessionScope.v.memdept }">
				<input type="hidden" name="toconfirm" value="n">
				</td>
			</tr>
		
		</table>
		</form>
</body>
</html>
