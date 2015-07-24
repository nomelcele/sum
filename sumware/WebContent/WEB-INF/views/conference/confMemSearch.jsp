<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<!-- List (S) -->
			<div>
				<table class="table table-condensed table-hover" id="memberList">
					<tbody>
						<tr style="background-color: #F5F5F5;">
							<td class="col-lg-1"><input type="checkbox" name="all"
								onclick="checkAll(this,'chk')"></td>
							<td class="col-lg-1"><span>이름</span></td>
							<td class="col-lg-1"><span>부서</span></td>
							<td class="col-lg-1"><span>직급</span></td>
						</tr>

						<c:forEach var="mList" items="${list}">
							<tr>
								<td><input type="checkbox" name="chk" id="chk" value="${mList.memnum}" 
								onclick="goToList(this,${mList.memnum},'${mList.memname}','${mList.dename}','${mList.memjob}')"></td>
								<td>${mList.memname}</td>
								<td>${mList.dename}</td>
								<td>${mList.memjob}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- List (E) -->
			
			
					<!-- paging(S) -->
		<div id="paging" style="text-align:center;">
			<input type="hidden" name="page" id="page"> 
			<input type="hidden" id="memdept" name="memdept" value="${pdept}">
			<input type="hidden" id="memname" name="memname" value="${pname}">
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<a class="page-first" href="javascript:goMemPage(${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock })">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="javascript:goMemPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count })">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
						<a href="javascript:goMemPage(${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count })">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="javascript:goMemPage(${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 })">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- paging(E) -->