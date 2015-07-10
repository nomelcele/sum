<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Search (S) -->
		<div>
			<input type="text" id="searchName" placeholder="양식 이름">
			<input type="button" class="btn btn-default btn-sm" value="검색" onclick="adminSelectMenu('adminMemList')">
			<br/><br/>
		</div>
	<!-- Search (E) -->
	<!-- List (S) -->
    	<div>
			<table class="table table-condensed table-hover" id="listTable">
				<tbody>
					<tr style="background-color: #F5F5F5;">
						<td class="col-lg-1"><span>NO</span></td>
						<td class="col-lg-1"><span>양식 이름</span></td>
						<td class="col-lg-1">Detail</td>
					</tr>
					
					<c:forEach var="mList" items="${list}">
						<tr>
							<td>${mList.memname}</td>
							<td>${mList.meminmail}</td>
							<td>${mList.membirth}</td>
							<td>${mList.memaddr}</td>
							<td>${mList.dename}</td>
							<td>${mList.memjob}</td>
							<td>${mList.memhire}</td>
							<td>
								<input type="button" class="btn btn-default btn-sm" value="인사고과" 
								onclick="javascript:getMemInfoForModal('prForm',${mList.memnum})">
								<input type="button" class="btn btn-default btn-sm" value="퇴사 처리" onclick="resignMem(${mList.memnum})">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- List (E) -->