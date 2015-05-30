<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row" style="height:400px;">
			<%@include file="/contentLeft.jsp"%>
			<div class="col-lg-8" id="mainContent">
			<form method="post" action="sumware" id="detailform">
				<input type="hidden"  name="model" value="mail">
				<input type="hidden" name="submod" value="mailWriteForm">
				<input type="hidden" name="usernum" value="${sessionScope.v.memnum}">
				<input type="hidden" name="userid" value="${sessionScope.v.meminmail}">
				<input type="hidden" name="toMem" value="${detail.mailsname} <${detail.replyid}@sumware.com>">
				<input type="hidden" name="mailtitle" value="RE: ${detail.mailtitle}">
				<div id="mailDetailContent">
					<input type="submit" class="btn btn-default btn-sm" value="답장"><br />
					<div style="padding-top:10px;">
						<span style="font-size:16px; font-weight:bold;">${detail.mailtitle}</span>
						<span style="float:right;"><i class="fa fa-envelope"></i> ${detail.maildate}</span> 
						<br /> 
						보낸 사람: ${detail.mailsname} &lt;${detail.replyid}@sumware.com&gt;<br /> 
						받는 사람: ${detail.mailrname} &lt;${detail.mailreceiver}@sumware.com&gt;<br /> 
					</div>
					<hr/>
					${detail.mailcont}<br /> 
					<hr/>
					<span style="font-weight:bold;"><i class="fa fa-paperclip"></i> 첨부 파일 </span>
					<a href="upload/${detail.mailfile}" target="_blank">${detail.mailfile}</a>
				</div>
				</form>
			</div>			
			</div>
		</div>
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


