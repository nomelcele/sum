<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${param.model eq 'board' }">

</c:if>


<div class="col-lg-1" style="width: 250px">
	<div class="row-lg-1">
		<div class="chat-panel panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
					profile</strong>
			</div>
			<div class="panel-body">
				<span class="chat-img pull-left"> <img
					src="../profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
					class="img-circle" style="width: 100px; height: 100px;">
				</span> </br> </br> </br> </br> </br>
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
				<a href="javascript:todoFormGo(1)" class="list-group-item">업무관리
					</button> </br>
			</c:if>
			<c:if test="${sessionScope.v.memauth lt 4 }">
				<a href="javascript:todoFormGo(2)" class="list-group-item">업무추가</a>
				</br>
			</c:if>
		</div>
	</div>
</div>

