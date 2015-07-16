<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- board left(S) --%>
<c:if test="${sessionScope.model eq 'board' }">
	<form action="sumware" method="post" id="goTodo">
		<input type="hidden" id="model" name="model"> <input
			type="hidden" id="submod" name="submod"> <input type="hidden"
			id="memnum" name="memnum"> <input type="hidden" id="memmgr"
			name="memmgr"> <input type="hidden" id="memdept"
			name="memdept">
	</form>
	<div>
		<div class="row-lg-6">
			<!-- left-profile(S) -->
			<div class="chat-panel panel panel-default left-profile">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
						profile</strong>
				</div>
				<div class="panel-body">
					<!-- profile-img(S) -->
					<span class="chat-img pull-left profile-img"><img
						src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
						class="img-circle" style="width: 100px; height: 130px;"> </span>
					<!-- profile-img(E) -->

					<!-- profile-table(S) -->
					<table class="profile-table">
						<colgroup>
							<col style="width: 60px">
							<col>
						</colgroup>
						<tr>
							<th><strong class="primary-font">이름</strong></th>
							<td>${sessionScope.v.memname }</td>
						</tr>
						<tr>
							<th><strong class="primary-font">직급</strong></th>
							<td>${sessionScope.v.memjob }</td>
						</tr>
						<tr>
							<th><strong class="primary-font">부서</strong></th>
							<td>${sessionScope.v.dename }</td>
						</tr>
						<tr>
							<th><strong class="primary-font">상급자</strong></th>
							<td>${sessionScope.v.mgrname }</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"><a
								href="modifyProfile"
								class="primary-font"><i class="fa fa-cog"></i> 사원 정보</a></td>
						</tr>
					</table>
					<!-- profile-table(E) -->
				</div>
			</div>
			<!-- left-profile(E) -->
		</div>
	</div>
	<!-- <hr> -->
	<!-- left-menu(S) -->
	<div class="left-menu" id="board-left-menu">
	<form action="saboardList" method="post" id="listtt">
		<input type="hidden" name="model" value="board">
		<input type="hidden" name="page" value="1">
		<input type="hidden" name="bgnum" id="bgnum" >
		<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
		<input type="hidden" name="bname" id="bname">
		<input type="hidden" name="bsearch" value="">
		<input type="hidden" name="div" value="">
	</form>	
		<ul>
			<li><a href="">공지사항</a><span style="display: none;">0</span></li>
			<c:forEach var="blist" items="${sessionScope.bNameList }">
				<c:if test="${blist.bgnum eq 0 }">
					<c:remove var="blist" />
				</c:if>
			<li><a href="">${blist.bname }</a><span style="display: none;">${blist.bgnum }</span></li>
			</c:forEach>
		</ul>
	</div>
	<!-- left-menu(E) -->

</c:if>
<%-- board left(E) --%>

