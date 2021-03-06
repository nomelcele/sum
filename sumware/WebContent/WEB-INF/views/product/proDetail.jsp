<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table class="table table-condensed table-hover">
	<tr style="background-color: #F5F5F5; text-align: center">
		<td colspan="3"><span style="font-weight: bold">상품 정보</span></td>
	</tr>
	<c:if test="${provo.status eq 'y'  }">
		<tr>
			<td colspan="3" style="text-align: center;"><h3 style="color: orange;">판매가 종료 된 상품입니다.</h3></td>
		</tr>
	</c:if>
	<tr>
		<td rowspan="7" class="col-lg-1" style="text-align: center"><img src="aucImg/${provo.proimg}" style="width: 200px;"></td>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">상품명</td>
		<td class="col-lg-2"><span>${provo.product }</span></td>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">즉시구매가격</td>
		<c:choose>
			<c:when test="${provo.nowget eq '0'}">
				<td class="col-lg-2">없음</td>
			</c:when>
			<c:otherwise>
				<td class="col-lg-2"><span>${provo.nowget}</span> 원</td>
			</c:otherwise>
		</c:choose>
	</tr>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">현재가격</td>
		<td class="col-lg-2"><span>${provo.price}</span> 원</td>
	</tr>
<c:choose>
	<c:when test="${provo.status eq 'y'  }">
		<tr>
			<td class="col-lg-1" style="font-weight: bold">낙찰자</td>
			<td class="col-lg-2"><span>${provo.lastbidder }</span><span style="float: right;"><button type="button" class="btn btn-default" onclick="bidInformation(${provo.pronum})">입찰정보</button></span></td>
		</tr>
	</c:when>
	<c:otherwise>
		<tr>
			<td class="col-lg-1" style="font-weight: bold">종료일자</td>
			<td class="col-lg-2"><span>${provo.enddate}</span><span style="float: right;"><button type="button" class="btn btn-default" onclick="bidInformation(${provo.pronum})">입찰정보</button></span></td>
		</tr>
	</c:otherwise>
</c:choose>
	<tr>
		<td class="col-lg-1" style="font-weight: bold">호가</td>
		<td class="col-lg-2"><span>${provo.prostep}</span> 원</td>
	</tr>
	<tr class="btn-position-right">
		<td colspan="3">
		<c:if test="${provo.status eq 'n' and provo.prowriter ne sessionScope.v.memnum}">
		<button type="button"  class="btn btn-default" id="bidBtn" onclick="javascript:bidBtn()">입찰하기</button>
		</c:if>
		<button type="button" class="btn btn-default" onclick="location='saproductList?page=${sesPage}'" id="bidListBtn">목록</button></td>
	</tr>
</table>
<table class="table table-condensed table-hover">
	<tbody>
	</tbody>
</table>
<div id="bidTarget"></div>
