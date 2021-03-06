<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--  컨트롤러의 데이터에 접근하기 위해 Spring Form 태그 추가 -->
<style>
	/* 유효성 검사를 통과하지 못할 경우 보여질 에러의 스타일 지정 */ 
	.error{
	color:red; font-weight: bold;
	}
</style>
		<div class="col-lg-8">	
		<form:form method="post" action="samailWrite" class="form-horizontal" role="form"
 		commandName="writeForm"	name="f" id="mailWriteF" autocomplete="off" enctype="multipart/form-data">
 			<!-- commandName: input 값들과 매칭될 객체 지정 -->
				    <div class="form-group">
				        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
				        <div class="col-sm-10">
				            <form:input cssClass="form-control" id="mailreceiver" 
				            path="mailreceiver" onkeydown="startSuggest()" value="${mailreceiver }"/>
				            <!-- path: 받아올 property의 이름 -->
				            <div id="view" style="position:absolute; z-index:1; background-color:#ffffff;">
				            </div>
				            <form:errors path="mailreceiver" cssClass="error"/>
				            <!-- 에러 메시지가 나타날 영역 -->
				        </div>
				    </div>
				    <div class="form-group">
				        <label for="title" class="col-sm-2 control-label">제목</label>
				        <div class="col-sm-10">
				            <input class="form-control"  name="mailtitle" id="mailtitle" value="${mailtitle}"/>
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