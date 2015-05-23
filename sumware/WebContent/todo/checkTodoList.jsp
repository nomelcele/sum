<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 업무 관리(팀장일 경우) 부분 뷰 -->
<%@include file="/top.jsp"%>
<div class="row">
	<form action="sumware" method="post" id="goTodo">
		<input type="hidden" id="model" name="model">
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="memnum" name="memnum">
		<input type="hidden" id="memmgr" name="memmgr">
	</form>
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

											</div>
											<div class="panel-footer">

												<button type="button" class="btn btn-outline btn-success"
													data-toggle="modal" data-target="#okModal">승인</button>


												<!-- Modal -->
												<div id="okModal" class="modal fade" role="dialog">
													<div class="modal-dialog">

														<!-- Modal content-->
														<div class="modal-content">
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">&times;</button>
																<h4 class="modal-title">거절</h4>
															</div>
															<form action="sumware" method="post" id="okForm">
																<input type="hidden" name="model" value="todo">
																<input type="hidden" name="submod" value="checkTodoList">
																<input type="hidden" name="childmod" value="approveTodo">
																<input type="hidden" name="tonum"
																	value="${tolist.tonum }"> <input type="hidden"
																	name="memnum" value="${sessionScope.v.memnum }">
																<div class="modal-body has-success">
																	<label class="control-label">남길 말</label>
																	<input type="text" class="inputsuccess" name="tocomm">
																</div>
																<div class="modal-footer">
																	<button type="button" class="btn btn-default"
																		data-dismiss="modal"
																		onclick="javascript:todoFormGo(3)">보내기</button>
																</div>
															</form>
														</div>

													</div>
												</div>


												<button type="button" class="btn btn-outline btn-warning"
													data-toggle="modal" data-target="#rejectModal">거절</button>


												<!-- Modal -->
												<div id="rejectModal" class="modal fade" role="dialog">
													<div class="modal-dialog">

														<!-- Modal content-->
														<div class="modal-content">
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal">&times;</button>
																<h4 class="modal-title">거절</h4>
															</div>
															<form action="sumware" method="get" id="rejectForm">
																<input type="hidden" name="model" value="todo">
																<input type="hidden" name="submod" value="checkTodoList">
																<input type="hidden" name="childmod" value="rejectTodo">
																<input type="hidden" name="tonum"
																	value="${tolist.tonum }"> <input type="hidden"
																	name="memnum" value="${sessionScope.v.memnum }">
																<div class="modal-body has-success">
																	<label class="control-label">남길 말</label> 
																	<input type="text" class="inputsuccess" name="tocomm">

																</div>
																<div class="modal-footer">
																	<button type="submit" class="btn btn-default"
																		data-dismiss="modal"
																		onclick="javascript:todoFormGo(4)">보내기</button>
																</div>
															</form>
														</div>

													</div>
												</div>
												<!-- Modal -->
											</div>
										</div>
									</div>
								</c:forEach>

								<!-- /.col-lg-4 -->
							</div>

								</tbody>
							</table>
							<!-- /.col-lg-4 -->
						</div>
					</div>
				</div>
			</div>
		<!-- 팀장 업무관리 끝!!! -->
		
	<%@include file="snsTodo.jsp" %>
	</div>
	</div>
<%@include file="/footer.jsp" %>
