<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="top2.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row">
			<div class="col-md-2">
				<div>
					<a href="javascript:mailwrite()" class="btn btn-sm btn-info"> <span
						class="glyphicon glyphicon-pencil"></span> 메일쓰기
					</a>
				</div>
				<div class="list-group">
					<a href="javascript:mailbox()" class="list-group-item">받은 메일함 </a>
					<a href="#" class="list-group-item">보낸 메일함</a> <a href="#"
						class="list-group-item">내게 쓴 메일함</a> <a href="#"
						class="list-group-item">휴지통</a>
				</div>
			</div>
			<!-- 이 부분에 내용이 들어감 -->
			<div class="col-lg-8"><%@include file="mail/mailWrite.jsp"%></div>
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
<%@include file="footer.jsp"%>