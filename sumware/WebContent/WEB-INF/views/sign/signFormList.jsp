<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<div id="signFormList">	
		<label class="control-label">결재 문서 선택</label> 
		<select class="form-control" id="formnum" name="formnum" style="width:150px;">
			<option value="">문서 선택</option>
			<c:forEach var="sf" items="${sfList }">
			<option value="${sf.sfnum}">${sf.sfname}</option>
			</c:forEach>
		</select>
	</div>
	<br/>
	<div id="signMgrList">
		<label class="control-label">결재자 선택</label> 
		<select class="form-control"  id ="signMgrs" name="signMgrs" multiple="multiple" style="width:150px">
			<c:forEach var="mgr" items="${mgrList }">
			<option value="${mgr.memnum}">${mgr.memname}</option>
			</c:forEach>
		</select>
	</div>

