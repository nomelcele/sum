<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form action="getSignForm" method="post">
	<div id="signFormList" style="float: left;">	
		<select id="formnum" name="formnum">
			<option value="">문서 선택</option>
			<c:forEach var="sf" items="${sfList }">
			<option value="${sf.sfnum}">${sf.sfname}</option>
			</c:forEach>
		</select>
	</div>
	<div id="signMgrList">
			<select id ="signMgrs" name="signMgrs" multiple="multiple">
				<c:forEach var="mgr" items="${mgrList }">
				<option value="${mgr.memnum}">${mgr.memname}</option>
			</c:forEach>
		</select>
	</div>
	<div>
		<input type="submit" id="signWriteFBtn" value="작성하기">
	</div>
</form>
