<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<tr style="background-color: #F5F5F5; text-align: center">
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
							<td class="col-lg-1"><input type="text" id="comamount" placeholder="지급 금액">만원</td>
						</tr>
					</tbody>
				</table>

			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-default" 
					onclick="javascript:payManage('giveBonus',${memvo.memnum})">저장</button>
			</div>
		</div>

	</div>
</div>
<!-- Modal(E) -->

<!-- Modal(S) 월급여 지급-->
<div class="modal fade" id="giveSalary" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">월 급여 지급</h4>
			</div>
			<div class="modal-body">
				<table class="table table-condensed table-hover">
					<tr style="background-color: #F5F5F5; text-align: center">
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
						<td class="col-lg-2" >${payvo.psalary}</td>
					</tr>
				</table>
				<table class="table table-condensed table-hover">
					<tbody>
						<tr>
							<td class="col-lg-1" style="font-weight: bold; background-color: #F5F5F5; text-align: center;">기본 급</td>
							<td class="col-lg-1" style="text-align: right;">${payvo.pmonthsalary} 만원</td>
						</tr>
						<tr>
							<td class="col-lg-1" style="font-weight: bold; background-color: #F5F5F5; text-align: center;">추가 급</td>
							<td class="col-lg-1" style="text-align: right;">총 ${comSum} 만원</td>
						</tr>
						<c:forEach var="comvo" items="${comList }">
							<tr class="showComDetail">
								<td class="col-lg-1" style="font-weight: bold; text-align: right;">${comvo.comdetail }</td>
								<td class="col-lg-1" style="text-align: right;">${comvo.comamount} 만원</td>
							</tr>
						</c:forEach>
						
						
						
						<tr>
							<td class="col-lg-1" style="font-weight: bold; background-color: #D5D5D5; text-align: center;">총 합계</td>
							<td class="col-lg-1" style="font-weight: bold; background-color: #EAEAEA; text-align: right;">${ totalSalary } 만원</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" id="hisamount" value="${ totalSalary }">

			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-default"
					onclick="javascript:payManage('giveSalary',${memvo.memnum})">지급</button>
			</div>
		</div>

	</div>
</div>
<!-- Modal(E) -->


<!-- Modal(S) 지급된 월급여 디테일!!!-->
<div class="modal fade" id="paymentDetail" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">월 급여 세부 사항</h4>
			</div>
			<div class="modal-body">
				<table class="table table-condensed table-hover">
					<tbody>
						<tr>
							<td class="col-lg-1" style="font-weight: bold; background-color: #F5F5F5; text-align: center;">기본 급</td>
							<td class="col-lg-1" style="text-align: right;">${payvo.pmonthsalary} 만원</td>
						</tr>
						<tr>
							<td class="col-lg-1" style="font-weight: bold; background-color: #F5F5F5; text-align: center;">추가 급</td>
							<td class="col-lg-1" style="text-align: right;">총 ${comSum} 만원</td>
						</tr>
						<c:forEach var="comvo" items="${comList }">
							<tr class="showComDetail">
								<td class="col-lg-1" style="font-weight: bold; text-align: right;">${comvo.comdetail }</td>
								<td class="col-lg-1" style="text-align: right;">${comvo.comamount} 만원</td>
							</tr>
						</c:forEach>
						<tr>
							<td class="col-lg-1" style="font-weight: bold; background-color: #D5D5D5; text-align: center;">총 합계</td>
							<td class="col-lg-1" style="font-weight: bold; background-color: #EAEAEA; text-align: right;">${ totalSalary } 만원</td>
						</tr>
					</tbody>
				</table>

			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
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
	        <h3 class="modal-title" id="myModalLabel">인사고과</h3>
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
							style="width: 125px" readonly="readonly" value="${memvo.memjob}">
			        	</div>
			        	<div class="form-group">
			        		<label class="control-label">현재 연봉(만원)</label> 
							<input type="text" id="curpsalary" class="form-control" 
							style="width: 125px" readonly="readonly" value="${memvo.psalary}">
			        	</div>
			        	<div class="form-group">
							<label class="control-label">변경할 직급</label> 
							<select name="memjob" id="newmemjob" class="form-control" style="width: 125px" 
							onchange="getNewMgrList('job',${memvo.memdept},${memvo.memnum},${memvo.memauth})">
											<option value="0">직급 선택</option>								
											<option value="1">대표이사</option>
											<option value="2">이사</option>
											<option value="3">부장</option>
											<option value="4">팀장</option>
											<option value="5">사원</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">변경할 연봉(만원)</label> 
							<input type="number" id="newpsalary" class="form-control" 
							style="width: 125px" step="100" value="${memvo.psalary}">
						</div>
						<div class="form-group">
							<label class="control-label">변경할 상급자</label> 
							<select name="newjobmgr" id="newjobmgr" class="form-control" style="width: 125px">
											<option value="0">상급자 선택</option>		
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">현재 하급자</label> 
							<select name="jobjuniors" id="jobjuniors" multiple="multiple" class="form-control" style="width: 125px">
								<c:forEach var="list" items="${jList}">
									<option value="${list.memnum}">${list.memname}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">상급자 지정</label> 
							<select name="jobjuniorsmgr" id="jobjuniorsmgr" class="form-control" style="width: 125px">
								<option value="0">상급자 선택</option>	
								<c:forEach var="list" items="${jMgrList}">
									<option value="${list.memnum}">${list.memname}</option>
								</c:forEach>	
							</select>
						</div>
			        </div>
			   
			        <div class="tab-pane" id="tab2">
			        	<div class="form-group">
			        		<label class="control-label">현재 부서</label> 
							<input type="text" id="curmemdept" class="form-control" 
							style="width: 125px" readonly="readonly" value="${memvo.dename}">
			        	</div>
			        	<div class="form-group">
							<label class="control-label">변경할 부서</label> 
							<select name="memdept" id="newmemdept" class="form-control" style="width: 125px"
							onchange="getNewMgrList('dept',${memvo.memdept},${memvo.memnum},${memvo.memauth})">
											<option value="0">부서 선택</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">변경할 상급자</label> 
							<select name="newdeptmgr" id="newdeptmgr" class="form-control" style="width: 125px">
											<option value="0">상급자 선택</option>		
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">현재 하급자</label> 
							<select name="deptjuniors" id="deptjuniors" multiple="multiple" class="form-control" style="width: 125px">
								<c:forEach var="list" items="${jList}">
									<option value="${list.memnum}">${list.memname}</option>
								</c:forEach>	
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">상급자 지정</label> 
							<select name="deptjuniorsmgr" id="deptjuniorsmgr" class="form-control" style="width: 125px">
								<option value="0">상급자 선택</option>	
								<c:forEach var="list" items="${jMgrList}">
									<option value="${list.memnum}">${list.memname}</option>
								</c:forEach>
							</select>
						</div>
			        </div>
		        </div>
		        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" onclick="prFormSaveChange(${memvo.memnum},${memvo.memdept},${memvo.memauth})">변경</button>
	      </div>
	    </div>
	  </div>
	</div>
							
		<!-- Modal (E) -->

