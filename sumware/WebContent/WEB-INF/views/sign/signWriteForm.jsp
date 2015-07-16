<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#signBody{padding-left: 50px}
</style>	
<form action="sawriteSign" method="post">
	<div class="panel-body" align="center">
		<div class="form-group">${sf.sform}</div>
	</div>
	<div class="signWriteDiv" style="text-align:right; margin-right:70px">
		<input type="submit" class="btn btn-default btn"  value="작성">
	</div>
</form>