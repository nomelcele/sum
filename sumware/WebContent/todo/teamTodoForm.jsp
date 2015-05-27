<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 팀 업무 부분 뷰 -->

<script>

function getJobDetail(tonum){
	$("#memlisttarget"+tonum).toggle("slow");
	$("#detail"+tonum).toggle("slow");
	$.ajax({
		type : "post",
		url : "sumware",
		data : {model:"todo", 
			submod:"showmemlist", 
			jobtonum:tonum,
			},
		success : function(result){
			$("#memlisttarget"+tonum).html(result);
		
		}
	});
}

function successJob(){
	
	$('#tonum'+tonum).attr("value", tonum);
	$('#successjob').submit();
	
	alert("업무 완료 처리 하였습니다.");
	
}



</script>
<div class="container">
<div class="row">
<%@include file="/top.jsp"%>
</div>
<div class="row">
	<div class="wrap">
		<%@include file="/contentLeft.jsp" %>
		<!-- 팀업무 부분!! -->
		<div class="col-lg-4" style="width: 35%">
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-pencil-square-o"></i> <strong class="primary-font">팀 업무</strong>
				</div>
				<div class="panel-body">
					<div class="column" style="overflow: auto">
					<c:forEach var="teamjoblist" items="${teamJobList }">
						
						
						<div class="low-lg-12">
							<div class="panel panel-success">
								<div class="panel-heading">
								<i class="fa fa-pencil"></i>
								${teamjoblist.totitle }
								</div>
								<div class="panel-body">
									<p><i class="fa fa-user"></i> manager : ${teamjoblist.memname }
									<p><i class="fa fa-calendar-o"></i> date : ${teamjoblist.tostdate } ~
													${teamjoblist.toendate }</p>
		
									
								</div>
								<div class="panel-footer">
									
									<a class="fa fa-align-justify" 
									onclick="javascript:getJobDetail(${teamjoblist.tonum })"
									style="cursor:pointer"> detail</a>
									<div id="memlisttarget${teamjoblist.tonum }" style="display:none"></div>
									<div id="detail${teamjoblist.tonum }" style="display:none">
										<br/>
										<p>${teamjoblist.tocont }</p>
										<p><a href="upload/${teamjoblist.tofile }" target="_blank">첨부파일 : ${teamjoblist.tofile }</a></p>
										
										<p>
										<c:if test="${sessionScope.v.memnum eq  teamjoblist.tomem}">
										<button type="button"  class="btn btn-info-xs" 
										data-toggle="modal" data-target="#successModal">업무 완료</button>
										<%@include file="okTodoModal.jsp" %>
										</c:if>
										</p>
										
										
										
										
										
										
										
										
										
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
		<!-- 팀업무 부분 끝!!! -->
		<%@include file="todoSns.jsp" %>
	</div>
</div>
<div class="row">
<%@include file="/footer.jsp" %>
</div>
</div>