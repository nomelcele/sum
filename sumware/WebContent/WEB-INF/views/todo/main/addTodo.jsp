<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 업무 추가 부분 뷰 ajax-->
		
	<!-- 업무추가  -->

			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-plus-square-o"></i> <strong class="primary-font">업무 추가</strong>
				</div>
				<div class="panel-body">
					<div class="column">

						<form action="saaddTodo" method="post" id="addTodoForm"  enctype="multipart/form-data" >
							 <input type="hidden" name="todept" value="${sessionScope.v.memdept }">
<%-- 							 <input type="hidden" name="memnum" value="${sessionScope.v.memnum }"> --%>
<%-- 							 <input type="hidden" name="memdept" value="${sessionScope.v.memdept }"> --%>

							<div class="form-group has-success">
								<label class="control-label"><i class="fa fa-pencil"></i> 업무 제목</label> 
								<input type="text" class="form-control" id="totitle" name="totitle"
									style="width: 70%">
							</div>

							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess"><i class="fa fa-calendar-o"></i> 업무 기간</label><br/> 
								<input type="date" id="tostdate" name="tostdate" class="form-control" style="width: 150px; display: inline;"> 
								~ <input type="date" id="toendate" name="toendate" class="form-control" style="width: 150px; display: inline;">

							</div>

							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess">업무 내용</label>
								<textarea class="form-control" rows="5" id="tocont" name="tocont"
									style="width: 70%"></textarea>
							</div>
							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess"><i class="fa fa-user"></i> 담당자</label>
								<select name="tomem" class="form-control" id="selectTomem"
									style="width: 70%">
									<option value="">팀장 선택</option>
									<c:forEach var="tNameList" items="${teamNameList}">
										<option value="${tNameList.memnum }">${tNameList.memname}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group has-success">
								<label class="control-label" for="inputSuccess"><i class="fa fa-paperclip"></i> 파일 첨부</label> 
								<input type="file" name="mfile" id="mfile">
							</div>

							<div class="form-group has-warning">
								<label class="control-label" for="inputWarning"><i class="fa fa-thumb-tack"></i> 남길 말</label> <input
									type="text" class="form-control" id="inputWarning" id="tocomm" name="tocomm"
									style="width: 70%">
							</div>
							<div>
<!-- 									<input type="button" class="btn btn-outline btn-success" onclick="javascript:document.getElementById('addTodoForm').submit()" id = "sendJob" value="보내기"> -->
								<button type="button" class="btn btn-outline btn-success" onclick="javascript:todoFormGo('addTodo')" id = "sendJob">보내기</button>
<!-- 								<button type="button" class="btn btn-outline btn-success" id ="addTodoFormSend">보내기</button> -->
							</div>
						</form>
					</div>
				</div>
			</div>
		
		<!-- 업무 추가부분 끝 -->
