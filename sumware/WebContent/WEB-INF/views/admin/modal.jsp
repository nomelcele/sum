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

<!-- Modal (S) 사원 직급, 부서 변경 -->
		<div class="modal fade" id="prForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h3 class="modal-title" id="myModalLabel">Modal title</h3>
	      </div>
	      <div class="modal-body">
	         <div class="tabbable"> 
		        <ul class="nav nav-tabs">
		        <li class="active"><a href="#tab1" data-toggle="tab">사원 진급 처리</a></li>
		        <li><a href="#tab2" data-toggle="tab">사원 부서 이동</a></li>
		        </ul>
		        <div class="tab-content">
		        
		        	<br/>
			        <div class="tab-pane active" id="tab1"> 
			        	<div class="form-group">
			        		<label class="control-label">현재 직급</label> 
							<input type="text" id="curmemjob" class="form-control" 
							style="width: 120px" readonly="readonly" value="${memvo.memjob}">
			        	</div>
			        	<div class="form-group">
							<label class="control-label">변경할 직급</label> 
							<select name="memjob" id="newmemjob" class="form-control" style="width: 120px">
											<option value="0">직급 선택</option>								
											<option value="대표이사">대표이사</option>
											<option value="이사">이사</option>
											<option value="부장">부장</option>
											<option value="팀장">팀장</option>
											<option value="사원">사원</option>
							</select>
						</div>
			        </div>
			   
			        <div class="tab-pane" id="tab2">
			        	<div class="form-group">
			        		<label class="control-label">현재 부서</label> 
							<input type="text" id="curmemdept" class="form-control" 
							style="width: 120px" readonly="readonly" value="${memvo.dename}">
			        	</div>
			        	<div class="form-group">
							<label class="control-label">변경할 부서</label> 
							<select name="memdept" id="newmemdept" class="form-control" style="width: 120px">
											<option value="0">부서 선택</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
			        </div>
		        </div>
		        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="saveChange(${memvo.memnum})">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
							
		<!-- Modal (E) -->



