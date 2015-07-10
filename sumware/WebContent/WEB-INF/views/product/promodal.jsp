<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<form action="done" method="post" id="doneForm" enctype="multipart/form-data">
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
							<td><input type="number" placeholder="10,000" id="auc-price" step="1000" min="0" name="price"/> 원</td>
						</tr>
						<!-- 가격(E) -->
						
						
						<!-- 경매기간(S) -->
						<tr class="auc-date">
							<th>경매기간</th>
							<td>시작일자 : <input type="date" name="startdate"/>&nbsp;  종료일자 : <input type="date" name="enddate"/></td>
						</tr>
						<!-- 경매기간(E) -->
						
						<!-- 상품 이미지(S) -->
						<tr class="auc-pro-img">
							<th>상품<br />상세 이미지</th>
							<td>
								<input type="file" onchange="preview(this)" name="proimg">
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