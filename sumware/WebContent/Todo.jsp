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
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
	function addTodoForm(){
		var memnum="${sessionScope.v.memnum }";
			window.open("sumware?mod=todo&submod=addTodoForm&memmgr="+memnum,'업무 추가','width=532,height=520,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,left=150,top=100');
	}
	function checkTodoList(){
		var memnum="${sessionScope.v.memnum }";
			window.open("sumware?mod=todo&submod=checkTodoList&memnum="+memnum,'업무 리스트 확인','width=532,height=520,toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,left=150,top=100');
	}

</script>
<body>
	${sessionScope.v.memnum }
	<div id="left" style="width:300px; height:700px; border:1px solid; float:left">
		<div id="profile">
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
		</div>
		<div id="menu" style="border:1px solid">
				
				<a href="">부서업무</a></br>
				<a href="">팀 업무</a></br>
				
				
					<c:if test="${sessionScope.v.memauth lt 5 }">
						<a href="javascript:checkTodoList()">업무관리</a></br>
					</c:if>
					<c:if test="${sessionScope.v.memauth lt 4 }">
						<a href="javascript:addTodoForm()">업무추가</a></br>
					</c:if>

				
				
				
				
				
				
		</div>
	</div>
	
	
	
	<div style="width:700px; height:700px; border:1px solid; float:left">
		<div style="width:650px; height:200px; border:1px dotted">
			<table>
				<tr>
				<td>부서업무 or 팀 업무</td>
				</tr>
				<tr>
					<td>
						<table style="border:1px solid">
							<tr>
								<td style="widht:50px; height:190; border:2px solid">a팀 업무</td>
								<td style="widht:50px; height:190; border:2px solid">b팀 업무</td>
								<td style="widht:50px; height:190; border:2px solid">c팀 업무</td>
							</tr>
						
						
						</table>
					
					
					</td>
				
				</tr>
			
			
			</table>
		
		
		
		</div>
		
		<div style="width:650px; height:490px; border:1px dotted">
		
		
		
		
		
		
		</div>
	
	
	
	
	
	
	
	
	
	
	</div>
	
	
	
	
	
	
</body>
</html>