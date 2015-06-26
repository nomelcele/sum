<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="global" class="wrap-layout board">
	<div id="lnb-area" class="lnb-area">
		<!-- left menu !!!! 들어갈 자리 -->
	</div>
	<div class="contents">
		<div class="row" style="height:400px;">
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
</div>
