<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 팀 업무 부분 뷰 ajax-->

<script>

function getJobDetail(tonum){
	$("#memlisttarget"+tonum).toggle("slow");
	$("#detail"+tonum).toggle("slow");
	$.ajax({
		type : "post",
		url : "/showmemlist",
		data : {
// 			model:"todo", 
// 			submod:"showmemlist", 
			jobtonum:tonum,
			},
		success : function(result){
			$("#memlisttarget"+tonum).html(result);
		
		}
	});
}

// function successJob(){
	
// 	$('#tonum'+tonum).attr("value", tonum);
// 	$('#successjob').submit();
	
// 	alert("업무 완료 처리 하였습니다.");
	
// }



</script>

<!-- 팀업무 부분!! -->

<div class="chat-panel panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-pencil-square-o"></i> <strong class="primary-font">팀
			업무</strong>
	</div>
	<div class="panel-body"   style="height:510px; overflow-y:scroll;">
		<div class="column">
			<c:forEach var="teamjoblist" items="${teamJobList }">

				<div class="low-lg-12">
					<div class="panel panel-success">
						<div class="panel-heading">
							<i class="fa fa-pencil"></i> ${teamjoblist.totitle }
						</div>
						<div class="panel-body">
							<p>
								<i class="fa fa-user"></i> manager : ${teamjoblist.memname }
							<p>
								<i class="fa fa-calendar-o"></i> date : ${teamjoblist.tostdate }
								~ ${teamjoblist.toendate }
							</p>
						</div>
						<div class="panel-footer">

							<a class="fa fa-align-justify"
								onclick="javascript:getJobDetail(${teamjoblist.tonum })"
								style="cursor: pointer"> detail</a>
							<div id="memlisttarget${teamjoblist.tonum }"
								style="display: none"></div>
							<div id="detail${teamjoblist.tonum }" style="display: none">
								<br />
								<p>${teamjoblist.tocont }</p>
								<p>
									<a href="upload/${teamjoblist.tofile }" target="_blank">
									<i class="fa fa-paperclip"></i> 첨부파일
										: ${teamjoblist.tofile }</a>
								</p>

								<p>
									<c:if test="${sessionScope.v.memnum eq  teamjoblist.tomem}">
										<button type="button" class="btn btn-info-xs"
											data-toggle="modal" data-target="#successModal">업무
											완료</button>
										<%@include file="../modal/okTodoModal.jsp"%>
									</c:if>
								</p>

							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<!-- 팀업무 부분 끝!!! -->
