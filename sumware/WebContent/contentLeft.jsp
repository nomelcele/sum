<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- board left(S) --%>
<c:if test="${param.model eq 'board' }">
<form action="sumware" method="post" id="goTodo">
		<input type="hidden" id="model" name="model">
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="memnum" name="memnum">
		<input type="hidden" id="memmgr" name="memmgr">
		<input type="hidden" id="memdept" name="memdept">
</form>
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
					src="profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
					class="img-circle" style="width: 100px; height: 130px;">
				</span>
				<!-- profile-img(E) -->
				
				<!-- profile-table(S) -->
				<table class="profile-table">
					<colgroup>
					    <col style="width:60px">
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
		<li><a href="sumware?model=board&submod=boardList&bgnum=0&page=1&bdeptno=${sessionScope.v.memdept }&bname=공지사항">공지사항</a></li>
	<c:forEach var="blist" items="${sessionScope.blist }">
		<c:if test="${blist.bgnum eq 0 }">
			<c:remove var="blist"/>
		</c:if>
		<li><a href="sumware?model=board&submod=boardList&bgnum=${blist.bgnum }&page=1&bdeptno=${sessionScope.v.memdept }&bname=${blist.bname }">${blist.bname }</a></li>
	</c:forEach>
	</ul>
</div>
<!-- left-menu(E) -->

</c:if>
<%-- board left(E) --%>

<%-- todo left --%>
<c:if test="${param.model eq 'todo' }">
<!-- <form action="sumware" method="post" id="goTodo"> -->
<!-- 		<input type="hidden" id="model" name="model"> -->
<!-- 		<input type="hidden" id="submod" name="submod"> -->
<!-- 		<input type="hidden" id="memnum" name="memnum"> -->
<!-- 		<input type="hidden" id="memmgr" name="memmgr"> -->
<!-- 		<input type="hidden" id="memdept" name="memdept"> -->
		
<!-- </form> -->
<div class="col-lg-4" style="width: 250px">
<div class="row-lg-6">
		<div class="chat-panel panel panel-default left-profile">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
					profile</strong>
			</div>
			<div class="panel-body">
				<!-- profile-img(S) -->
				<span class="chat-img pull-left profile-img"><img
					src="profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
					class="img-circle" style="width: 100px; height: 130px;">
				</span>
				<!-- profile-img(E) -->
				
				<!-- profile-table(S) -->
				<table class="profile-table">
					<colgroup>
					    <col style="width:60px">
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
				</table>
				<!-- profile-table(E) -->
			</div>
		</div>
	</div>
	<div class="left-menu" id="left-menu">
	<ul>
		<li><a href="javascript:selectMenu('deptTodo')" class="list-group-item">부서 업무</a> </li>
		
			<c:if test="${sessionScope.v.memauth gt 3 }">
				<li><a href="javascript:selectMenu('teamTodoForm')" class="list-group-item">팀 업무</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth lt 4 }">
				<li><a href="javascript:selectMenu('manageJob1')" class="list-group-item">업무관리</a></li>
				
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<li><a href="javascript:selectMenu('manageJob2')" class="list-group-item">업무관리</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth lt 4 }">
				<li><a href="javascript:selectMenu('giveJob1')" class="list-group-item">업무부여</a></li>
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<li><a href="javascript:selectMenu('giveJob2')" class="list-group-item">업무부여</a></li>
			</c:if>
		
	
	</ul>
</div>
</div>



<!-- <div class="col-lg-4" style="width: 250px"> -->
<!-- 	<div class="row-lg-6"> -->
<!-- 		<div class="chat-panel panel panel-default left-profile"> -->
<!-- 			<div class="panel-heading"> -->
<!-- 				<i class="fa fa-user"></i> <strong class="primary-font">My -->
<!-- 					profile</strong> -->
<!-- 			</div> -->
<!-- 			<div class="panel-body"> -->
<!-- 				profile-img(S) -->
<!-- 				<span class="chat-img pull-left profile-img"><img -->
<%-- 					src="profileImg/${sessionScope.v.memprofile }" alt="User Avatar" --%>
<!-- 					class="img-circle" style="width: 82px; height: 110px;"> -->
<!-- 				</span> -->
<!-- 				profile-img(E) -->
				
