<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/top.jsp"%>



		<div id="wrap" class="board">
			<div class="lnb-area">
			<%@include file="/contentLeft.jsp"%>
			</div>
			<!-- 부서업무 부분!! -->
			<!-- menutarget 부분 -->
			<div class="contents" style="padding-left:50px">
			<div class="col-lg-4" style="width: 45%"  id="menuTarget">
				
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


<%@include file="todoSns.jsp"%>
</div>
	</div>



		<%@include file="/footer.jsp"%>
