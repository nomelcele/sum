<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 업무 관리(팀장일 경우) 부분 뷰 -->
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

								<c:forEach var="tolist" items="${todoList }">
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
												<p>Comment : ${tolist.tocomm }</p>

											</div>
											<div class="panel-footer">

												<button type="button" class="btn btn-outline btn-success"
													data-toggle="modal" data-target="#okModal">승인</button>

												<button type="button" class="btn btn-outline btn-warning"
													data-toggle="modal" data-target="#rejectModal">거절</button>

												<%@include file="okTodoModal.jsp" %>
												
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
