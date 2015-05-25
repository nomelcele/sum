<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--  --%>

<c:if test="${param.model eq 'board' }">

</c:if>
<%--  --%>
<c:if test="${param.model eq 'todo' }">

<form action="../sumware" method="post" id="goTodo">
	<input type="hidden" id="model" name="model">
	<input type="hidden" id="submod" name="submod">
	<input type="hidden" id="memnum" name="memnum">
</form>
<div class="col-lg-1" style="width: 250px">
	<div class="row-lg-1">
		<div class="chat-panel panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
					profile</strong>
			</div>
			<div class="panel-body">
				<span class="chat-img pull-left"> <img
					src="profileImg/${sessionScope.v.memprofile }" alt="User Avatar"
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
			<c:if test="${sessionScope.v.memauth lt 4 }">
				<a href="javascript:todoFormGo(1)" class="list-group-item">업무관리</a>
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<a href="javascript:todoFormGo(5)" class="list-group-item">업무관리</a>
			</c:if>
			<c:if test="${sessionScope.v.memauth lt 4 }">
				<a href="javascript:todoFormGo(2)" class="list-group-item">업무부여</a>
			</c:if>
			<c:if test="${sessionScope.v.memauth eq 4 }">
				<a href="javascript:todoFormGo(8)" class="list-group-item">업무부여</a>
			</c:if>
		</div>
	</div>
</div>

</c:if>

<%--  --%>
<c:if test="${param.model eq 'calendar' }">
      <div class="chat-panel panel panel-default">
         <div class="panel-heading">
            <i class="fa fa-comments fa-fw"></i> <strong class="primary-font">My
               profile</strong>
        
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
</c:if>
<%--  --%>
<c:if test="${param.model eq 'mail' }">
	<div class="col-md-2">
				<div>
					<a href="javascript:mailFormGo(1)" class="btn btn-sm btn-info"> <span
						class="glyphicon glyphicon-pencil"></span> 메일 쓰기
					</a>
				</div>
				<div class="list-group">
					<a href="javascript:mailFormGo(2)" class="list-group-item">받은 메일함 </a>
					<a href="javascript:mailFormGo(3)" class="list-group-item">보낸 메일함</a> 
					<a href="javascript:mailFormGo(4)" class="list-group-item">내게 쓴 메일함</a> 
					<a href="javascript:mailFormGo(5)" class="list-group-item">휴지통</a>
				</div>
			</div>
</c:if>
<%--  --%>
<c:if test="${param.model eq 'messenger' }">
<div class="col-lg-2">
		<div class="media">
			<div class="media-left media-middle">
			
				<!-- 사원 사진 불러오기  -->
				<a href="#"> <img class="media-object" src="..." alt="...">
				</a>
			</div>
			<div class="media-body">
			
				<!-- 로그인 사원 이름 불러오기 -->
				<a href="#">${sessionScope.v.memname }님</a>
			</div>
		</div>
		
		<!-- 친구 리스트 jstl을 통해 출력화면 -->

		<div class="list-group">
			<c:forEach var="memList" items="${list}">
				<a href="#" class="list-group-item">${memList.memname}</a>
			</c:forEach>
			
			</table>
		</div>
	</div>

</c:if>




