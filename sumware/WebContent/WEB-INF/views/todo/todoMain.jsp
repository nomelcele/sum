<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

</script>
<style>
#loading img {
	float: none;
	width: 40px;
}
#commloading img {
	float: none;
	width: 40px;
}
</style>
	<!-- 부서업무 부분!! -->
	<!-- menutarget 부분 -->
		<div class="col-lg-4" style="width: 50%" id="menuTarget">
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-pencil-square-o"></i> <strong class="primary-font">부서업무</strong>
				</div>
				<div class="panel-body" style="height: 510px; overflow-y: scroll;">
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
												<i class="fa fa-paperclip"></i> 첨부파일 
												<c:if test="${deptjoblist.tofile ne null}" >
												<a href="sadownloadFile?fileName=${deptjoblist.tofile }" target="_blank">${deptjoblist.tofile } <i class="fa fa-download"></i></a>
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
		<!-- menu target 끝! -->
		<!-- 부서업무 부분 끝!!! -->
		<!-- SnS -->
		<div class="col-lg-4" style="width: 50%">
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">부서
						SNS</strong>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class='chat' style="height: 450px; overflow-y: scroll;"
						onscroll="pageScoll()">
					</ul>
					<div id="loading"
						style="width: 100%; float: left; text-align: center;"></div>
				</div>
				<!-- /.panel-body -->
				<div class="panel-footer">
					<div class="input-group">
						<input id="btn-input" type="text" class="form-control input-sm"
							placeholder="메시지를 입력해주세요" onkeydown="enterCheck(1)"> <span
							class="input-group-btn">
							<button class="btn btn-warning btn-sm" onclick="snsSend(${sessionScope.v.memnum},${sessionScope.v.memdept})"
								id="send">Send</button>
						</span>
					</div>
				</div>
				<!-- /.panel-footer -->
			</div>
			<!-- /.panel .chat-panel -->
		</div>
		<button type="button" class="modal fade" id="snsCommBtn"
			data-toggle="modal" data-target="#wrap3"></button>
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
