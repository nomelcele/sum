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
								onclick="javascript:getMemInfoForModal('prForm',${mList.memnum})">
								<input type="button" class="btn btn-default btn-sm" value="퇴사 처리" onclick="resignMem(${mList.memnum})">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- List (E) -->
		
		<div id="modalTarget"></div>
		
		
			
		<!-- Button to trigger modal -->
<!-- <a href="#TaskListDialog" role="button" class="btn" data-toggle="modal">Launch demo modal</a> -->
<script>
// 탭 아이디 불러오기
// 모달 닫기
	function saveChange(memnum){
		var newmemjob = $("#newmemjob").val();
		var newmemdept = $("#newmemdept").val();
		
		if(newmemjob == 0 && newmemdept == 0){
			alert("변경 사항을 선택하세요");
		} else if(newmemjob != 0){
			// 첫번째 탭에서 변경할 직급을 선택했을 때
			// 직급 변경 탭
			console.log("직급 변경 탭");
			
			if(!confirm("직급을 변경하시겠습니까?")){
				return; 
			} else {
				$.ajax({
					type: "POST",
					url: "adminPromoteMem",
					data: {
						memnum: memnum,
						memjob: $("#newmemjob").val()
					},
					success: function(result){
						$('.contents').html(result);
					}
				});
			}
		} else if(newmemdept != 0){
			// 두번째 탭에서 변경할 부서를 선택했을 때
			// 부서 이동 탭
			console.log("부서 이동 탭");
			
			if(!confirm("부서를 변경하시겠습니까?")){
				return; // 취소를 할 경우 삭제되지 않는다.
			} else { 
				$.ajax({
					type: "POST",
					url: "adminMoveDept",
					data: {
						memnum: memnum,
						memdept: $("#newmemdept").val()
					},
					success: function(result){
						// 모달 꺼줘야 함
						// $('#prForm').modal('toggle');
						$('.contents').html(result);
					}
				});
			}
		}
	
	
	
	
// 		console.log("사원 번호: "+memnum);
// 		console.log("탭 아이디: "+$(".tab-pane active").attr("id"));
// 		console.log($(".tab-pane").attr("id"));
		
// 		if($(".tab-pane active").attr("id") == "tab1"){
// 			// 직급 변경 탭
// 			console.log("직급 변경 탭");
			
// 			if(!confirm("직급을 변경하시겠습니까?")){
// 				return; 
// 			} else {
// 				$.ajax({
// 					type: "POST",
// 					url: "adminPromoteMem",
// 					data: {
// 						memnum: memnum,
// 						memjob: $("#newmemjob").val()
// 					},
// 					success: function(result){
// 						$('.contents').html(result);
// 					}
// 				});
// 			}
// 		} else {
// 			// 부서 이동 탭
// 			console.log("부서 이동 탭");
			
// 			if(!confirm("부서를 변경하시겠습니까?")){
// 				return; // 취소를 할 경우 삭제되지 않는다.
// 			} else { 
// 				$.ajax({
// 					type: "POST",
// 					url: "adminMoveDept",
// 					data: {
// 						memnum: memnum,
// 						memdept: $("#newmemdept").val()
// 					},
// 					success: function(result){
// 						// 모달 꺼줘야 함
// 						// $('#prForm').modal('toggle');
// 						$('.contents').html(result);
// 					}
// 				});
// 			}
//		}
	}
</script>
