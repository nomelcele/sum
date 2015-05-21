<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardList</title>
<style>
	#wrap {margin: auto;width:500px;text-align: center;}
	#wrap table{border:1px solid;}
	#wrap table thead td{
		background-color: aqua; text-align: center;
		border:1px dotted;
	}
</style>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
	$(function(){
		$('#mod').click(function(){
			$(this).attr("value","board");
			$('#submod').attr("value","writeForm");
			$('form').submit();
		})
	});
</script>
</head>
<body>
	<div id="wrap">
		<table>
			<thead>
				<tr>
					<td style="text-align: right;" colspan="5">
						<form action="sumware" method="post">
							<button name="mod" id="mod">글쓰기</button>
							<input type="hidden" name="submod" id="submod">
						</form>
					</td>
				</tr>
				<tr>
					<td style="width:70px;">글번호</td>
					<td style="width:200px;">글제목</td>
					<td style="width:80px;">작성자</td>
					<td style="width:100px;">작성일</td>
					<td style="width:70px;">조회수</td>
				</tr>
			</thead>
			<%-- 반복 구간 시작 --%>
			<tbody>
				<c:forEach items="${list }" var="vlist">
				<tr>
					<td>${vlist.bnum }</td>
					<td style="text-align: left">${vlist.btitle }</td>
					<td>${vlist.bwriter }</td>
					<td>${vlist.bdate }</td>
					<td>${vlist.bhit }</td>
				</tr>
				</c:forEach>
			</tbody>
			<%-- 반복 구간 끝 --%>
			<tfoot>
				<tr>
					<td colspan="5">
						<c:set var="pageUrl" value="sumware?mod=board&submod=boardList"/>
						<%@include file="page.jsp" %>
					</td>
				</tr>
			</tfoot>
		</table>
		
	</div>
</body>
</html>