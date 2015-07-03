<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		
				<div class="chat-panel panel panel-default" style="width: 60%">
					<div class="panel-heading">
						<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
							게시판 추가</strong>
					</div>
					<div class="panel-body">
						<div class="form-group has-success">
							<label class="control-label">게시판 이름</label> 
							<input type="text" class="form-control" name="bname" id="newbname" style="width: 120px">
						</div>
						<div class="form-group has-success">
							<label class="control-label">부 서</label> 
							<select name="bdeptno" id="newbdeptno" class="form-control" style="width: 120px">
											<option value="">부서 선택</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
						<div class="form-group has-success">
							<input type="button" class="btn btn-outline btn-success" onclick="javascript: sendNewMember()" id = "sendFormToAdd" value="추 가">
						</div>
					</div>
				</div>

