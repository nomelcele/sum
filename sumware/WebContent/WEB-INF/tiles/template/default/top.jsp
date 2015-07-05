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
				<div class="porm-group">
					<label class="control-label-" for="memnum">사원번호</label> 
					<input type="text" id="memnum" name="memnum" placeholder="사원번호"	onkeydown="enterCheck(3)" />
					<label class="control-label" for="mempwd">비밀번호</label> 
					<input type="password" id="mempwd" name="mempwd" placeholder="비밀번호" onkeydown="enterCheck(3)" />
					<button type="button" class="btn btn-xs btn-info" onclick="loginChk()">로그인</button>
				</div>
			</c:when>
			<c:otherwise>
				<div class="nav navbar-right">
					<form action="goFunc" method="post" id="formff">
						<input type="hidden" name="model" id="model"> 
						<input type="hidden" name="page" id="page"> 
						<input type="hidden" name="bgnum" id="bgnum"> 
						<input type="hidden" name="bname" id="bname"> 
						<input type="hidden" name="bdeptno" id="bdeptno" value="${sessionScope.v.memdept}"> 
						<input type="hidden" name="cal" value="0">
						<input type="hidden" name="bsearch" value="${sessionScope.boardSearch}">
						<input type="hidden" name="div" value="${sessionScope.boardDiv }">
						<!-- navbar-nav(S) -->
						<ul class="nav navbar-nav">
							<li><a href="">Main</a></li>
							<li><a href="">Todo</a></li>
							<li><a href="">Mail</a></li>
							<li><a href="">Calendar</a>
							<li><a href="">Board</a></li>
							<li><a href="">Messenger <span id="countRoomNum"></span></a></li>
							<li><a href="">Acount</a></li>
						<c:if test="${sessionScope.v.memdept eq 100 and sessionScope.v.memauth lt 4 }">
							<li><a href="">Admin</a></li>
						</c:if>
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
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">보안문자</h4>
				</div>
				<div class="modal-body" id="capBody">
					<!-- comment-write(E) -->
				</div>
			</div>
		</div>
	</div>
</nav>


