<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<div class="row" style="height:400px;">
			<div class="col-lg-8" id="mainContent">
			<form method="post" action="samailWriteForm" id="detailform">
				<input type="hidden"  name="model" value="mail">
				<input type="hidden" name="mailreceiver" id="mailreceiver" value="${detail.mailsname} <${detail.replyid}@sumware.com>">
				<input type="hidden" name="mailtitle" id="mailtitle" value="RE: ${detail.mailtitle}">
				<input type="hidden" name="orimail" id="orimail"
				value="<br/><br/><p>-----Original Message-----</p>
				<p>From: ${detail.mailsname} &lt;${detail.replyid}@sumware.com&gt;</p>
				<p>To: ${detail.mailrname} &lt;${detail.mailreceiver}@sumware.com&gt;</p>
				<p>Sent: ${detail.maildate}</p>
				<p>Subject: ${detail.mailtitle}</p>
				<p>${detail.mailcont}</p>">
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
					<a href="sadownloadFile?fileName=${detail.mailfile}">${detail.mailfile}</a>
				</div>
				</form>
			</div>			
		</div>