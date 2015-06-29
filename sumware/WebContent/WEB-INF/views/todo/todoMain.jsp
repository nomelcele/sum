<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
// push Client 설정 (받는쪽)
	var rowsPerPage =8; //sns에 쓸 행수
	var eventSource;
	var cheight=$('.chat').height()-50;//sns
	var ch ;//snsComm
	var pageB=5; //snscomm에서 쓸 페이지 행수
	$(function(){
		push();
	});
	
	function push(){
		if(typeof(EventSource) != "undefined"){
			 // push를 받을수 있는 브라우져인지 판단.
			eventSource = new EventSource("pushSns?sdept=${v.memdept}&page=1&rowsPerPage="+rowsPerPage);
			eventSource.onmessage = function(event){
				$(".chat").html(event.data);
			};
		}else{
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
	}
	function pageScoll(){
		var sctop=$('.chat').scrollTop();
		if ( sctop > cheight) {
			$("#loading").html("<img src='resources/img/loading.gif' alt='loading'>");
			setTimeout(function(){
				rowsPerPage+=5;
				cheight+=($('.chat').scrollTop()+100);
				eventSource.close();
				$("#loading img").remove();
				push();
				
			}, 1000);	
					
		}
	}

	function snsSend(){
		$(".chat").scrollTop(0);
		var fdata = {
			smem:"${v.memnum}",
			sdept:"${v.memdept}",
			scont:$("#btn-input").val()
		};
		$('#btn-input').val("");
		$.ajax({
			type:"POST",
			url:"insertSns",
			data:fdata
		});
	}
	function snsComm(snum){
		var rowsPerPage=10;
		var data={
			page:"1",
			rowsPerPage:rowsPerPage,
			snum:snum
		};
		$.ajax({
			type:"POST",
			url:"snsComm",
			data:data,
			success: function(result){
				$("#wrapbody").html(result);
				$("#snsCommBtn").click();
 				ch= $('#snsCommList').height()-100;
			},
			error: function(a, b) {
                alert("Request: " + JSON.stringify(a));
            }
		});
	}
	function snsInsertComm(snum){
		var data={
				comem:"${v.memnum}",
				page:"1",
				rowsPerPage:pageB,
				snum:snum,
				cocont:$('#cocont').val()
			};
		$.ajax({
			type:"POST",
			url:"snsCommInsert",
			data:data,
			success: function(result){
				$("#wrapbody").html(result);
			},
			error: function(a, b) {
                alert("Request: " + JSON.stringify(a));
            }
		});
	}
	function snsCommDelete(conum,commsns){
		var data={
				page:"1",
				rowsPerPage:pageB,
				snum:commsns,
				conum:conum
		};
		$.ajax({
			type:"POST",
			url:"snsCommDelete",
			data:data,
			success:function(result){
				$("#wrapbody").html(result);
			}
		});
		
	}
	function snsCommScroll(snum){
		var st = $('#snsCommList').scrollTop();
		console.log("st:"+st);
		console.log("ch:"+ch);
	
		if ( st >= ch ){
			$("#commloading").html("<img src='img/loading.gif' alt='loading'>");
			setTimeout(function(){
				ch+=$('#snsCommList').height()-200;
				$("#commloading img").remove();
				
				pageB +=5;
				var page=pageB;
				var rowsPerPage=pageB;
				var data={
					page:"1",
					rowsPerPage:rowsPerPage,
					snum:snum
				};
				$.ajax({
					type:"POST",
					url:"snsComm",
					data:data,
					success: function(result){
						$("#wrapbody").html(result);
						$('#snsCommList').scrollTop(st);
					}
				});
			}, 1000);
		}
		
	}
</script>
<style>
	#loading img{float:none; width:40px;}
	#commloading img{float:none; width:40px;}
</style>
<div id="global" class="wrap-layout board">
			<div class="lnb-area" id="lnb-area">
			</div>
			<!-- 부서업무 부분!! -->
			<!-- menutarget 부분 -->
			<div class="contents">
				<div class="col-lg-4" style="width: 50%"  id="menuTarget">
					<div class="chat-panel panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-pencil-square-o"></i> <strong class="primary-font">부서업무</strong>
						</div>
						<div class="panel-body"  style="height:510px; overflow-y:scroll;">
							<div class="column" style="overflow: auto">
								<c:forEach var="deptjoblist" items="${deptJobList }">
									<div class="low-lg-${deptjoblist.tonum }">
										<div class="panel panel-success">
											<div class="panel-heading">
												<i class="fa fa-pencil"></i> ${deptjoblist.totitle }
											</div>
											<div class="panel-body">
												<p>
													<i class="fa fa-user"></i> manager : ${deptjoblist.memname }
												</p>
												<p>
													<i class="fa fa-calendar-o"></i> date :
													${deptjoblist.tostdate } ~ ${deptjoblist.toendate }
												</p>
											</div>
											<div class="panel-footer">
												<a class="fa fa-align-justify"
													onclick="javascript:getJobDetail(${deptjoblist.tonum })"
													style="cursor: pointer"> detail</a>
												<div id="memlisttarget${deptjoblist.tonum }"
													style="display: none"></div>
												<div id="detail${deptjoblist.tonum }" style="display: none">
													<br />
													<p>${deptjoblist.tocont }</p>
													<p>
														<a href="upload/${deptjoblist.tofile }" target="_blank">
														<i class="fa fa-paperclip"></i> 첨부파일
														: ${deptjoblist.tofile }</a>
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
			<!-- menu target 끝! -->
			<!-- 부서업무 부분 끝!!! -->
			<!-- SnS -->
	<div class="col-lg-4" style="width: 50%">
				<div class="chat-panel panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> <strong
							class="primary-font">부서 SNS</strong>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<ul class='chat' style="height:450px; overflow-y:scroll;" onscroll="pageScoll()">
						</ul>
						<div id="loading" style="width: 100%; float:left; text-align: center;">
					
						</div>
					</div>
					
					<!-- /.panel-body -->
					<div class="panel-footer">
						<div class="input-group">
							<input id="btn-input" type="text" class="form-control input-sm" placeholder="메시지를 입력해주세요" onkeydown="enterCheck(1)">
							<span class="input-group-btn">
								<button class="btn btn-warning btn-sm" onclick="snsSend()" id="send">Send</button>
							</span>
						</div>
					</div>
					<!-- /.panel-footer -->
				</div>
				<!-- /.panel .chat-panel -->
	</div>	
			<button type="button" class="modal fade" id="snsCommBtn" data-toggle="modal" data-target="#wrap3"></button>	
			<div class='modal' id='wrap3' role='dialog'>
			<div class="modal-dialog">
			 <div class="modal-content">
			 	<div class="modal-header">
			  		<button type="button" class="close" data-dismiss="modal">&times;</button>
			        <h4 class="modal-title">댓글</h4>
			    </div>
			    <div class="modal-body" id="wrapbody">
			
				<!-- comment-write(E) -->
				</div>
			</div>
			</div>
	</div>
</div>
