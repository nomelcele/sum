<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="global" class="wrap-layout board">
	<div id="lnb-area" class="lnb-area">
		<!-- left menu !!!! 들어갈 자리 -->
	</div>
	<div class="contents">
	<form method="post" action="sumware" id="listform">
		<input type="hidden" id="model" name="model">
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="usernum" name="usernum">
		<input type="hidden" id="userid" name="userid">
		<input type="hidden" id="delvalue" name="delvalue">
		<input type="hidden" id="mailnum" name="mailnum">
		<input type="hidden" id="tofrom" name="tofrom">
		
		<!-- button-div(S) -->
		<div class="button-div button-div-top">
			<!-- left(S) -->
			<div class="left">
				<a href="javascript:mailFormGo('write')" class="btn btn-info"> 
				<span class="glyphicon glyphicon-pencil"></span> 메일 쓰기
				</a>
			</div>
			<!-- left(E) -->
			<!-- right(S) -->
			<div class="right">
				<c:choose>
					<c:when test="${tofrom eq '4'}">
					<input type="button" class="btn btn-default btn-sm" value="영구 삭제" onclick="maildeleteGo()">
					<input type="button" class="btn btn-default btn-sm" value="복구" onclick="mailRecover()">
					</c:when>
					<c:otherwise>
					<input type="button" class="btn btn-default btn-sm" value="삭제" onclick="mailTrashGo()">
					</c:otherwise>
				</c:choose>
			</div>
			<!-- right(E) -->
		</div>
		<!-- button-div(E) -->
		
		<div>
			<table class="table table-condensed table-hover" id="listTable">
				<tbody>
					<tr style="background-color: #F5F5F5;">
						<td class="col-lg-1"><input type="checkbox" name="all" onclick="checkAll(this)"></td>
							<c:choose>
							<c:when test="${tofrom eq '1'}">
								<td class="col-lg-1"><span>보낸 사람</span></td>
							</c:when>
							<c:when test="${tofrom eq '2'}">
								<td class="col-lg-1"><span>받는 사람</span></td>
							</c:when>
							<c:when test="${tofrom eq '3'}">
								<td class="col-lg-1"><span>보낸 사람</span></td>
							</c:when>
							<c:otherwise>
								<td class="col-lg-1"><span>보낸 사람</span></td>
								<td class="col-lg-1"><span>받는 사람</span></td>
							</c:otherwise>
							</c:choose>
						<td class="col-lg-6"><span>제목</span></td>
						<td class="col-lg-2"><span>보낸 날짜</span></td>
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
				</tbody>
			</table>
		</div>
		
		</form>
		<%-- 원래 위치 --%>
		<div class="paging">
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
			<%@include file="../board/page.jsp"%>
		</div>
	</div>
</div>

<script>
	function mailTrashGo(){
		location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
				"&userid=${sessionScope.v.meminmail}&delvalue=2&tofrom=${tofrom}"+
				"&page=1&chk="+$("#chk:checked").serialize();
	}
	
	function maildeleteGo(){
		// 휴지통에서 체크된 메일들을 영구 삭제
		if(!confirm("선택한 메일을 영구 삭제하겠습니까?")){
			return; // 취소를 할 경우 삭제되지 않는다.
		} else { // 확인 버튼을 누르면 메일 삭제
			location="sumware?model=mail&submod=mailSetDel&usernum=${sessionScope.v.memnum}"+
			"&userid=${sessionScope.v.meminmail}&delvalue=3&tofrom=${tofrom}"+
			"&page=1&chk="+$("#chk:checked").serialize();
		}
	}
	
	function mailRecover(){
		// 휴지통에서 체크된 메일들을 복구(메일함으로 이동시킴)
		// 체크된 메일들의 delete 속성을 1로 변경
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
	}
</script>

