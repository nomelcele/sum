<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 부서 업무 부분 뷰 -->

<script>
$(function(){
	$.ajax({
		type : "post",
		url : "sumware",
		data : {model:"todo", 
			submod:"showmemlist", 
			tonum:$('#memjobName'+tonum).val(),
			},
		success : function(result){
			$("#membersjob"+tonum).html(result);
				
		}

		
		
	});
});

</script>


<div class="row">
	

	<div class="wrap" style="margin-top: 50px;">
		<%@include file="/contentLeft.jsp" %>
		<!-- 부서업무 부분!! -->
		<div class="col-lg-2" style="width: 35%">
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">부서업무</strong>
				</div>
				<div class="panel-body">
					<div class="column" style="overflow: auto">
					<c:forEach var="deptjoblist" items="${deptJobList }">
						
						
						<div class="low-lg-${deptjoblist.tonum }">
							<div class="panel panel-success">
								<div class="panel-heading">
								<i class="fa fa-pencil"></i>
								${deptjoblist.totitle }
								</div>
								<div class="panel-body">
									<p><i class="fa fa-user"></i>manager : ${deptjoblist.tomem }
									<p><i class="fa fa-calendar-o"></i> ${deptjoblist.tostdate } ~
													${deptjoblist.toendate }</p>
									<p>${deptjoblist.tocont }</p>
									
								</div>
								<div class="panel-footer">
									<i class="fa fa-angle-double-down"></i>
									<div id="memlisttarget">
									</div>
								</div>
								
							</div>
						</div>
					
					
					</c:forEach>
						
						
						<!-- /.col-lg-4 -->
					</div>
				</div>
			</div>
		</div>
		<!-- 부서업무 부분 끝!!! -->
		<%@include file="todoSns.jsp" %>
	</div>
	</div>

