<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<form method="post" action="samailSetDel" id="listform">
		<input type="hidden" id="delvalue" name="delvalue">
		<input type="hidden" name="tofrom" value="${tofrom}">
		<input type="hidden" name="page" value="1">
		<input type="hidden" id="mailnum" name="mailnum">
		
		<!-- button-div(S) -->
		<div class="button-div button-div-top">
			<!-- left(S) -->
			<div class="left">
				<a href="javascript:mailWriteFormGo()" class="btn btn-info"> 
				<span class="glyphicon glyphicon-pencil"></span> 메일 쓰기
				</a>
				<c:choose>
					<c:when test="${tofrom eq '1'}">
						&nbsp;&nbsp;&nbsp;&nbsp;받은 메일함 ${numArr[0]}
					</c:when>
					<c:when test="${tofrom eq '2'}">
						&nbsp;&nbsp;&nbsp;&nbsp;보낸 메일함 ${numArr[1]}
					</c:when>
					<c:when test="${tofrom eq '3'}">
						&nbsp;&nbsp;&nbsp;&nbsp;내게 쓴 메일함 ${numArr[2]}
					</c:when>
					<c:otherwise>
						&nbsp;&nbsp;&nbsp;&nbsp;휴지통 ${numArr[3]}
					</c:otherwise>
				</c:choose>
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
					value="samailFromList?usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:when>
				<c:when test="${tofrom eq '2'}">
					<c:set var="pageUrl" 
					value="samailToList?usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:when>
				<c:when test="${tofrom eq '3'}">
					<c:set var="pageUrl" 
					value="samailMyList?usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:when>
				<c:otherwise>
					<c:set var="pageUrl" 
					value="samailTrashcan?usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}"/>
				</c:otherwise>
			</c:choose>
			<c:choose>
	<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
	<c:otherwise>
		<%-- <button type="button" class="paging-prev">&lt;&lt;</button> --%>
		<a class="page-first" href="${pageUrl}&page=${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">&lt;&lt;</a>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
		<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
			<a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
        </c:forEach>
	</c:when>
	<c:otherwise>
		<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
            <a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
        </c:forEach>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
	<c:otherwise>
		<a class="page-last" href="${pageUrl}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">&gt;&gt;</a>
	</c:otherwise>
</c:choose>
		</div>

