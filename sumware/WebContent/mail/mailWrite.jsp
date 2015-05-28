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
	
<!-- ckeditor
<script src="//cdn.ckeditor.com/4.4.7/basic/ckeditor.js"></script>
<script src="../js/myckeditor.js"></script>
<script>
	$(function(){
		mailChkUpload();
	})
</script>
 -->

	<form method="post" action="sumware" class="form-horizontal" role="form"
	name="f" autocomplete="off" enctype="multipart/form-data">
    	<input type="hidden" name= "model" value="mail">
		<input type="hidden" name= "submod" value="mailWrite">
		<input type="hidden" name= "mailmem" value="${sessionScope.v.memnum}">
	    <div class="form-group">
	        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" 
	            id="toMem" name="toMem" onkeydown="startSuggest()">
	            <div id="view">
	            <!--  
	            <c:choose>
	            	<c:when test="${!empty sugArr}">
	            	배열 넘어온 게 있을 때 
	            	viewtable() 함수 변형
		            	<table>
			            	<c:forEach items="${sugArr}" var="sugRes" varStatus="status">
			            		<tr><td style='cursor:pointer;'onmouseover='this.style.background="silver"'
			            		onmouseout='this.style.background="white"' 
			            		onclick='select(${sugArr})'>${sugArr }</td></tr>
			            	</c:forEach>
		            	</table>
	            	</c:when>
	            	<c:otherwise>
	            		view의 display 속성을 none으로 설정
	            	</c:otherwise>
	            </c:choose>
	            -->
	            </div>
	        </div>
	    </div>
	    <div class="form-group">
	        <label for="title" class="col-sm-2 control-label">제목</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" id="mailtitle" name="mailtitle" >
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
	            <! Will be used to display an alert to the user>
	        </div>
	    </div>
	</form>
