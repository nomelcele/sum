<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- Search (S) -->
		<div>
			<select id="searchDept">
				<option value="0">부서</option>
				<option value="100">인사부</option>
				<option value="200">총무부</option>
				<option value="300">영업부</option>
				<option value="400">전산부</option>
				<option value="500">기획부</option>
			</select>&nbsp;
			<input type="text" id="searchName" placeholder="이름">
			<input type="button" class="btn btn-default btn-sm" value="검색" onclick="adminSelectMenu('adminMemList')">
			<br/><br/>
		</div>
	<!-- Search (E) -->
	
	<!-- List (S) -->
    	<div>
			<table class="table table-condensed table-hover" id="listTable">
				<tbody>
					<tr style="background-color: #F5F5F5;">
						<td class="col-lg-1"><span>이름</span></td>
						<td class="col-lg-1"><span>ID</span></td>
						<td class="col-lg-1"><span>생년월일</span></td>
						<td class="col-lg-2"><span>주소</span></td>
						<td class="col-lg-1"><span>부서</span></td>
						<td class="col-lg-1"><span>직급</span></td>
						<td class="col-lg-1"><span>입사일</span></td>
						<td class="col-lg-2"></td>
					</tr>
					
					<c:forEach var="mList" items="${list}">
						<tr>
							<td>${mList.memname}</td>
							<td>${mList.meminmail}</td>
							<td>${mList.membirth}</td>
							<td>${mList.memaddr}</td>
							<td>${mList.dename}</td>
							<td>${mList.memjob}</td>
							<td>${mList.memhire}</td>
							<td>
								<input type="button" class="btn btn-default btn-sm" value="인사고과" 
								data-toggle="modal" data-target="#prForm">
								<input type="button" class="btn btn-default btn-sm" value="퇴사 처리" onclick="resignMem(${mList.memnum})">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- List (E) -->
		
		<!-- Modal (S) -->
		<div class="modal fade" id="prForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h3 class="modal-title" id="myModalLabel">Modal title</h3>
	      </div>
	      <div class="modal-body">
	         <div class="tabbable"> 
		        <ul class="nav nav-tabs">
		        <li class="active"><a href="#tab1" data-toggle="tab">사원 진급 처리</a></li>
		        <li><a href="#tab2" data-toggle="tab">사원 부서 이동</a></li>
		        </ul>
		        <div class="tab-content">
		        
		        	<br/>
			        <div class="tab-pane active" id="tab1"> 
			        	<div class="form-group">
			        		<label class="control-label">현재 직급</label> 
							<input type="text" id="curmemjob" class="form-control" style="width: 120px" readonly="readonly">
			        	</div>
			        	<div class="form-group">
							<label class="control-label">변경할 직급</label> 
							<select name="memjob" id="newmemjob" class="form-control" style="width: 120px">
											<option value="0">직급 선택</option>								
											<option value="대표이사">대표이사</option>
											<option value="이사">이사</option>
											<option value="부장">부장</option>
											<option value="팀장">팀장</option>
											<option value="사원">사원</option>
							</select>
						</div>
			        </div>
			   
			        <div class="tab-pane" id="tab2">
			        	<div class="form-group">
			        		<label class="control-label">현재 부서</label> 
							<input type="text" id="curmemdept" class="form-control" style="width: 120px" readonly="readonly">
			        	</div>
			        	<div class="form-group">
							<label class="control-label">변경할 부서</label> 
							<select name="memdept" id="newmemdept" class="form-control" style="width: 120px">
											<option value="0">부서 선택</option>								
											<option value="100">인사부</option>
											<option value="200">총무부</option>
											<option value="300">영업부</option>
											<option value="400">전산부</option>
											<option value="500">기획부</option>
							</select>
						</div>
			        </div>
		        </div>
		        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="saveChange()">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
							
		<!-- Modal (E) -->
		
		
			
		<!-- Button to trigger modal -->
<!-- <a href="#TaskListDialog" role="button" class="btn" data-toggle="modal">Launch demo modal</a> -->
<script>
	function saveChange(){
		console.log("탭 아이디: "+$(".tab-pane active").attr("id"));
		if($(".tab-pane active").attr("id") == "tab1"){
			// 직급 변경 탭
			console.log("직급 변경 탭");
			
			if(!confirm("직급을 변경하시겠습니까?")){
				return; 
			} else {
				$.ajax({
					type: "POST",
					url: "adminPromoteMem",
					data: {
						memnum: 10004,
						memjob: $("#newmemjob").val()
					},
					success: function(result){
						$('.contents').html(result);
					}
				});
			}
		} else {
			// 부서 이동 탭
			console.log("부서 이동 탭");
			
			if(!confirm("부서를 변경하시겠습니까?")){
				return; // 취소를 할 경우 삭제되지 않는다.
			} else { 
				$.ajax({
					type: "POST",
					url: "adminMoveDept",
					data: {
						memnum: 10004,
						memdept: $("#newmemdept").val()
					},
					success: function(result){
						// 모달 꺼줘야 함
						$('#prForm').modal('toggle');
						$('.contents').html(result);
					}
				});
			}
		}
	}
</script>
