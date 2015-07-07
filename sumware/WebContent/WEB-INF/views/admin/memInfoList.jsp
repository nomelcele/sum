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
					</tr>
					
					<c:forEach var="mList" items="${list}">
						<tr>
							<td><input type="checkbox" name="chk" id="chk" value="${mList.memnum}"></td>
							<td>${mList.membirth}</td>
							<td>${mList.memaddr}</td>
							<td>${mList.meminmail}</td>
							<td>${mList.dename}</td>
							<td>${mList.memjob}</td>
							<td>${mList.memhire}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>