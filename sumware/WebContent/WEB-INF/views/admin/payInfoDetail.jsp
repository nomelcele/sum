<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="width:100%">
	<table class="table table-condensed table-hover">
		<tr style="background-color: #F5F5F5; text-align: center">
			<td colspan="3"><span style="font-weight:bold;">사원 정보</span></td>
		</tr>
		<tr>
			<td rowspan="4" class="col-lg-1" style="text-align: center">
			<img src="resources/profileImg/${memvo.memprofile}" style="width:130px" ></td>
			<td class="col-lg-1">이름</td>
			<td class="col-lg-2">${memvo.memname}</td>
		</tr>
		<tr>
			<td class="col-lg-1">직급</td>
			<td class="col-lg-2">${memvo.memjob}</td>
		</tr>
		<tr>
			<td class="col-lg-1">호봉</td>
			<td class="col-lg-2">${payvo.pyearly}</td>
		</tr>
		<tr>
			<td class="col-lg-1">연봉</td>
			<td class="col-lg-2">${payvo.psalary}</td>
		</tr>
	</table>
	<table class="table table-condensed table-hover">
		<tbody>
			<tr style="background-color: #F5F5F5; font-weight:bold">
				<td class="col-lg-1" style="text-align: center;"><span>지급 년월</span></td>
				<td class="col-lg-1" style="text-align: center;"><span>수령 금액</span></td>

				<td class="col-lg-1">
					<select class="form-control input-sm" id="hisdate" onchange="javascript:changemonth(${memvo.memnum})" style="width:50%; display:inline">
						<option value="">년도선택</option>
						<option value="">전 체</option>
						<c:forEach var="month" items="${monthList }">
						<option value="${month.hisdate }">${month.hisdate }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<c:forEach var="phvo" items="${phvoList }">
				<tr>
				<td class="col-lg-1" style="text-align: center;">${phvo.hisdate}</td>
				<td class="col-lg-1" style="text-align: center;">${phvo.hisamount} 만원</td>
				<td class="col-lg-1"><input type="button" class="btn btn-default btn-sm"  onclick="javascript:getPaymentDetail(${memvo.memnum},'${phvo.hisdate}')" value="상세보기"></td>
				</tr>
			</c:forEach>
			
		</tbody>
	</table>
<div id="modalTarget"></div>
</div>