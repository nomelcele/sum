<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="chat-panel panel panel-default" style="width: 60%">
					<div class="panel-heading">
						<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
							게시판 삭제</strong>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="control-label">부 서</label> 
							<select id="searchDept" onchange="getDeptBoards()" class="form-control" style="width: 120px">
											<option value="">부서</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">게시판</label> 
							<select id="searchDeptBoard" class="form-control" style="width: 120px">
								<option value="0">게시판</option>
							</select>
						</div>
						<div class="form-group">
							<input type="button" class="btn btn-outline btn-default" onclick="deleteBoard()" value="삭제">
						</div>
					</div>
				</div>






<!-- <div> -->
<!-- 			<select id="searchDept" onchange="getDeptBoards()"> -->
<!-- 				<option value="0">부서</option> -->
<!-- 				<option value="100">인사부</option> -->
<!-- 				<option value="200">총무부</option> -->
<!-- 				<option value="300">영업부</option> -->
<!-- 				<option value="400">전산부</option> -->
<!-- 				<option value="500">기획부</option> -->
<!-- 			</select> -->
<!-- 			<select id="searchDeptBoard"> -->
<!-- 				<option value="0">게시판</option> -->
<!-- 			</select> -->
<!-- 			&nbsp; -->
<!-- 			<input type="button" class="btn btn-default btn-sm" value="게시판 보기" onclick="getDeptBoardList()"> -->
<!-- 			<input type="button" class="btn btn-default btn-sm" value="게시판 삭제" onclick="deleteBoard()"> -->
<!-- 			<br/><br/> -->
<!-- 		</div> -->
