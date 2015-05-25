<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="container">
	<input type="button" value="삭제" id="delBtn" name="delBtn" 
	onclick="javascript:mailTrashGo()">
		<table class="table table-condensed table-hover">
				<tr>
					<td><input type="checkbox" name="all" onclick="checkAll(this)"></td>
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
						<td><input type="checkbox" name="chk" id="chk" value="${mList.mailnum}"></td>
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
	</div>
<script>
	function mailTrashGo(){
		$.ajax({
			type: "post",
			url: "sumware",
			data: {model: "mail",
				submod: "mailTrash",
				usernum: "${sessionScope.v.memnum}",
				userid: "${sessionScope.v.meminmail}"
			}
		});
	}

	function checkAll(obj){
		// 체크박스 전체 선택(해제)을 해주는 메서드
		var chkArr = document.getElementsByName("chk");
		var len = chkArr.length;
		
		for(var i=0; i<len; i++){
			if(obj.checked){
				chkArr[i].checked = true;
			} else {
				chkArr[i].checked = false;
			}
		}
	}
	
	function mailDetailGo(mailnum){
		// 상세 보기 페이지로 이동시켜주는 함수
		console.log("메일 번호: "+mailnum);
		$.ajax({
			type: "post",
			url: "sumware",
			data: {model: "mail",
				submod: "mailDetail",
				mailnum: mailnum // 해당 메일의 번호
				},
			success: function(result){
				$("#mainContent").html(result);
			}
		});
	}
	
</script>

