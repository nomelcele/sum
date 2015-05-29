<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
	<div class="row">
	<%@include file="/contentLeft.jsp" %>
	<div class="col-lg-10">
	<form method="post" action="sumware" id="listform">
		<input type="hidden" id="model" name="model">
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="usernum" name="usernum">
		<input type="hidden" id="userid" name="userid">
		<input type="hidden" id="delvalue" name="delvalue">
		<input type="hidden" id="mailnum" name="mailnum">
		<input type="hidden" id="tofrom" name="tofrom">
		<c:choose>
			<c:when test="${tofrom eq '4'}">
			<input type="button" value="영구 삭제" onclick="maildeleteGo()">
			<input type="button" value="복구" onclick="mailRecover()">
			</c:when>
			<c:otherwise>
			<input type="button" value="삭제" onclick="mailTrashGo()">
			</c:otherwise>
		</c:choose>
		<div class="row">
			<table class="table table-condensed table-hover" id="listTable">
					<tr>
						<td class="col-lg-1"><input type="checkbox" name="all" onclick="checkAll(this)"></td>
							<c:choose>
							<c:when test="${tofrom eq '1'}">
								<td class="col-lg-1">보낸 사람</td>
							</c:when>
							<c:when test="${tofrom eq '2'}">
								<td class="col-lg-1">받는 사람</td>
							</c:when>
							<c:when test="${tofrom eq '3'}">
								<td class="col-lg-1">보낸 사람</td>
							</c:when>
							<c:otherwise>
								<td class="col-lg-1">보낸 사람</td>
								<td class="col-lg-1">받는 사람</td>
							</c:otherwise>
							</c:choose>
						<td class="col-lg-6">제목</td>
						<td class="col-lg-2">보낸 날짜</td>
					</tr>
					
					<c:forEach var="mList" items="${list}">
						<tr>
							<td><input type="checkbox" name="chk" id="chk" value="${mList.mailnum}"></td>
							<c:choose>
							<c:when test="${tofrom eq '1'}">
								<td>${mList.mailsname}</td>
							</c:when>
							<c:when test="${tofrom eq '2' }">
								<td>${mList.mailrname}</td>
							</c:when>
							<c:when test="${tofrom eq '3'}">
								<td>${mList.mailsname}</td>
							</c:when>
							<c:otherwise>
								<td>${mList.mailsname}</td>
								<td>${mList.mailrname}</td>
							</c:otherwise>
							</c:choose>
							<td><a href="javascript:mailDetailGo(${mList.mailnum})">${mList.mailtitle}</a></td>
							<td>${mList.maildate}</td>
						</tr>
					</c:forEach>
			</table>
		</div>
		</form>
		<div id="page">
			<c:choose>
				<c:when test="${tofrom eq '1'}">
					<c:set var="pageUrl" 
					value="sumware?model=mail&submod=mailFromList&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:when>
				<c:when test="${tofrom eq '2'}">
					<c:set var="pageUrl" 
					value="sumware?model=mail&submod=mailToList&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:when>
				<c:when test="${tofrom eq '3'}">
					<c:set var="pageUrl" 
					value="sumware?model=mail&submod=mailMyList&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:when>
				<c:otherwise>
					<c:set var="pageUrl" 
					value="sumware?model=mail&submod=mailTrashcan&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:otherwise>
			</c:choose>
			<%@include file="mailPage.jsp"%>
		</div>
		</div>
		</div>
	</div>
	</section>
	<%@include file="/footer.jsp"%>
<script>
	function mailTrashGo(){
		alert("들어왓어");	
// 		$("#model").attr("value","mail");
// 		$("#submod").attr("value","mailSetDel");
// 		$("#usernum").attr("value","${sessionScope.v.memnum}");
// 		$("#userid").attr("value","${sessionScope.v.meminmail}");
// 		$("#delvalue").attr("value",2);
// 		$("#tofrom").attr("value","${tofrom}");

		location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
				"&userid=${sessionScope.v.meminmail}&delvalue=2&tofrom=${tofrom}"+
				"&page=1&chk="+$("#chk:checked").serialize();
	}
	
	function maildeleteGo(){
		// 휴지통에서 체크된 메일들을 영구 삭제
// 		$("#submod").attr("value","mailSetDel");
// 		$("#usernum").attr("value","${sessionScope.v.memnum}");
// 		$("#userid").attr("value","${sessionScope.v.meminmail}");
// 		$("#delvalue").attr("value",3);
// 		$("#f").submit();
		
		location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
		"&userid=${sessionScope.v.meminmail}&delvalue=3&tofrom=${tofrom}"+
		"&page=1&chk="+$("#chk:checked").serialize();
	}
	
	function mailRecover(){
		// 휴지통에서 체크된 메일들을 복구(메일함으로 이동시킴)
		// 체크된 메일들의 delete 속성을 1로 변경
// 		$("#submod").attr("value","mailSetDel");
// 		$("#usernum").attr("value","${sessionScope.v.memnum}");
// 		$("#userid").attr("value","${sessionScope.v.meminmail}");
// 		$("#delvalue").attr("value",1);
// 		$("#f").submit();
		
		location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
		"&userid=${sessionScope.v.meminmail}&delvalue=1&tofrom=${tofrom}"+
		"&page=1&chk="+$("#chk:checked").serialize();
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
		location="sumware?model=mail&submod=mailDetail&mailnum="+mailnum+
				"&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}";
		
		
// 		$("#submod").attr("value","mailDetail");
// 		$("#mailnum").attr("value",mailnum);
// 		$("#f").submit();
		
		
// 		console.log("메일 번호: "+mailnum);
// 		$.ajax({
// 			type: "post",
// 			url: "sumware",
// 			data: {model: "mail",
// 				submod: "mailDetail",
// 				mailnum: mailnum // 해당 메일의 번호
// 				},
// 			success: function(result){
// 				$("#mainContent").html(result);
// 			}
// 		});
	}
</script>

