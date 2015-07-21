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