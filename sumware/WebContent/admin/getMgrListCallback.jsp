<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<label class="control-label">담당자(팀)</label>
<select name="newmgr" class="form-control" id="newmgr" style="width: 120px">
		<option value="">팀장 선택</option>
	<c:forEach var="mgrlist" items="${mgrList }">
		<option value="${mgrlist.memnum }">${mgrlist.memname }</option>
	</c:forEach>
</select>