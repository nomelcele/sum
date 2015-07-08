<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="width:100%">
	<table class="table table-condensed table-hover">
		<tr style="background-color: #F5F5F5;">
			<td colspan="3"><span style="font-weight:bold">사원 정보</span></td>
		</tr>
		<tr>
			<td rowspan="4" class="col-lg-1">
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
				<td class="col-lg-1"><span>날짜</span></td>
				<td class="col-lg-1"><span>월급</span></td>
				<td class="col-lg-1"><span>추가급</span></td>
				<td class="col-lg-1"><span>합계</span></td>
				<td class="col-lg-1">
					<select class="form-control input-sm" style="width:50%; display:inline">
						<option value="2015">2015</option>
						<option value="2014">2014</option>
						<option value="2013">2013</option>
						<option value="2012">2012</option>
					</select><span>년도</span>
				</td>
			</tr>

			<tr>
				<td class="col-lg-1">날짜</td>
				<td class="col-lg-1">월급</td>
				<td class="col-lg-1">추가급</td>
				<td class="col-lg-1">합계</td>
				<td class="col-lg-1"></td>
			</tr>
		</tbody>
	</table>

</div>