<%-- todo left(S) --%>
<c:if test="${sessionScope.model eq 'todo' }">
	<div class="row-lg-6">

		<!-- left-profile(S) -->
		<div class="chat-panel panel panel-default left-profile">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
					profile</strong>
			</div>

			<div class="panel-body">
				<!-- profile-img(S) -->
				<span class="chat-img pull-left profile-img"><img
					src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
					class="img-circle" style="width: 100px; height: 130px;"> </span>
				<!-- profile-img(E) -->

				<!-- profile-table(S) -->
				<table class="profile-table">
					<colgroup>
						<col style="width: 60px">
						<col>
					</colgroup>
					<tr>
						<th><strong class="primary-font">이름</strong></th>
						<td>${sessionScope.v.memname }</td>
					</tr>
					<tr>
						<th><strong class="primary-font">직급</strong></th>
						<td>${sessionScope.v.memjob }</td>
					</tr>
					<tr>
						<th><strong class="primary-font">부서</strong></th>
						<td>${sessionScope.v.dename }</td>
					</tr>
					<tr>
						<th><strong class="primary-font">상급자</strong></th>
						<td>${sessionScope.v.mgrname }</td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td colspan="2"><a
							href="modifyProfile"
							class="primary-font"><i class="fa fa-cog"></i> 사원 정보</a></td>

					</tr>
				</table>
				<!-- profile-table(E) -->
			</div>
		</div>
		<!-- left-profile(E) -->
	</div>

	<!-- left-menu(S) -->
	<div class="left-menu" id="left-menu">
		<ul>
			<li><a
				href="javascript:selectMenu('deptTodo',${sessionScope.v.memdept})">부서
					업무</a></li>

			<c:if test="${sessionScope.v.memauth gt 3 }">
				<li><a
					href="javascript:selectMenu('teamTodoForm',${sessionScope.v.memnum})">팀
						업무</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 3 }">
				<li><a
					href="javascript:selectMenu('manageJob1',${sessionScope.v.memnum})">업무관리</a></li>

			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<li><a
					href="javascript:selectMenu('manageJob2',${sessionScope.v.memnum})">업무관리</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 3 }">
				<li><a
					href="javascript:selectMenu('giveJob1',${sessionScope.v.memnum})">업무부여</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<li><a
					href="javascript:selectMenu('giveJob2',${sessionScope.v.memnum})">업무부여</a></li>
			</c:if>
		</ul>
	</div>
	<!-- left-menu(E) -->

</c:if>
<%-- todo left(S) --%>

<%-- calendar left(S) --%>
<c:if test="${sessionScope.model eq 'calendar' }">
	<!-- <div> -->
	<!-- 	<div class="row-lg-6"> -->
	<div class="chat-panel panel panel-default left-profile">
		<div class="panel-heading">
			<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
				profile</strong>
		</div>
		<div class="panel-body">
			<!-- profile-img(S) -->
			<span class="chat-img pull-left profile-img"><img
				src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
				class="img-circle" style="width: 100px; height: 130px;"> </span>
			<!-- profile-img(E) -->

			<!-- profile-table(S) -->
			<table class="profile-table">
				<colgroup>
					<col style="width: 60px">
					<col>
				</colgroup>
				<tr>
					<th><strong class="primary-font">이름</strong></th>
					<td>${sessionScope.v.memname }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">직급</strong></th>
					<td>${sessionScope.v.memjob }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">부서</strong></th>
					<td>${sessionScope.v.dename }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">상급자</strong></th>
					<td>${sessionScope.v.mgrname }</td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"><a
						href="modifyProfile"
						class="primary-font"><i class="fa fa-cog"></i> 사원 정보</a></td>

				</tr>
			</table>
			<!-- profile-table(E) -->
		</div>
	</div>
</c:if>

<%-- join left(E) 사원 정보 meminfo부분--%>
<c:if test="${sessionScope.model eq 'join' }">

	<!-- <div> -->
	<!-- 	<div class="row-lg-6"> -->
	<div class="chat-panel panel panel-default left-profile">
		<div class="panel-heading">
			<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
				profile</strong>
		</div>
		<div class="panel-body">
			<!-- profile-img(S) -->
			<span class="chat-img pull-left profile-img"><img
				src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
				class="img-circle" style="width: 100px; height: 130px;"> </span>
			<!-- profile-img(E) -->

			<!-- profile-table(S) -->
			<table class="profile-table">
				<colgroup>
					<col style="width: 60px">
					<col>
				</colgroup>
				<tr>
					<th><strong class="primary-font">이름</strong></th>
					<td>${sessionScope.v.memname }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">직급</strong></th>
					<td>${sessionScope.v.memjob }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">부서</strong></th>
					<td>${sessionScope.v.dename }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">상급자</strong></th>
					<td>${sessionScope.v.mgrname }</td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"><a
						href="modifyProfile"
						class="primary-font"><i class="fa fa-cog"></i> 사원 정보</a></td>

				</tr>
			</table>
			<!-- profile-table(E) -->
		</div>
	</div>
	<!-- left-menu(S) -->
	<div class="left-menu" id="left-menu">
		<ul>
			<li><a href="javascript:memInfoSelectMenu('modifyProfile','')">정보 수정</a></li>
			<li><a href="javascript:memInfoSelectMenu('payInfo',${sessionScope.v.memnum })">급여내역조회</a></li>
			<li><a href="javascript:memInfoSelectMenu('commute','')">출퇴근 관리</a></li>
		</ul>
	</div>
	<!-- left-menu(E) -->
	
	
