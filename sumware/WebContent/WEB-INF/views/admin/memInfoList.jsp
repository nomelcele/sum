<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    	<div>
			<table class="table table-condensed table-hover" id="listTable">
				<tbody>
					<tr style="background-color: #F5F5F5;">
						<td class="col-lg-1"><input type="checkbox" name="all" onclick="checkAll(this)"></td>
						<td class="col-lg-1"><span>이름</span></td>
						<td class="col-lg-1"><span>생년월일</span></td>
						<td class="col-lg-1"><span>주소</span></td>
						<td class="col-lg-1"><span>ID</span></td>
						<td class="col-lg-1"><span>부서</span></td>
						<td class="col-lg-6"><span>직급</span></td>
						<td class="col-lg-2"><span>입사일</span></td>
						<td class="col-lg-2"><span>호봉</span></td>
					</tr>
					
					<c:forEach var="memList" items="${list}">
						<tr>
							<td><input type="checkbox" name="chk" id="chk" value="${memList.memnum}"></td>
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