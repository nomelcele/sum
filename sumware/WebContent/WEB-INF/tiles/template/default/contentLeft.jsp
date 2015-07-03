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
								class="primary-font"><i class="fa fa-cog"></i> 프로필 수정</a></td>
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
	<div class="left-menu" id="left-menu">
	<form action="boardList" method="post" id="listtt">
		<input type="hidden" name="model" value="board">
		<input type="hidden" name="page" value="1">
		<input type="hidden" name="bgnum" id="bgnum" >
		<input type="hidden" name="bdeptno" value="${sessionScope.v.memdept }">
		<input type="hidden" name="bname" id="bname">
	</form>	
		<ul>
			<li><a href="">공지사항</a><span style="display: none;">0</span></li>
			<c:forEach var="blist" items="${sessionScope.blist }">
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
							class="primary-font"><i class="fa fa-cog"></i> 프로필 수정</a></td>

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
			<c:if test="${sessionScope.v.memauth lt 4 }">
				<li><a
					href="javascript:selectMenu('manageJob1',${sessionScope.v.memnum})">업무관리</a></li>

			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<li><a
					href="javascript:selectMenu('manageJob2',${sessionScope.v.memnum})">업무관리</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth lt 4 }">
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

	<form action="sumware" method="post" id="goTodo">
		<input type="hidden" id="model" name="model">
		<input type="hidden" id="submod" name="submod"> 
		<input type="hidden" id="memnum" name="memnum"> 
		<input type="hidden" id="memmgr" name="memmgr">
		<input type="hidden" id="memdept" name="memdept">
	</form>
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
			</table>
			<!-- profile-table(E) -->
		</div>
	</div>
</c:if>
<%-- calendar left(E) --%>


<%-- mail left(S) --%>
<c:if test="${sessionScope.model eq 'mail' }">
	<form method="post" action="sumware" id="mailform">
		<input type="hidden" id="model" name="model">
		<input type="hidden" name="usernum" value="${sessionScope.v.memnum}">
		<input type="hidden" name="userid" value="${sessionScope.v.meminmail}">
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

<!-- 관리자 left -->
<c:if test="${(sessionScope.model eq 'admin')}">
	<div>
		<div class="row-lg-6">
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

	<!-- left-menu(S) -->
	<div class="left-menu" id="left-menu">
		<ul>
			<li><a href="javascript:adminSelectMenu('addMem')">사원 추가</a></li>
			<li><a href="javascript:adminSelectMenu('addBoard')">게시판 추가</a></li>
		</ul>
	</div>
	<!-- left-menu(E) -->

</c:if>