</c:if>
<%-- join left(E) --%>

<%-- Sign left(S) --%>
<c:if test="${sessionScope.model eq 'sign' }">
	<!-- <div> -->
	<!-- 	<div class="row-lg-6"> -->
	<div class="chat-panel panel panel-default left-profile">
		<div class="panel-heading">
			<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
				profile</strong>
		</div>
		<div class="panel-body">
			<!-- profile-img(S) -->
			<span class="chat-img pull-left profile-img"><img
				src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
				class="img-circle" style="width: 100px; height: 130px;"> </span>
			<!-- profile-img(E) -->

			<!-- profile-table(S) -->
			<table class="profile-table">
				<colgroup>
					<col style="width: 60px">
					<col>
				</colgroup>
				<tr>
					<th><strong class="primary-font">이름</strong></th>
					<td>${sessionScope.v.memname }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">직급</strong></th>
					<td>${sessionScope.v.memjob }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">부서</strong></th>
					<td>${sessionScope.v.dename }</td>
				</tr>
				<tr>
					<th><strong class="primary-font">상급자</strong></th>
					<td>${sessionScope.v.mgrname }</td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"><a
						href="modifyProfile"
						class="primary-font"><i class="fa fa-cog"></i> 프로필 수정</a></td>

				</tr>
				<tr>
					<th><strong class="primary-font">MySign</strong></th>
					<td><div id="mySignDiv" ondrop="signDrop(event)" ondragover="signAllowDrop(event)">
						<img src="resources/signImg/1.JPG" id="mySignImg" draggable="true" 
						ondragstart="signDrag(event)" width="79" height="79">
					</div></td>
				</tr>
			</table>
			<!-- profile-table(E) -->
		</div>
		<div id="MainMenu">
  <div class="list-group panel">
   <a href="javascript:signleftMenu('signWrite')" class="list-group-item">결제 문서 작성</a>
    <a href="#demo3" class="list-group-item strong" data-toggle="collapse" data-parent="#MainMenu">결재 문서 조회 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo3">
      <a href="javascript:signleftMenu('signAll')" class="list-group-item">&nbsp; &nbsp; 전체 문서</a>
      <a href="javascript:signleftMenu('signReceive')" class="list-group-item">&nbsp; &nbsp; 수신 문서</a>
      <a href="javascript:signleftMenu('signStandBy')" class="list-group-item">&nbsp; &nbsp; 대기 문서</a>
      <a href="javascript:signleftMenu('signComplete')" class="list-group-item">&nbsp; &nbsp; 완료 문서</a>
      <a href="javascript:signleftMenu('signReturn')" class="list-group-item">&nbsp; &nbsp; 반려 문서</a>
    </div>
  </div>
</div>
	</div>
	<!-- Modal(S) -->
		<div class="modal fade" id="signModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content" >
			<form action="sagetSignForm" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">결재 문서 선택하기</h4>
				</div>
				
				<div class="modal-body" id="signModalBody" style="padding-left: 60px">
				</div>
				
				<div class="modal-footer">
					<input class="btn btn-outline btn-default"  type="submit" id="signWriteFBtn" value="작성하기">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</form>
			</div>
		</div>
	</div>
	<!-- Modal(E) -->
</c:if>
		
<%-- Sign left(E) --%>

