<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<input type="button" value="답장" onclick="javascript:replyFormGo()">
	<input type="button" value="삭제">
	<input type="button" value="메일함 이동">
	제목: ${detail.mailtitle}<br/>
	보낸 사람: ${sender}<br/>
	보낸 날짜: ${detail.maildate}<br/>
	내용: ${detail.mailcont}<br/>
	첨부 파일:
</div> 
<script>
	function replyFormGo(){ // 답장 쓰기
		$.ajax({
			type: "post",
			url: "sumware",
			data: {model: "mail",
				submod: "mailWriteForm"},
			success: function(result){
				$("#mainContent").html(result);
				$("#toMem").attr("value","${sender}"); // 받는 사람 자동으로
				$("#title").attr("value","re: ${detail.mailtitle}") // 제목 (re:...) 형태로
			}
		});
	}
</script>