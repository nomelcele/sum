<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
<form method="post" action="sumware" id="detailform">
	<input type="hidden"  name="model" value="mail">
	<input type="hidden" name="submod" value="mailWriteForm">
	<input type="hidden" name="toMem" value="${detail.mailsname} <${detail.replyid}@sumware.com>">
	<input type="hidden" name="mailtitle" value="re: ${detail.mailtitle}">

	<div class="container">
		<div class="row">
			<%@include file="/contentLeft.jsp"%>
			<div class="col-lg-8" id="mainContent">
				<div>
					<input type="submit" value="답장"><br />
					제목: ${detail.mailtitle}<br /> 
					보낸 사람: ${detail.mailsname}<br /> 
					받는 사람: ${detail.mailrname}<br /> 
					보낸 날짜: ${detail.maildate}<br /> 
					내용: ${detail.mailcont}<br /> 
					첨부 파일: <a href="upload/${detail.mailfile}" target="_blank">${detail.mailfile}</a>
				</div>
			</div>
		</div>
	</div>
	</form>
</section>
<%@include file="/footer.jsp"%>



<script>
// 	function replyFormGo() { // 답장 쓰기
		
// // 		$.ajax({
// // 			type : "post",
// // 			url : "sumware",
// // 			data : {
// // 				model : "mail",
// // 				submod : "mailWriteForm"
// // 			},
// // 			success : function(result) {
// // 				$("#mainContent").html(result);
// // 				$("#toMem").attr("value", 
// // 						"${detail.mailsname} <${detail.replyid}@sumware.com>"); // 받는 사람 자동으로
// // 				$("#mailtitle").attr("value", "re: ${detail.mailtitle}") // 제목 (re:...) 형태로
// // 			}
// // 		});
// 	}
</script>


