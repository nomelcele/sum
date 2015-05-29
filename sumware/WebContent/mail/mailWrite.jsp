<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
	#view {
		width: 200px;
		border: 1px solid gray;
		border-top: 0px;
		margin-top: -1px;
		display: none;
		font-family: NanumGothic;
		font-size: 10px;
	}
</style>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row">
			<%@include file="/contentLeft.jsp" %>
			<!-- 이 부분에 내용이 들어감 -->
			<div class="col-lg-8" style="padding:34px;">	

	<form method="post" action="sumware" class="form-horizontal" role="form"
	name="f" autocomplete="off" enctype="multipart/form-data">
    	<input type="hidden" name="model" value="mail">
		<input type="hidden" name="submod" value="mailWrite">
		<input type="hidden" name="usernum" value="${sessionScope.v.memnum}">
		<input type="hidden" name="userid" value="${sessionScope.v.meminmail}">
<%-- 		<input type="hidden" name="mailmem" value="${sessionScope.v.memnum}"> --%>
	    <div class="form-group">
	        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" 
	            id="toMem" name="toMem" onkeydown="startSuggest()" value="${toMem }">
	            <div id="view">
	            </div>
	        </div>
	    </div>
	    <div class="form-group">
	        <label for="title" class="col-sm-2 control-label">제목</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" id="mailtitle" name="mailtitle" value="${mailtitle}">
	        </div>
	    </div>
	    <div class="form-group">
	        <label for="content" class="col-sm-2 control-label">내용</label>
	        <div class="col-sm-10">
	            <textarea class="form-control" rows="13" name="mailcont" id="mailcont"
	            style="resize:none;"></textarea>
	        </div>
	    </div>
	      <div class="form-group">
	        <label for="content" class="col-sm-2 control-label">첨부 파일</label>
	        <div class="col-sm-10">
	            <input type="file" class="form-control" name="attach" id="attach" >
	        </div>
	    </div>
	    <div class="form-group">
	        <div class="col-sm-10 col-sm-offset-2">
	            <input type="submit" value="전송" class="btn btn-sm btn-info" id="sendBtn">
	        </div>
	    </div>
	    <div class="form-group">
	        <div class="col-sm-10 col-sm-offset-2">
	        </div>
	    </div>
	</form>
	</div>
		</div>
	</div>
</section>
<%@include file="/footer.jsp"%>
