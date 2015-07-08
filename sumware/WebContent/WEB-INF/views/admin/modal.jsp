<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal(S) 추가급여지급-->
<div class="modal fade" id="giveBonus" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">추가 급여 지급</h4>
			</div>
			<div class="modal-body">
				<table class="table table-condensed table-hover">
					<tr style="background-color: #F5F5F5;">
						<td colspan="3"><span style="font-weight: bold">사원 정보</span></td>
					</tr>
					<tr>
						<td rowspan="4" class="col-lg-1" style="text-align:center"><img
							src="resources/profileImg/${memvo.memprofile}"
							style="width: 130px"></td>
						<td class="col-lg-1" style="font-weight: bold">이름</td>
						<td class="col-lg-2">${memvo.memname}</td>
					</tr>
					<tr>
						<td class="col-lg-1" style="font-weight: bold">직급</td>
						<td class="col-lg-2">${memvo.memjob}</td>
					</tr>
					<tr>
						<td class="col-lg-1" style="font-weight: bold">호봉</td>
						<td class="col-lg-2">${payvo.pyearly}</td>
					</tr>
					<tr>
						<td class="col-lg-1" style="font-weight: bold">연봉</td>
						<td class="col-lg-2">${payvo.psalary}</td>
					</tr>
				</table>
				<table class="table table-condensed table-hover">
					<tbody>
						<tr>
							<td class="col-lg-1" style="font-weight: bold">지급 내용</td>
							<td class="col-lg-1"><input type="text" id="comdetail" placeholder="지급 내용"></td>
						</tr>
						<tr>
							<td class="col-lg-1" style="font-weight: bold">지급 금액</td>
							<td class="col-lg-1"><input type="text" id="comamount" placeholder="지급 금액">원</td>
						</tr>
					</tbody>
				</table>

			</div>

			<div class="modal-footer">
				<button type="submit" class="btn btn-default" data-dismiss="modal"
					onclick="javascript:payManage('giveBonus')">저장</button>
			</div>
		</div>

	</div>
</div>
<!-- Modal(E) -->


