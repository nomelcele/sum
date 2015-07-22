<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table class="table table-condensed table-hover">
	<tr style="background-color: #F5F5F5; text-align: center">
		<td colspan="3"><span style="font-weight: bold">상품 정보</span></td>
	</tr>
	<tr>
		<td rowspan="5" class="col-lg-1" style="text-align: center"><img src="aucImg/${provo.proimg}" style="width: 200px;"></td>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">상품명</td>
		<td class="col-lg-2"><span>${provo.product }</span></td>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">현재가격</td>
		<td class="col-lg-2"><span>${provo.price}</span> 원</td>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">종료일자</td>
		<td class="col-lg-2"><span>${provo.enddate}</span></td>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">호가</td>
		<td class="col-lg-2"><span>${provo.prostep}</span> 원</td>
	</tr>
</table>
<table class="table table-condensed table-hover">
	<tbody>
		<tr>
			<td class="col-lg-1" style="font-weight: bold; background-color: #F5F5F5; text-align: center;">기본급</td>
			<td class="col-lg-1" style="text-align: right;">${payvo.pmonthsalary}	만원</td>
		</tr>
		<tr>
			<td class="col-lg-1"	style="font-weight: bold; background-color: #F5F5F5; text-align: center;">추가급</td>
			<td class="col-lg-1" style="text-align: right;">총 ${comSum} 만원</td>
		</tr>
			<tr class="showComDetail">
				<td class="col-lg-1" style="font-weight: bold; text-align: right;">${comvo.comdetail }</td>
				<td class="col-lg-1" style="text-align: right;">${comvo.comamount} 만원</td>
			</tr>
		<tr>
			<td class="col-lg-1"	style="font-weight: bold; background-color: #D5D5D5; text-align: center;">총	합계</td>
			<td class="col-lg-1"	style="font-weight: bold; background-color: #EAEAEA; text-align: right;">${ totalSalary }만원</td>
		</tr>
	</tbody>
</table>


<button type="button" id="bidBtn" onclick="javascript:bidBtn()">입찰하기</button>
<div id="bidTarget"></div>
