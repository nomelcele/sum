<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<input type="button" value="답장" onclick="javascript:replyFormGo()">
	<input type="button" value="삭제"><br/>
	제목: ${detail.mailtitle}<br/>
	보낸 사람: ${detail.mailsname}<br/>
	받는 사람: ${detail.mailrname}<br/>
	보낸 날짜: ${detail.maildate}<br/>
	내용: ${detail.mailcont}<br/>
	첨부 파일: ${detail.mailfile}
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
				$("#toMem").attr("value","${detail.mailsname}"); // 받는 사람 자동으로
				$("#mailtitle").attr("value","re: ${detail.mailtitle}") // 제목 (re:...) 형태로
			}
		});
	}
</script>
