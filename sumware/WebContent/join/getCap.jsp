<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
<form method="post">
	<table id="captcha">
		<tr>
			<td>CAPTCHA:</td>
			<td><input id="capPassword" size="16" /></td>
		</tr>
		<tr>
			<td></td>
			<td>
            	 ${capImg }<br>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="button" class="btn btn-default" id="capBtn" onclick="capClick()" value="입력" /></td>
		</tr>
	</table>
	<div id="Captarget"></div>
</form>
</div>