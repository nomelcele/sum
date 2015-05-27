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
	function tosend(tonum){
		console.log("전달했네~~~");
		var v = $('#inputSuccess'+tonum).val();
		console.log("하하하하 v :::",v);
		$('#tomem'+tonum).attr("value",v);
		console.log("후후후후 ㅍ::::",$('#tomem').val());
		$('#goFk'+tonum).submit();
	}
	
	
	// 페이지 테스트
	var rowsPerPage =7;
	var eventSource;
	var cheight=$('.chat').height();
	function push(){
		if(typeof(EventSource) != "undefined"){
			eventSource = new EventSource("sumware?model=sns&submod=pushSns&sdept=${v.memdept}&page=1&rowsPerPage="+rowsPerPage); // push를 받을수 있는 브라우져인지 판단.
			// EventSource EventListener의 종류
			// onmessage : 서버가 보낸 push메세지가 수신되면 발생
			// onerror : 서버가 보낸 push에서 에러가 발생되었을때
			// onopen : 서버가 연결이 되었을 때 발생
			eventSource.onmessage = function(event){
				$(".chat").html(event.data);
				
			};
// 			eventSource.close();
		}else{
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
	}
	function pageScollforcenter(){
	
		if ($('.column').scrollTop() > cheight) {
			$("#loading").html("<img src='img/loading.gif' alt='loading'>");
			setTimeout(function(){
				rowsPerPage+=5;
				cheight+=$('.chat').scrollTop();
				console.log("rowsPerPage:"+rowsPerPage);
				console.log("cheight:"+cheight);
				eventSource.close();
				$("#loading img").remove();
				push();
				
			}, 1000);	
					
		}else if($('.column').scrollTop()==0){
			$("#loading").html("<img src='img/loading.gif' alt='loading'>");
			setTimeout(function(){
				rowsPerPage=7;
				cheight=350;
				console.log("rowsPerPage:"+rowsPerPage);
				console.log("cheight:"+cheight);
				eventSource.close();
				$("#loading img").remove();
				push();
				
			}, 1000);
		}
	}
	
	
</script>
</head>
<div class="container">
<div class="row">
<%@include file="/top.jsp"%>
</div>
<div class="row">
	

	<div class="wrap">
		<%@include file="/contentLeft.jsp" %>

			<div class="col-lg-4" style="width: 35%">
				<div class="chat-panel panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">부서업무</strong>
					</div>
					<div class="panel-body">
					<div class="column" style="height:450px; overflow-y:scroll;" onscroll="pageScollforcenter()">
					
					
						<c:forEach var="fw" items="${fwList }">
						<div class="low-lg-${fw.torownum }">
							<div class="panel panel-success">
								<div class="panel-heading">${fw.totitle }</div>
								<div class="panel-body">
									<p>${fw.tostdate } ~ ${fw.toendate }</p>
									<p>${fw.tocont }</p>
								</div>
								<div class="panel-footer">
								<table class="table table-striped table-bordered table-hover" 
							style="margin: auto; width: 90%; padding-left:15px; padding-right:15px;">
								<thead>
									<tr>
										<th colspan="1">승인 상태</th>
									</tr>
								</thead>
								<tbody>
									<tr style="border: 1px solid">
										<td>
										<c:choose>
											<c:when test="${fw.toconfirm  eq 'n' }">
												<button type="button" class="btn btn-outline btn-warning">미승인</button>
											</c:when>
											<c:when test="${fw.toconfirm eq 'y' }">
												<button type="button" class="btn btn-outline btn-success">승인</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-outline btn-danger"
												onclick="hateWorking(${fw.tonum })">거절</button>
											</c:otherwise>
										</c:choose>
										</td>
									</tr>
									<tr class="title${fw.tonum }" style="display: none;">
										<td>${fw.tocomm }</td>
									</tr>
									<tr class="title${fw.tonum }" style="display: none;">
										<td>
											<select name="tomem" class="form-control" id="inputSuccess${fw.tonum }"
											style="width: 70%">
												<option value="">팀장 선택</option>
												<c:forEach var="tNameList" items="${sessionScope.teamNameList}">
												<option value="${tNameList.memnum }">${tNameList.memname}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									
									
									<tr class="title${fw.tonum }" style="display: none;">
										
										<td>
										<form action="sumware" method="post" id="goFk${fw.tonum }">
											<input type="hidden" name="model" value="todo"> 
											<input type="hidden" name="submod" value="toUpFk"> 
											<input type="hidden" name="memnum" value="${sessionScope.v.memnum }"> 
											<input type="hidden" id="tomem${fw.tonum }" name="tomem"> 
											<input type="hidden" name="toconfirm" value="n"> 
											<input type="hidden" name="tonum" value="${fw.tonum}">
											<textarea name="tocomm" style="width: 250px; resize:none" ></textarea>
										</form>
										</td>
										
									</tr>
									
									<tr class="title${fw.tonum }" style="display: none;">
										<td>
											<button type="button" class="btn btn-outline btn-success"
											onclick="tosend(${fw.tonum })">전달</button>
										</td>
									</tr>
								</tbody>
							</table>
								</div>
							</div>
						</div>
						</c:forEach>
						<!-- /.col-lg-4 -->
		
						</div>
						<div id="loading" style="width: 100%; float:left; text-align: center;">
					
						</div>
					</div>
				</div>
			</div>
	<%@include file="todoSns.jsp" %>
	</div>
	</div>
<div class="row">
<%@include file="/footer.jsp" %>
</div>
</div>