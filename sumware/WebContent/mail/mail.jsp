<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row">
			<%@include file="/contentLeft.jsp" %>
			<!-- 이 부분에 내용이 들어감 -->
			<div class="col-lg-8"><%@include file="mailWrite.jsp"%></div>
		</div>
	</div>
</section>
<script>
	function mailbox() {
		$('#mailbox').submit();
	}

	function mailwrite() {
		$('#mailwrite').submit();
	}
</script>
<%@include file="/footer.jsp"%>