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
				<!--       		<form class="form-inline" role="form" action="sumware" method="post"> -->
				<div class="porm-group">
					<label class="control-label-" for="memnum">사원번호</label> <input
						type="text" id="memnum" name="memnum" placeholder="사원번호"
						onkeydown="enterCheck(3)"> <label class="control-label"
						for="mempwd">비밀번호</label> <input type="password" id="mempwd"
						name="mempwd" placeholder="비밀번호" onkeydown="enterCheck(3)">
					<button type="button" class="btn btn-xs btn-info"
						onclick="loginChk()">로그인</button>
				</div>
				<!--       		</form> -->
			</c:when>
			<c:otherwise>
				<!-- 		   	<div class="porm-group"> -->
				<!-- 		    </div> -->
				<div class="nav navbar-right">
					<ul class="nav navbar-nav">
						<li><a href="home">Main</a></li>
						<li><a href="firsttodoForm?model=todo">Todo</a></li>
						<li><a
							href="sumware?model=mail&submod=mailFromList&usernum=${sessionScope.v.memnum}&userid=${sessionScope.v.meminmail}&page=1">Mail</a></li>
						<li><a href="calList">Calendar</a> <%-- 					<li><a href="sumware?model=board&submod=boardList&page=1&bdeptno=${sessionScope.v.memdept}&bgnum=0&bname=공지사항">Board</a></li> --%>
						<li><a href="boardList">Board</a></li>
						<li><a href="javascript:openWin()">Messenger <span
								id="countRoomNum"></span></a></li>
						<c:if
							test="${sessionScope.v.memdept eq 100 and sessionScope.v.memauth lt 4 }">
							<li><a href="sumware?model=join&submod=addMemberForm">Admin</a></li>
						</c:if>
					</ul>
					<ul class="nav navbar-right navbar-nav user-name">
						<c:if test="${empty sessionScope.v.memname}">
							<li><span class="control-label-"> <strong>${sessionScope.memnum}</strong>
									님 환영합니다.
							</span></li>
							<li><a href="javascript:logout(${sessionScope.memnum})"><i
									class="fa fa-check fa-lg"></i>로그아웃</a></li>
						</c:if>
						<c:if test="${!empty sessionScope.v.memname}">
							<li><span class="control-label-"> <strong>${sessionScope.v.memname}</strong>
									님 환영합니다.
							</span></li>
							<li><a href="javascript:logout(${sessionScope.v.memnum})"><i
									class="fa fa-check fa-lg"></i>로그아웃</a></li>
						</c:if>

					</ul>
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