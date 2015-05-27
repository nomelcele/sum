<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row">
			<%@include file="/contentLeft.jsp" %>
			<div class="col-lg-8" id="mainContent">
				메일 전송이 완료되었습니다.<br/>
				<input type="button" value="메일 쓰기" onclick="javascript:mailFormGo('write')">	
				<input type="button" value="받은 메일함" onclick="javascript:mailFormGo('fromlist')">
			</div>
		</div>
	</div>
</section>
<%@include file="/footer.jsp"%>