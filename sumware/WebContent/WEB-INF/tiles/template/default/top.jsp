<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="home"><img
				src="resources/img/sum.png" alt="SumWare"></a> <a
				class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse"> <span
				class="glyphicon glyphicon-chevron-down"></span>
			</a>
		</div>
		
		<c:choose>
			<c:when test="${empty sessionScope.v.memnum && empty memnum}">
			<form action="<c:url value='/j_spring_security_check'/>" method="POST" id="loginF">
				<div class="porm-group">
					<label class="control-label-" for="memnum">사원번호</label> 
					<input type="text" id="memnum" name="memnum" placeholder="사원번호"	onkeydown="enterCheck(3)" />
					<label class="control-label" for="mempwd">비밀번호</label> 
					<input type="password" id="mempwd" name="mempwd" placeholder="비밀번호" onkeydown="enterCheck(3)" />
					<button type="button" class="btn btn-xs btn-info" onclick="loginChk()">로그인</button>
					&nbsp; <a href="#" data-toggle="modal" data-target="#findPW" style="display:inline"><i class="fa fa-search"></i> pw</a>
				</div>
			</form>
			</c:when>
			<c:otherwise>
				<div class="nav navbar-right">
					<form action="goFunc" method="post" id="formff">
						<input type="hidden" name="model" id="model"> 
						<input type="hidden" name="page" id="page" value="1"> 
						<input type="hidden" name="bgnum" id="bgnum"> 
						<input type="hidden" name="bname" id="bname"> 
						<input type="hidden" name="bdeptno" id="bdeptno" value="${sessionScope.v.memdept}"> 
						<input type="hidden" name="cal" value="0">
						<input type="hidden" name="bsearch" value="">
						<input type="hidden" name="div" value="">
						<input type="hidden" name="searchType" value="0">
						<!-- navbar-nav(S) -->
						<ul class="nav navbar-nav">
<!-- 							<li><a href="">Main</a></li> -->
							<li><a href="#">Todo</a></li>
							<li><a href="#">Mail</a></li>
							<li><a href="#">Calendar</a>
							<li><a href="#">Board</a></li>
							<li><a href="#">MSG <span id="countRoomNum"></span></a></li>
							<li><a href="#">Sign</a></li>
							<li><a href="#">Auction</a></li>
							<li><a href="#">Chart</a></li>
							<li><a href="#">Conf</a></li>
						</ul>
						<!-- navbar-nav(E) -->
						<ul class="nav navbar-right navbar-nav user-name">
						<c:if test="${empty sessionScope.v.memname}">
							<li>
								<span class="control-label-"><strong>${sessionScope.memnum}</strong> 님 환영합니다.</span>
							</li>
							<li>
								<button type="button" class="btn btn-xs btn-info" onclick="logout(${sessionScope.memnum})">로그아웃</button>
							</li>
						</c:if>
						<c:if test="${!empty sessionScope.v.memname}">
							<li>
								<span class="control-label-"><strong>${sessionScope.v.memname}</strong> 님 환영합니다.</span>
							</li>
							<li>
								<button type="button" class="btn btn-xs btn-info" onclick="logout(${sessionScope.v.memnum})">로그아웃</button>
							</li>
						</c:if>
						</ul>
					</form>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<!-- 보안문자 모달. -->
	<button type="button" class="modal fade" id="capBtn"
		data-toggle="modal" data-target="#capModal"></button>
	<div class='modal fade' id='capModal'>
	<form action="#">
		<div class="modal-dialog" style="height: 750px; margin-top:0px">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">보안문자</h4>
				</div>
				<div class="modal-body" id="capBody">
					<!-- comment-write(E) -->
				</div>
			</div>
		</div>
	</form>
	</div>
</nav>



<!-- Modal (S) 비밀 번호 찾기 -->
<div class="modal fade" id="findPW" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h3 class="modal-title" id="myModalLabel">비밀번호 찾기</h3>
			</div>
			<div class="modal-body">
<!--  -->			
				<div class="tabbable" id="findpwTarget">
					<div class="tab-content">

						<div class="form-group">
							<label class="control-label">사원번호</label> <input type="text"
								id="findpwmemnum" class="form-control" style="width: 170px"
								placeholder="사원 번호">
						</div>
						<div class="form-group">
							<label class="control-label">E-mail</label> <input type="text"
								id="findpwmemmail" class="form-control" style="width: 220px"
								placeholder="ex) abcd@gmail.com">
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary"
							onclick="javascript:findPassWord('sendNumber')">찾기</button>
					</div>
				</div>
<!--  -->				
			</div>
		</div>
	</div>
</div>

<!-- Modal (E) -->


