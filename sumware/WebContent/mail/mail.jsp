<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/top.jsp"%>
<section id="features" class="features2">
	<div class="container">
		<div class="row">
			<%@include file="/contentLeft.jsp" %>
			<!-- 이 부분에 내용이 들어감 -->
			<div class="col-lg-8" id="mainContent"></div>
		</div>
	</div>
</section>
 
<script>
	var xhr = null;
	function getXMLHttpRequest() {
		if (window.ActiveXObject) {
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else {
			xhr = new XMLHttpRequest();
		}
	}
	
	function sendRequest(url, param, callback, method) {
		// get/post 방식 결정
		getXMLHttpRequest();
		method = (method.toLowerCase() == 'get') ? 'GET' : 'POST';
		param = (param == null || param == '') ? null : param;
		if (method == 'GET' && param != null) {
			url = url + '?' + param;
		}
		xhr.onreadystatechange = callback;
		xhr.open(method, url, true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.send(method == 'POST' ? param : null);
	}
</script>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
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

<script> 
	// 
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
			// console.log("key: "+key);
			// 컨트롤러에서 처리하게 고칠 것
			sendRequest("mail/mailSuggest.jsp", param, res, "post");
			/* $.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailSug",
					key: key}
			}); */
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
<script>
	function mailFormGo(res){
		if(res==1){ // 메일 쓰기
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailWriteForm"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res==2){ // 받은 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailFromList",
					userid: "${sessionScope.v.meminmail }" },
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res==3){ // 보낸 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailToList",
					usernum: "${sessionScope.v.memnum}"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res==4){ // 내게 쓴 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailMyList",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res==5){ // 휴지통
			
		} 
		
	}
	
</script>
<%@include file="/footer.jsp"%>