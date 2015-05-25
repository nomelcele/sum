<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 팀장이 사원들에게 업무를 부여하기 위한 뷰 -->
<script>
	var job = "";
	function makeJobStr(memnum , memjob){
		console.log("memnum:"+memnum);
		console.log("memjob:"+memjob);
		console.log("memjob val:"+$("#"+memjob).val());
		
		job += memnum+'<<'+$("#"+memjob).val()+'>>';
		console.log(job);
	}
	
	function insertJob(){

		
		console.log("1:"+$('#jobcont').val());
		console.log("2:"+$('#inputSuccess').val());
		
		job = $('#job').html();
		console.log("jobstr1:"+job);
		job +=	$('#inputSuccess').val()+':'+ $('#jobcont').val()+'<br/>';
		console.log("jobstr2:"+job);
		
		$('#job').html(job);
	}
</script>
<%@include file="/top.jsp"%>



<div class="row">
	
	<div class="wrap">
		<%@include file="/contentLeft.jsp" %>
		<!-- 팀장 업무관리 -->
			<div class="col-lg-2" style="width: 35%">
				<div class="chat-panel panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">부서업무</strong>
					</div>
					<div class="panel-body">
						<div class="column" style="overflow: auto">
							<div class="column" style="overflow: auto">

								<c:forEach var="tolist" items="${teamTodoList }">
									<div class="low-lg-${tolist.tonum }">
										<div class="panel panel-success">
											<div class="panel-heading">
												<i class="fa fa-pencil"></i> ${tolist.totitle }
											</div>
											<div class="panel-body">
												<p>
													<i class="fa fa-calendar-o"></i> ${tolist.tostdate } ~
													${tolist.toendate }
												</p>
												<p>${tolist.tocont }</p>
												<label class="control-label" for="inputSuccess">사원별 업무</label>
												<div id="job"></div>
												<div>
												<label class="control-label" for="inputSuccess">업무 지정</label>
												
													<select name="tomem" class="form-control" id="inputSuccess"
														style="width: 20%">
														<option value="">사원 선택</option>
														<c:forEach var="teamMemList" items="${teamMemberList }">
														<option value="${teamMemList.memnum }">${teamMemList.memname}</option>
														
														</c:forEach>
													</select>
													<input type="text" id="jobcont">
														<button type="button" onclick="javascript:insertJob()"><i class="fa fa-check"></i></button>
												
												</div>
												
												

												

											</div>
											<div class="panel-footer">
												<button type="button" class="btn btn-outline btn-success"
													onclick="javascript:todoFormGo(9)">업무 지정</button>
												
											</div>
										</div>
									</div>
								</c:forEach>
							</div>

						</div>
					</div>
				</div>
			</div>
		<!-- 팀장 업무관리 끝!!! -->
		
	<%@include file="snsTodo.jsp" %>
	</div>
	</div>
<%@include file="/footer.jsp" %>