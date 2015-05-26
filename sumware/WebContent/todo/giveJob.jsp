<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="/css/bootstrap-rtl.min.css" rel="stylesheet"/>
<!-- 팀장이 사원들에게 업무를 부여하기 위한 뷰 -->
<script>

	function insertJob(tonum){
		
		if($('#memjobName'+tonum).val()==""){
			alert("사원을 선택해 주세요.");
		}else{
			$.ajax({
				type : "post",
				url : "sumware",
				data : {model:"todo", 
					submod:"insertMemJob", 
					jobmemnum:$('#memjobName'+tonum).val(),
					jobtonum:tonum,
					jobcont:$('#jobcont'+tonum).val()},
				success : function(result){
					$("#membersjob"+tonum).html(result);
					
				}
			});
			alert("업무 지정이 완료되었습니다.");
		}
		
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
												<div id="membersjob${tolist.tonum}"></div>
												
					

											</div>
											<div class="panel-footer">
											<label class="control-label" for="inputSuccess">업무 지정</label>
											<select name="memjobName" class="form-control" id="memjobName${tolist.tonum}" style="width: 25%">
												<option value="">사원선택</option>
												<c:forEach var="teamMemList" items="${teamMemberList }">
												<option value="${teamMemList.memnum }">${teamMemList.memname}</option>
												</c:forEach>
											</select>
											<input type="text" id="jobcont${tolist.tonum}">
											<button type="button" onclick="javascript:insertJob(${tolist.tonum })"><i class="fa fa-plus"></i></button>
												
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
		
	<%@include file="todoSns.jsp" %>
	</div>
	</div>
<%@include file="/footer.jsp" %>