<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	function hateWorking(tonum){
		console.log("거절했다~!!!!");
	 	$(".title"+tonum).toggle("slow");
	}
	
	function tosend(tonumval){
		$.ajax({
			type : "post",
			url : "sumware",
			data : {
				model:"todo", 
				submod:"toUpFk", 
				memnum:"${sessionScope.v.memnum }",
				tomem:$('#inputSuccess'+tonumval).val(),
				toconfirm:"n",
				tonum:tonumval,
				tocomm:$('#tocomm'+tonumval).val()
				},
			success : function(result){
				$("#menuTarget").html(result);
			}
		});
		
		alert("업무를 전송하였습니다.");
		}
	
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
</script>

</head>
<!-- 부장의 업무관리 ajax -->
<div class="chat-panel panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-pencil-square-o"></i> <strong class="primary-font">업무관리</strong>
	</div>
	<div class="panel-body" style="height: 510px; overflow-y: scroll;">
		<div class="column">

			<c:forEach var="fw" items="${fwList }">
				<div class="low-lg-${fw.torownum }">
					<div class="panel panel-success">
						<div class="panel-heading">${fw.totitle }
						<c:if test="${fw.toconfirm  eq 'z' }">
						&nbsp<i class="fa fa-exclamation" style="color:#FF9436"></i>
						</c:if>
						
						</div>
						<div class="panel-body">
							<p>
								<i class="fa fa-calendar-o"></i>${fw.tostdate } ~ ${fw.toendate }
							</p>
							<p>${fw.tocont }</p>
						</div>
						<div class="panel-footer">
							<a class="fa fa-align-justify"
								onclick="javascript:getJobDetail(${fw.tonum })"
								style="cursor: pointer"> detail</a>
							<div id="detail${fw.tonum }" style="display: none">
								<br />
								<p>${fw.tocont }</p>
								<table class="table table-striped table-bordered table-hover"
									style="margin: auto; width: 90%; padding-left: 15px; padding-right: 15px;">
									<thead>
										<tr style="margin:auto">
											<td style="text-align:center">승인 상태</td>
											<td style="text-align:center"><c:choose>
													<c:when test="${fw.toconfirm  eq 'n' }">
														<button type="button"
															class="btn btn-outline btn-warning btn-xs">미승인</button>
													</c:when>
													<c:when test="${fw.toconfirm eq 'y' }">
														<button type="button"
															class="btn btn-outline btn-success btn-xs">승인</button>
													</c:when>
													<c:otherwise>
														<button type="button"
															class="btn btn-outline btn-danger btn-xs"
															onclick="hateWorking(${fw.tonum })">거절</button>
													</c:otherwise>
												</c:choose></td>
										</tr>
									</thead>
									<tbody>

										<tr class="title${fw.tonum }" style="display: none;">
											<td colspan="2"><i class="fa fa-thumb-tack"></i>${fw.tocomm }</td>
										</tr>
										<tr class="title${fw.tonum }" style="display: none;">
											<td colspan="2">
											<select class="form-control" id="inputSuccess${fw.tonum }" style="width: 70%">
													<option value="">팀장 선택</option>
													<c:forEach var="tNameList" items="${sessionScope.teamNameList}">
														<option value="${tNameList.memnum }">${tNameList.memname}</option>
													</c:forEach>
											</select></td>
										</tr>
										<tr class="title${fw.tonum }" style="display: none;">

											<td colspan="2">
													<textarea name="tocomm" id="tocomm${fw.tonum }" style="width: 250px; resize: none">
													</textarea>
											</td>

										</tr>

										<tr class="title${fw.tonum }" style="display: none;">
											<td colspan="2">
												<button type="button" class="btn btn-outline btn-success"
													onclick="tosend(${fw.tonum })">전달</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
