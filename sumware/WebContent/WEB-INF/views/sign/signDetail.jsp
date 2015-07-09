<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<form method="post" id="signDetailF">
	<input type="hidden" name="snum" value="${sgvo.snum }">
	<c:forEach var="ss" items="${ssList }" varStatus="index">
		<input type="hidden" name="stepnum${index.count }" value="${ss.stepnum }">
	</c:forEach>
	${sf.sform}
<div class="signDetailDiv">
	<input type="button" class="signDetailDiv btn" onclick="sgDetail(this)" value="결재">&nbsp;
	<input type="button" class="signDetailDiv btn" onclick="sgDetail(this)" value="반려">&nbsp;
	<input type="button" class="signDetailDiv btn" onclick="sgDetail(this)" value="목록">&nbsp;
	
</div>
</form>