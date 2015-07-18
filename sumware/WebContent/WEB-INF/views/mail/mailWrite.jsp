<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.error{
	color:red; font-weight: bold;
	}
</style>
		<div class="col-lg-8">	
		<form:form method="post" action="samailWrite" class="form-horizontal" role="form"
 		commandName="mailForm"	name="f" id="mailWriteF" autocomplete="off" enctype="multipart/form-data">
				    <div class="form-group">
				        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
				        <div class="col-sm-10">
				            <input type="text" class="form-control" id="mailreceiver" 
				            name="mailreceiver" onkeydown="startSuggest()" value="${mailreceiver }"/>
				            <form:errors path="mailreceiver" cssClass="error"/>
				            <div id="view" style="position:absolute; z-index:1;">
				            </div>
				        </div>
				    </div>
				    <div class="form-group">
				        <label for="title" class="col-sm-2 control-label">제목</label>
				        <div class="col-sm-10">
				            <input  class="form-control"  name="mailtitle" id="mailtitle" value="${mailtitle}"/>
				        	<form:errors path="mailtitle" cssClass="error"/>
				        </div>
				    </div>
				    <div class="form-group">
				        <label for="content" class="col-sm-2 control-label">내용</label>
				        <div class="col-sm-10">
				            <textarea class="form-control" rows="13" name="mailcont" id="mailcont" style="resize:none;">${orimail}</textarea>
				        </div>
				    </div>
				      <div class="form-group">
				        <label for="content" class="col-sm-2 control-label">첨부 파일</label>
				        <div class="col-sm-10">
				            <input type="file" class="form-control" name="mailfile" id="mailfile" >
				        </div>
				    </div>
				    <div class="form-group">
				        <div class="col-sm-10 col-sm-offset-2">
				            <input type="button" value="전송" class="btn btn-sm btn-info" id="sendBtn" onclick="mailSendFunc()">
				        </div>
				    </div>
				    <div class="form-group">
				        <div class="col-sm-10 col-sm-offset-2">
				        </div>
				    </div>
			</form:form>
		</div>