<!-- 				profile-table(S) -->
<!-- 				<table class="profile-table"> -->
<%-- 					<colgroup> --%>
<%-- 					    <col style="width:60px"> --%>
<%-- 					    <col> --%>
<%-- 					</colgroup> --%>
<!-- 					<tr> -->
<!-- 						<td><strong class="primary-font">이름</strong></td> -->
<%-- 						<td>${sessionScope.v.memname }</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><strong class="primary-font">직급</strong></td> -->
<%-- 						<td>${sessionScope.v.memjob }</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><strong class="primary-font">부서</strong></td> -->
<%-- 						<td>${sessionScope.v.dename }</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td><strong class="primary-font">상급자</strong></td> -->
<%-- 						<td>${sessionScope.v.mgrname }</td> --%>
<!-- 					</tr> -->
<!-- 					<tr><td colspan="2" style="color:white">             .</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td colspan="2" style="text-align:right"><a href="sumware?model=join&submod=modifyProfile"><i class="fa fa-cog"></i>프로필수정</a></td> -->
<!-- 					</tr> -->
<!-- 				</table> -->
<!-- 				profile-table(E) -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="row-lg-6"> -->
<!-- 		<div class="list-group"> -->

<!-- 			<div class="pannel-heading"> -->
<!-- 			<span class="glyphicon glyphicon-pencil"></span> -->
<!-- 			<strong class="primary-font">Todo</strong> -->
<!-- 			</div>  -->
<!-- 				<a href="javascript:selectMenu('deptTodo')" class="list-group-item">부서 업무</a>  -->
<%-- 			<c:if test="${sessionScope.v.memauth gt 3 }"> --%>
<!-- 				<a href="javascript:selectMenu('teamTodoForm')" class="list-group-item">팀 업무</a> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${sessionScope.v.memauth lt 4 }"> --%>
<!-- 				<a href="javascript:selectMenu('manageJob1')" class="list-group-item">업무관리</a> -->
				
<%-- 			</c:if> --%>
<%-- 			<c:if test="${sessionScope.v.memauth eq 4 }"> --%>
<!-- 				<a href="javascript:selectMenu('manageJob2')" class="list-group-item">업무관리</a> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${sessionScope.v.memauth lt 4 }"> --%>
<!-- 				<a href="javascript:selectMenu('giveJob1')" class="list-group-item">업무부여</a> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${sessionScope.v.memauth eq 4 }"> --%>
<!-- 				<a href="javascript:selectMenu('giveJob2')" class="list-group-item">업무부여</a> -->
<%-- 			</c:if> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

</c:if>


<%-- calendar left --%>
<c:if test="${param.model eq 'calendar' }">

	  <form action="sumware" method="post" id="goTodo">
		<input type="hidden" id="model" name="model">
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="memnum" name="memnum">
		<input type="hidden" id="memmgr" name="memmgr">
		<input type="hidden" id="memdept" name="memdept">
</form>
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
					src="profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
					class="img-circle" style="width: 100px; height: 130px;">
				</span>
				<!-- profile-img(E) -->
				
				<!-- profile-table(S) -->
				<table class="profile-table">
					<colgroup>
					    <col style="width:60px">
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
				</table>
				<!-- profile-table(E) -->
			</div>
		</div>
	</div>
</div>
	  <!-- left-profile(E) -->
</c:if>


<%-- mail left --%>
<c:if test="${param.model eq 'mail' }">
<form method="post" action="sumware" id="mailform">
	<input type="hidden" id="model" name="model">
	<input type="hidden" id="submod" name="submod">
	<input type="hidden" id="usernum" name="usernum">
	<input type="hidden" id="userid" name="userid">
	<input type="hidden" id="page" name="page">
</form>

	<div class="col-md-2">
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
					src="profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
					class="img-circle" style="width: 100px; height: 130px;">
				</span>
				<!-- profile-img(E) -->
				
				<!-- profile-table(S) -->
				<table class="profile-table">
					<colgroup>
					    <col style="width:60px">
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
				</table>
				<!-- profile-table(E) -->
			</div>
		</div>
	</div>
</div>
<!-- <hr> -->
		<div>
			<a href="javascript:mailFormGo('write')" class="btn btn-info"> 
			<span class="glyphicon glyphicon-pencil"></span> 메일 쓰기
			</a>
		</div>
		<div class="list-group" id="mailmenu">
			<a href="javascript:mailFormGo('fromlist')" class="list-group-item">받은 메일함 
			<span>(${numArr[0]})</span></a>
			<a href="javascript:mailFormGo('tolist')" class="list-group-item">보낸 메일함 
			<span>(${numArr[1]})</span></a> 
			<a href="javascript:mailFormGo('mylist')" class="list-group-item">내게 쓴 메일함 
			<span>(${numArr[2]})</span></a> 
			<a href="javascript:mailFormGo('trashcan')" class="list-group-item">휴지통 
			<span>(${numArr[3]})</span></a>
		</div>
	</div>
</c:if>




