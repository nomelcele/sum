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
			<c:when test="${empty sessionScope.adminv.memnum}">
				<div class="porm-group">
					<label class="control-label-" for="memnum">관리자번호</label> 
					<input type="text" id="adminmemnum" name="memnum" placeholder="관리자번호"	onkeydown="enterCheck(4)" />
					<label class="control-label" for="mempwd">비밀번호</label> 
					<input type="password" id="adminmempwd" name="mempwd" placeholder="비밀번호" onkeydown="enterCheck(4)" />
					<button type="button" class="btn btn-xs btn-info" onclick="adminLogin()">로그인</button>
				</div>
			</c:when>
			<c:otherwise>
				<div class="nav navbar-right">
						<ul class="nav navbar-right navbar-nav user-name">
						<c:if test="${!empty sessionScope.adminv.memname}">
							<li>
								<span class="control-label-"><strong>${sessionScope.adminv.memname}</strong> 님 환영합니다.</span>
							</li>
							<li>
								<button type="button" class="btn btn-xs btn-info" onclick="adminLogout(${sessionScope.adminv.memnum})">로그아웃</button>
							</li>
						</c:if>
						</ul>
<!-- 					</form> -->
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


