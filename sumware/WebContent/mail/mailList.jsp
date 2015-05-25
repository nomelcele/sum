<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="container">
	<form name="ckform">
		<table class="table table-condensed table-hover">
				<tr>
					<td><input type="checkbox" onclick="checkAll()"></td>
					<!-- 받은 메일함을 클릭했을 때 -->
					<c:if test="${tofrom eq '1' || '3'}">
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
						<c:if test="${tofrom eq '1' || '3'}">
							<td>${mList.mailsname}</td>
						</c:if>
						<c:if test="${tofrom eq '2' }">
							<td>${mList.mailrname}</td>
						</c:if>
						<td><a href="javascript:mailDetailGo(${mList.mailnum})">${mList.mailtitle}</a></td>
						<td>${mList.maildate}</td>
					</tr>
				</c:forEach>
		</table>
	</form>
	</div>
<script>
	var ck = true;

	function mailDetailGo(mailnum){
		// 상세 보기 페이지로 이동시켜주는 함수
		$.ajax({
			type: "post",
			url: "sumware",
			data: {model: "mail",
				submod: "mailDetail",
				mailnum: mailnum, // 해당 메일의 번호
				mailmem: mailmem}, // 메일 보내는 사람
			success: function(result){
				$("#mainContent").html(result);
			}
		});
	}
	
	function checkAll(){
		var ckArr =	document.getElementById("num");
		var len = ckArr.length;
		
		for(var i=0; i<len; i++){
			if(ck){
				ckArr[i].checked = true;
				ck = false;
			} else {
				ckArr[i].checked = false;
				ck = true;
			}
		}
	}
</script>