<%-- mail left(S) --%>
<c:if test="${sessionScope.model eq 'mail' }">
	<form method="post" action="sumware" id="mailform">
		<input type="hidden" id="model" name="model">
		<input type="hidden" name="page" value="1">
	</form>

	<div>
		<div>
			<div class="row-lg-6">

				<!-- left-profile(S) -->
				<div class="chat-panel panel panel-default left-profile">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
							profile</strong>
					</div>
					<div class="panel-body">
						<!-- profile-img(S) -->
						<span class="chat-img pull-left profile-img"><img
							src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
							class="img-circle" style="width: 100px; height: 130px;"> </span>
						<!-- profile-img(E) -->

						<!-- profile-table(S) -->
						<table class="profile-table">
							<colgroup>
								<col style="width: 60px">
								<col>
							</colgroup>
							<tr>
								<th><strong class="primary-font">이름</strong></th>
								<td>${sessionScope.v.memname }</td>
							</tr>
							<tr>
								<th><strong class="primary-font">직급</strong></th>
								<td>${sessionScope.v.memjob }</td>
							</tr>
							<tr>
								<th><strong class="primary-font">부서</strong></th>
								<td>${sessionScope.v.dename }</td>
							</tr>
							<tr>
								<th><strong class="primary-font">상급자</strong></th>
								<td>${sessionScope.v.mgrname }</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2"><a
									href="modifyProfile"
									class="primary-font"><i class="fa fa-cog"></i> 프로필 수정</a></td>
							</tr>
						</table>
						<!-- profile-table(E) -->
					</div>
				</div>
			</div>
		</div>
		<!-- <hr> -->

		<!-- <div>
			<a href="javascript:mailFormGo('write')" class="btn btn-info"> 
			<span class="glyphicon glyphicon-pencil"></span> 메일 쓰기
			</a>
		</div> -->

		<!-- left-menu(S) -->
		<div class="left-menu" id="left-menu">
			<ul>
				<li><a href="javascript:mailFormGo('fromlist')">받은 메일함 <span>(${numArr[0]})</span></a></li>
				<li><a href="javascript:mailFormGo('tolist')">보낸 메일함 <span>(${numArr[1]})</span></a></li>
				<li><a href="javascript:mailFormGo('mylist')">내게 쓴 메일함 <span>(${numArr[2]})</span></a></li>
				<li><a href="javascript:mailFormGo('trashcan')">휴지통 <span>(${numArr[3]})</span></a></li>
			</ul>
		</div>
		<!-- left-menu(E) -->
	</div>
</c:if>
<%-- mail left(E) --%>

<%-- auction left(S) --%>
<c:if test="${sessionScope.model eq 'auction' }">
	<div class="chat-panel panel panel-default left-profile">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
							profile</strong>
					</div>
					<div class="panel-body">
						<!-- profile-img(S) -->
						<span class="chat-img pull-left profile-img"><img
							src="resources/profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
							class="img-circle" style="width: 100px; height: 130px;"> </span>
						<!-- profile-img(E) -->

						<!-- profile-table(S) -->
						<table class="profile-table">
							<colgroup>
								<col style="width: 60px">
								<col>
							</colgroup>
							<tr>
								<th><strong class="primary-font">이름</strong></th>
								<td>${sessionScope.v.memname }</td>
							</tr>
							<tr>
								<th><strong class="primary-font">직급</strong></th>
								<td>${sessionScope.v.memjob }</td>
							</tr>
							<tr>
								<th><strong class="primary-font">부서</strong></th>
								<td>${sessionScope.v.dename }</td>
							</tr>
							<tr>
								<th><strong class="primary-font">상급자</strong></th>
								<td>${sessionScope.v.mgrname }</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2"><a
									href="modifyProfile"
									class="primary-font"><i class="fa fa-cog"></i> 프로필 수정</a></td>
							</tr>
						</table>
						<!-- profile-table(E) -->
					</div>
				</div>
</c:if>
<%-- auction left(E) --%>

