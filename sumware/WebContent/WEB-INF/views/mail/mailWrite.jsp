<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="col-lg-8">	
			<form method="post" action="mailWrite" class="form-horizontal" role="form"
				  name="f" id="mailWriteF" autocomplete="off" enctype="multipart/form-data">
				<input type="hidden" name="usernum" value="${sessionScope.v.memnum}">
				<input type="hidden" name="userid" value="${sessionScope.v.meminmail}">
				    <div class="form-group">
				        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
				        <div class="col-sm-10">
				            <input type="text" class="form-control" id="mailreceiver" name="mailreceiver" onkeydown="startSuggest()" value="${mailreceiver }">
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
				            <textarea class="form-control" rows="13" name="mailcont" id="mailcont" style="resize:none;"></textarea>
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
			</form>
		</div>