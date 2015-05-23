<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row">
			<%@include file="/contentLeft.jsp" %>
			<!-- 이 부분에 내용이 들어감 -->
			<div class="col-lg-8" id="mainContent"></div>
		</div>
	</div>
</section>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
	function frommailbox() {
		$.ajax({
			type: "post",
			url: "sumware?model=mail&submod=mailFromList",
			data: {userid: "${sessionScope.v.meminmail }" },
			success: function(result){
				$("#mainContent").html(result);
			}
		});
	}
	
	function tomailbox(){ // 안됨
		$.ajax({
			type: "post",
			url: "sumware?model=mail&submod=mailToList",
			data: {usernum: "${sessionScope.v.memnum}"},
			success: function(result){
				$("#mainContent").html(result);
			}
		});
	}

	function mailwrite() {
		$.ajax({
			type: "post",
			url: "sumware?model=mail&submod=mailWriteForm",
			success: function(result){
				$("#mainContent").html(result);
			}
		});
	}
</script>
<%@include file="/footer.jsp"%>