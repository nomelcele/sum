<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<td><a href="javascript:mailDetailGo(${mList.mailnum})">${mList.mailtitle}</a></td>
						<td>${mList.maildate}</td>
					</tr>
				</c:forEach>
		</table>
	</div>
<script>
	function mailDetailGo(mailnum){
		// 상세 보기 페이지로 이동시켜주는 함수
		$.ajax({
			type: "post",
			url: "sumware",
			data: {model: "mail",
				submod: "mailDetail",
				mailnum: mailnum}, // 해당 메일의 번호
			success: function(result){
				$("#mainContent").html(result);
			}
		});
	}
</script>