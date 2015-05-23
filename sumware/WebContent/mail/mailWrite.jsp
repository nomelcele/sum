<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<script src="../js/http.js"></script>
<script src="../js/json2.js"></script>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script>
	var lastKey = "";
	var check = false;
	var loopKey = false;
	
	function startSuggest(){
		if(check == false){
			setTimeout("sendKeyword();",500);
			loopKey = true;
		}
		check = true;
	}
	
	function sendKeyword(){
		if(loopKey == false){
			return;
		}
		
		var key = f.toMem.value;
		
		if(key == '' || key == '  '){
			lastKey = '';
			document.getElementById("view").style.display = "none";
		} else if(key != lastKey){
			lastKey = key;
			var param = "key="+encodeURIComponent(key);
			console.log("aaaaaaaaaaaaa"+key);
			// 컨트롤러에서 처리하게 고칠 것
			// **********************
			// **********************
			// **********************
			// **********************
			// **********************
			sendRequest("mailSuggest.jsp", param, res, "post");
			
			// sendRequest(url, param, callback, method)
			
		}
		
		setTimeout("sendKeyword();",500);
	}
	
	var jsonObj = null;
	function res(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				var response = xhr.responseText;
				jsonObj = JSON.parse(response);
				viewTable();
			} else {
				document.getElementById("view").style.display = "none";
				
			}
		}
	}
	
	function viewTable(){
		var vD = document.getElementById("view");
		var htmlTxt = "<table>";
		for(var i=0; i<jsonObj.length; i++){
			htmlTxt += "<tr><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
				+ i + ")'>" + jsonObj[i] + "</td></tr>";
		}
		htmlTxt += "</table>";
		vD.innerHTML = htmlTxt;
		vD.style.display = "block";
	}
	
	function select(index){
		f.toMem.value = jsonObj[index];
		document.getElementById("view").style.display = "none";
		check = false;
		loopKey = false;
	}
</script>


<script src="//cdn.ckeditor.com/4.4.7/basic/ckeditor.js"></script>
<script src="../js/myckeditor.js"></script>
<script>
	$(function(){
		mailChkUpload();
	})
</script>



</head>
<body>
	<form method="post" action="sumware" class="form-horizontal" role="form"
	name="f" autocomplete="off">
    	<input type="hidden" name= "model" value="mail">
		<input type="hidden" name= "submod" value="mailWrite">
		<input type="hidden" name= "fromMem" value="${sessionScope.v.memnum}">
	    <div class="form-group">
	        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" 
	            id="toMem" name="toMem" onkeydown="startSuggest();">
	            <div id="view"></div>
	        </div>
	    </div>
	    <div class="form-group">
	        <label for="title" class="col-sm-2 control-label">제목</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" id="title" name="title" >
	        </div>
	    </div>
	    <div class="form-group">
	        <label for="content" class="col-sm-2 control-label">내용</label>
	        <div class="col-sm-10">
	            <textarea class="form-control" rows="4" name="content" id="content" ></textarea>
	        </div>
	    </div>
	    <div class="form-group">
	        <div class="col-sm-10 col-sm-offset-2">
	            <input id="submit" name="submit" type="submit" value="전송" class="btn btn-primary">
	        </div>
	    </div>
	    <div class="form-group">
	        <div class="col-sm-10 col-sm-offset-2">
	            <! Will be used to display an alert to the user>
	        </div>
	    </div>
	</form>	
</body>
</html>