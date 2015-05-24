<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 업무 추가 부분 뷰 -->
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
		
	<!-- 업무추가  -->
		<div class="col-lg-2" style="width: 35%">
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">업무 추가</strong>
				</div>
				<div class="panel-body">
					<div class="column" style="overflow: auto">

						<form role="form" action="sumware" method="post" name="addTodoForm" id="addTodoForm"
							enctype="multipart/form-data">
							<input type="hidden" name="model" value="todo"> 
							 <input type="hidden" name="submod" value="addTodo"> 
							 <input type="hidden" name="todept" value="${sessionScope.v.memdept }">
							 <input type="hidden" name="toconfirm" value="n">
							 <input type="hidden" name="memnum" value="${sessionScope.v.memnum }">


							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess">업무 제목</label> 
								<input type="text" class="form-control" id="inputSuccess" name="totitle"
									style="width: 70%">
							</div>

							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess">업무 기간</label></br> 
								<input type="date" name="tostdate" class="form-control" style="width: 150px; display: inline;"> 
								~ <input type="date" name="toendate" class="form-control" style="width: 150px; display: inline;">

							</div>



							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess">업무 내용</label>
								<textarea class="form-control" id="inputSuccess" rows="5" name="tocont"
									style="width: 70%"></textarea>
							</div>
							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess">Selects</label>
								<select name="tomem" class="form-control" id="inputSuccess"
									style="width: 70%">
									<option value="">팀장 선택</option>
									<c:forEach var="tNameList" items="${teamNameList}">
										<option value="${tNameList.memnum }">${tNameList.memname}</option>

									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label class="control-label" for="inputSuccess">파일 첨부</label> <input
									type="file" class="btn btn-outline btn-success" name="tofile">
							</div>


							<div class="form-group has-warning">
								<label class="control-label" for="inputWarning">남길 말</label> <input
									type="text" class="form-control" id="inputWarning" name="tocomm"
									style="width: 70%">
							</div>
							<div>
								<button type="button" class="btn btn-outline btn-success" onclick="javascript:todoFormGo(6)">보내기</button>
<!-- 								<button type="button" class="btn btn-outline btn-warning">다시 -->
<!-- 									작성</button> -->
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 업무 추가부분 끝 -->

	<%@include file="snsTodo.jsp" %>
	</div>
	</div>
<%@include file="/footer.jsp" %>

