<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#signBody{padding-left: 50px}
</style>
<input type="hidden" id="targetScont" value="${sgvo.scont }">
<input type="hidden" id="targetSreason" value="${sgvo.sreason }">

<form method="post" id="signDetailF">
	<input type="hidden" name="snum" value="${sgvo.snum }">
	<input type="hidden" name="page" value="${page }">
	<c:forEach var="ss" items="${ssList }" varStatus="index">
		<input type="hidden" name="stepnum${index.count }" value="${ss.stepnum }">
	</c:forEach>
	<div class="signDetailDiv" style="text-align:right; margin-right:70px">
		<input type="hidden" id="sgBtn" class="btn btn-default btn" onclick="sgDetail(this)" value="결재">&nbsp;
		<input type="hidden" id="sgReturnBtn" class="btn btn-default btn" onclick="sgDetail(this)" value="반려">&nbsp;
		<input type="hidden" id="sgDocBtn" class="btn btn-default btn" onclick="sgDetail(this)" value="출력">&nbsp;
		<input type="button" id="sgBackBtn" class="btn btn-default btn" onclick="sgDetail(this)" value="목록">&nbsp;
	</div>
	<div class="panel-body"align="center">
	<div class="form-group">
	${sf.sform}
	
	</div>
	
	</div>
	<div id="signCommDiv" style="margin-left: 50px"></div>
	
<!-- Modal(S) -->
	<div class="modal fade" id="signReturnModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">반려</h4>
			</div>
			<div class="modal-body">
	
				<label class="control-label"><i class="fa fa-thumb-tack"></i> Comment</label><br/>
				<textarea class="form-control" rows="3" cols="50" name="sgreturncomm" style="resize:none;"></textarea>

			</div>
			<div class="modal-footer">
				<input class="btn btn-default" type="submit"  value="전송">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal(E) -->
</form>
