<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="global" class="wrap-layout board">
	<div id="lnb-area" class="lnb-area">
		<!-- left menu !!!! 들어갈 자리 -->
	</div>
	<div class="contents">
				<div class="col-lg-8" id="mailContent" style="text-align:center; padding:30px;">
					<span>메일 전송이 완료되었습니다.</span><br/><br/>
					<input type="button" class="btn btn-default btn-sm" value="메일 쓰기" onclick="javascript:mailFormGo('write')">	
					<input type="button" class="btn btn-default btn-sm" value="받은 메일함" onclick="javascript:mailFormGo('fromlist')">
				</div>
	</div>
</div>
