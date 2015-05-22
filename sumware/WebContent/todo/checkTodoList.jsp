<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap 101 Template</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
</head>
<body>
	<div class="row">
		<form action="../sumware" method="post" id="goTodo">
			<input type="hidden" id="model" name="model"> <input
				type="hidden" id="submod" name="submod"> <input
				type="hidden" id="memnum" name="memnum"> <input
				type="hidden" id="memmgr" name="memmgr">
		</form>


		<div class="wrap">
			<div class="col-lg-1" style="width: 250px">
				<div class="row-lg-1">
					<div class="chat-panel panel panel-default">

						<div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
								profile</strong>

						</div>


						<div class="panel-body">
							<span class="chat-img pull-left"> <img
								src="../profileImg/${sessionScope.v.memprofile }"
								alt="User Avatar" class="img-circle"
								style="width: 100px; height: 100px;">
							</span> <br />
							<br />
							<br />
							<br />
							<br />

							<table>
								<tr>
									<td><strong class="primary-font" style="margin: 10px">이름</strong></td>
									<td>${sessionScope.v.memname }</td>
								</tr>
								<tr>
									<td><strong class="primary-font" style="margin: 10px">직급</strong></td>
									<td>${sessionScope.v.memjob }</td>
								</tr>
								<tr>
									<td><strong class="primary-font" style="margin: 10px">부서</strong></td>
									<td>${sessionScope.v.dename }</td>
								</tr>
								<tr>
									<td><strong class="primary-font" style="margin: 10px">상급자</strong></td>
									<td>${sessionScope.v.mgrname }</td>
								</tr>

							</table>

						</div>
					</div>

				</div>

				<div class="row-lg-2">
					<div class="list-group">

						<a href="#" class="list-group-item disabled"><span
							class="glyphicon glyphicon-pencil"></span><strong
							class="primary-font">Todo</strong></a> <a href="#"
							class="list-group-item">부서 업무</a> <a href="#"
							class="list-group-item">팀 업무</a>
						<c:if test="${sessionScope.v.memauth lt 5 }">
							<a href="javascript:todoFormGo(1)" class="list-group-item">업무관리</a>
						</c:if>
						<c:if test="${sessionScope.v.memauth lt 4 }">
							<a href="javascript:todoFormGo(2)" class="list-group-item">업무추가</a>
						</c:if>

					</div>

				</div>


			</div>
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

			<div class="col-lg-3" style="width: 40%">
				<div class="chat-panel panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-bar-chart-o fa-fw"></i> <strong
							class="primary-font">부서 SNS</strong>
						<div class="btn-group pull-right">
							<button type="button"
								class="btn btn-default btn-xs dropdown-toggle"
								data-toggle="dropdown">
								<i class="fa fa-chevron-down"></i>
							</button>
							<ul class="dropdown-menu slidedown">
								<li><a href="#"> <i class="fa fa-refresh fa-fw"></i>
										Refresh
								</a></li>
								<li><a href="#"> <i class="fa fa-check-circle fa-fw"></i>
										Available
								</a></li>
								<li><a href="#"> <i class="fa fa-times fa-fw"></i> Busy
								</a></li>
								<li><a href="#"> <i class="fa fa-clock-o fa-fw"></i>
										Away
								</a></li>
								<li class="divider"></li>
								<li><a href="#"> <i class="fa fa-sign-out fa-fw"></i>
										Sign Out
								</a></li>
							</ul>
						</div>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<ul class="chat">
							<li class="left clearfix"><span class="chat-img pull-left">
									<img src="img/angel.jpg" alt="User Avatar" class="img-circle"
									style="width: 50px; height: 50px;">
							</span>
								<div class="chat-body clearfix">
									<div class="header">
										<strong class="primary-font">Jack Sparrow</strong> <small
											class="pull-right text-muted"> <i
											class="fa fa-clock-o fa-fw"></i> 12 mins ago
										</small>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Curabitur bibendum ornare dolor, quis ullamcorper ligula
										sodales.</p>
								</div></li>
							<li class="right clearfix"><span class="chat-img pull-right">
									<img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar"
									class="img-circle">
							</span>
								<div class="chat-body clearfix">
									<div class="header">
										<small class=" text-muted"> <i
											class="fa fa-clock-o fa-fw"></i> 13 mins ago
										</small> <strong class="pull-right primary-font">Bhaumik
											Patel</strong>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Curabitur bibendum ornare dolor, quis ullamcorper ligula
										sodales.</p>
								</div></li>
							<li class="left clearfix"><span class="chat-img pull-left">
									<img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar"
									class="img-circle">
							</span>
								<div class="chat-body clearfix">
									<div class="header">
										<strong class="primary-font">Jack Sparrow</strong> <small
											class="pull-right text-muted"> <i
											class="fa fa-clock-o fa-fw"></i> 14 mins ago
										</small>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Curabitur bibendum ornare dolor, quis ullamcorper ligula
										sodales.</p>
								</div></li>
							<li class="right clearfix"><span class="chat-img pull-right">
									<img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar"
									class="img-circle">
							</span>
								<div class="chat-body clearfix">
									<div class="header">
										<small class=" text-muted"> <i
											class="fa fa-clock-o fa-fw"></i> 15 mins ago
										</small> <strong class="pull-right primary-font">Bhaumik
											Patel</strong>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Curabitur bibendum ornare dolor, quis ullamcorper ligula
										sodales.</p>
								</div></li>
						</ul>
					</div>
					<!-- /.panel-body -->
					<div class="panel-footer">
						<div class="input-group">
							<input id="btn-input" type="text" class="form-control input-sm"
								placeholder="Type your message here..."><span
								class="input-group-btn">
								<button class="btn btn-warning btn-sm" id="btn-chat">
									Send</button>
							</span>
						</div>
					</div>
					<!-- /.panel-footer -->
				</div>
				<!-- /.panel .chat-panel -->
			</div>
		</div>
	</div>
	<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
	function todoFormGo(res){
		$('#model').attr("value","todo");
		
		if(res==1){
			
			
		}else if(res==2){
			$('#submod').attr("value","addtodoForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			console.log("memnum",$('#memnum').val());
			$('#goTodo').submit();
		}else if(res==3){
			$('#okForm').submit();
		}else if(res==4){
			$('#rejectForm').submit();
		}
		
	}
	
	

	
	
	
</script>
</body>
</html>
