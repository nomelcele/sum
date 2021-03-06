<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상품등록 Modal(S) -->
<div id="proRegister" class="modal fade" role="dialog">
	<form action="sadone" method="post" id="doneForm" enctype="multipart/form-data">
	<input type="hidden"  name="prowriter" value="${sessionScope.v.memnum }">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">상품등록</h4>
			</div>
			<div class="modal-body auction">
			
				<!-- auction-table(S) -->
				<table class="auction-table">
					<tbody>
						<tr class="pro-name">
							<th>상품명</th>
							<td><input type="text" name="product"/></td>
						</tr>
						<tr>
							<th>판매자</th>
							<td><label>${sessionScope.v.memname }</label></td>
						</tr>
						<!-- 가격(S) -->
						<tr class="auc-price">
							<th>가격</th>
							<td><input type="number" placeholder="10,000" id="startprice" step="100" min="0" name="startprice"/> 원</td>
						</tr>
						<!-- 가격(E) -->
						<tr class="auc-price">
							<th>입찰단가</th>
							<td><input id="prostep" type="number" step="100" min="100" name="prostep" placeholder="100"> 원</td>
						</tr>
						<tr class="auc-price">
							<th>즉시구매가격</th>
							<td><input type="number" placeholder="10,000" id="auc-price" step="100" min="0" name="nowget" id="nowget"/> 원</td>
						</tr>
						<!-- 경매기간(S) -->
						<tr class="auc-date">
							<th>종료일자</th>
							<td>
								<select name="enddate">
									<option value="1">1일 후</option>
									<option value="2">2일 후</option>
									<option value="3">3일 후</option>
									<option value="7">1주일일 후</option>
									<option value="30">30일 후</option>
								</select>
							</td>
						</tr>
						<!-- 경매기간(E) -->
						
						<!-- 상품 이미지(S) -->
						<tr class="auc-pro-img">
							<th>상품<br />상세 이미지</th>
							<td>
								<input type="file" onchange="preview(this)" name="proimg" >
								<span id="imgTarget"></span>
							</td>
						</tr>
						<!-- 상품 이미지(E) -->
						
						<!-- 상품설명 (S) -->
						<tr class="auc-info">
							<th>상품 설명</th>
							<td><textarea placeholder="상품에 대한 설명을 기입 해 주세요." rows="10" cols="10" name="procont"></textarea></td>
						</tr>
						<!-- 상품설명 (E) -->
					</tbody>
				</table>
				<!-- auction-table(E) -->
			</div>
			<div class="modal-footer align-center">
				<button type="button" id="doneBtn" class="btn btn-default" onclick="doneClick()">Done</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			</div>
		</div>
	</div>
	</form>
</div>
<!-- 상품등록 Modal(E) -->

<!-- 상품입찰 Modal(S) -->
<div id="bidModal" class="modal fade" role="dialog">
<form id="bidForm" action="bidInsert" method="post">
<input type="hidden" name="bidpronum" value="${provo.pronum }">
<input type="hidden" name="bidmem"	 value="${sessionScope.v.memnum }">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">상품정보</h4>
			</div>
			<div class="modal-body auction">
			<!-- 입찰 할 상품에 대한 정보테이블(S) -->				
				<div>
<!-- 				<h6>* 입찰 상품</h6> -->
<!-- <i class="fa fa-gift"></i> -->
				<label class="control-label" for="inputSuccess"> 입찰 상품 <i class="fa fa-gift"></i></label>
					<table class="table table-condensed table-hover">
						<tr style="background-color: #F5F5F5; text-align: center">
							<td class="col-lg-1" style="background-color: #F5F5F5; font-weight: bold">상품명</td>
							<td class="col-lg-1">${provo.product }</td>
						</tr>
						<tr>
							<td style="background-color: #F5F5F5; font-weight: bold">종료일</td>
							<td>${provo.enddate }</td>
						</tr>
					</table>
				</div>
			<!-- 입찰 할 상품에 대한 정보테이블(E) -->				
			
			<!-- 상품에 대한 입찰 정보(S) -->
				<div>
<!-- 				<h6>* 입찰 하기</h6> -->
<!-- <i class="fa fa-money"></i> -->
				<label class="control-label" for="inputSuccess"> 입찰 하기</label>
					<table class="table table-condensed table-hover">
						<tr>
							<td class="col-lg-1"  style="background-color: #F5F5F5; font-weight: bold">현재가격</td>
							<td class="col-lg-1"  style="text-align: right; padding-right: 100px"><i class="fa fa-krw"></i> ${price}</td>
						</tr>
						<tr>
							<td class="col-lg-1"  style="background-color: #F5F5F5; font-weight: bold">즉시구매가격</td>
							<td class="col-lg-1"  style="text-align: right; padding-right: 100px"><i class="fa fa-krw"></i> ${provo.nowget}</td>
						</tr>
						<tr>
							<td style="background-color: #F5F5F5; font-weight: bold">호 가</td>
							<td style="text-align: right; padding-right: 100px"><i class="fa fa-krw" ></i> ${provo.prostep}</td>
						</tr>
						<tr>
							<td style="background-color: #F5F5F5; font-weight: bold">입찰금액</td>
							<td><input type="number" id="bidprice" name="bidprice" min="${price}"  onchange="javascript:parseIntMethod('${provo.prostep }')"></td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 상품에 대한 입찰 정보(E) -->
			
			<div class="modal-footer align-center">
			<button type="button" class="btn btn-default" onclick="nowgetBtn('${provo.nowget}')">즉시구매</button>
				<button type="button" id="doneBtn" class="btn btn-default" onclick="javascript:bidExe('${provo.prostep }',${price},'${provo.nowget}')">입찰</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</form>
</div>
<!-- 상품입찰 Modal(E) -->

<!-- 입찰정보 Modal(S) -->
<div id="bidInfoModal" class="modal fade" role="dialog">
<form id="bidForm" action="bidInsert" method="post">
<input type="hidden" name="bidpronum" value="${provo.pronum }">
<input type="hidden" name="bidmem"	 value="${sessionScope.v.memnum }">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">입찰정보</h4>
			</div>
			<!-- 입찰 정보 Table -->
			<div class="modal-body auction">
				<table class="table table-condensed table-hover">
					<tbody>
					<c:forEach var="bid" items="${bidderList }">
						<tr>
							<td class="col-lg-1" style="text-align: center;"><i class="fa fa-user"></i> ${bid.bidmemname }</td>
							<td class="col-lg-1" style="text-align: right;"><i class="fa fa-krw" ></i> ${bid.bidprice }</td>
							<td class="col-lg-1" style="text-align: right;"><i class="fa fa-clock-o"></i> ${bid.biddate }</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer align-center">
				<button type="button" class="btn btn-default" data-dismiss="modal">목록</button>
			</div>
		</div>
	</div>
</form>
</div>
<!-- 입찰정보 Modal(E) -->







