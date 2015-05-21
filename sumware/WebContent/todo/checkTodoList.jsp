<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>


	function viewDetail(res){
		$(".title"+res).show();
	};
	
	function approveTodo(res, mnum){
		var fdata = {tonum:res,memnum:mnum};
		$.ajax({
			type:"POST",
			url:"sumware?mod=todo&submod=checkTodoList&childmod=approveTodo",
			data:fdata
		});
		alert("승인이 완료되었습니다.");
		$(".title"+res).hide("slow");
		
	}
	function rejectTodo(res, mnum){
		var fdata = {tonum:res,memnum:mnum};
		$.ajax({
			type:"POST",
			url:"sumware?mod=todo&submod=checkTodoList&childmod=rejectTodo",
			data:fdata
		});
		alert("거절이 완료되었습니다.");
		$(".title"+res).hide("slow");
	}



</script>
<body>
	<h1>업무리스트</h1>
	<div>	
		<table style="border:1px solid">
			<tr style="border:1px solid">
				<td>업무 제목</td><td>업무 기간</td><td>승인 상태</td>
			</tr>
			<c:forEach var="tolist" items="${todoList }">
			<tr style="border:1px solid">
				<td><a href="javascript:viewDetail(${tolist.tonum })">${tolist.totitle }</a></td><td>${tolist.tostdate } ~ ${tolist.toendate }</td>
				<td><c:if test="${tolist.toconfirm eq 'n' }">미승인</c:if>
				<c:if test="${tolist.toconfirm eq 'y' }">승인</c:if>
				<c:if test="${tolist.toconfirm eq 'x' }">거절</c:if></td>

			</tr>
		
			
			<tr class="title${tolist.tonum }" style="border:1px dotted; display:none">
				<td colspan="2">${tolist.tocont }</td>
			</tr>
			<tr class="title${tolist.tonum }"  style="border:1px dotted; display:none">
				<td colspan="2">${tolist.tocomm }</td>
			</tr>
			<tr class="title${tolist.tonum }"  style="border:1px dotted; display:none">
				<td><input type="button" value="승인" onclick="javascript:approveTodo(${tolist.tonum }, ${sessionScope.v.memnum })"></td><td><input type="button" value="거절" onclick="javascript:rejectTodo(${tolist.tonum }, ${sessionScope.v.memnum })"></td>
			</tr>
			
			</c:forEach>
		</table>
	</div>

</body>
</html>