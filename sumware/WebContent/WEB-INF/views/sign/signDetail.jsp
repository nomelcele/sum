<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<form method="post" id="signDetailF">
	<input type="hidden" name="snum" value="${sgvo.snum }">
	<c:forEach var="ss" items="${ssList }" varStatus="index">
		<input type="hidden" name="stepnum${index.count }" value="${ss.stepnum }">
	</c:forEach>
	${sf.sform}
	<div id="signCommDiv"></div>
	<div class="signDetailDiv">
		<input type="button" id="sgBtn" class="signDetailDiv btn" onclick="sgDetail(this)" value="결재">&nbsp;
		<input type="hidden" id="sgReturnBtn" class="signDetailDiv btn" onclick="sgDetail(this)" value="반려">&nbsp;
		<input type="button" class="signDetailDiv btn" onclick="sgDetail(this)" value="목록">&nbsp;
	</div>
	<div class='modal' id='signReturnModal' role='dialog'>
		<div class="modal-dialog" style="width: 500px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Comment</h4>
				</div>
				<div class="modal-body" id="signReturnModal" style=" text-align: center;">
					<textarea rows="3" cols="50" name="sgreturncomm" style="resize:none;"></textarea>
				</div>
				<div>
					<input class="btn" type="submit"  value="전송">
				</div>
			</div>
		</div>
	</div>
</form>
