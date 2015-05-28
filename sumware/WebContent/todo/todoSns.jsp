<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>SumWare</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
Bootstrap
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- 모달 -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<!-- 모달 -->
<script src="../js/http.js"></script>
<script>
// push Client 설정 (받는쪽)
console.log("typeof:"+typeof(EventSource));
	var rowsPerPage =7;
	var eventSource;
	var cheight=$('.chat').height()-50;
	function push(){
		if(typeof(EventSource) != "undefined"){
			eventSource = new EventSource("sumware?model=sns&submod=pushSns&sdept=${v.memdept}&page=1&rowsPerPage="+rowsPerPage); // push를 받을수 있는 브라우져인지 판단.
			// EventSource EventListener의 종류
			// onmessage : 서버가 보낸 push메세지가 수신되면 발생
			// onerror : 서버가 보낸 push에서 에러가 발생되었을때
			// onopen : 서버가 연결이 되었을 때 발생
			eventSource.onmessage = function(event){
				$(".chat").html(event.data);
				
			};
// 			eventSource.close();
		}else{
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
	}
	function pageScoll(){
		console.log("1:::"+$('.chat').scrollTop());
		console.log("3:::"+$('.chat').height());
		var sctop=$('.chat').scrollTop();
		if ( sctop > cheight) {
			$("#loading").html("<img src='img/loading.gif' alt='loading'>");
			setTimeout(function(){
				rowsPerPage+=5;
				cheight+=$('.chat').scrollTop();
				sctop
				console.log("rowsPerPage:"+rowsPerPage);
				console.log("cheight:"+cheight);
				eventSource.close();
				$("#loading img").remove();
				push();
				
			}, 1000);	
					
		}else if($('.chat').scrollTop()==0){
			$("#loading").html("<img src='img/loading.gif' alt='loading'>");
			setTimeout(function(){
				rowsPerPage=7;
				cheight=300;
				console.log("rowsPerPage:"+rowsPerPage);
				console.log("cheight:"+cheight);
				eventSource.close();
				$("#loading img").remove();
				push();
				
			}, 1000);
		}
	}
// Ajax로 사용자의 데이터를 보내는 쪽 - 어제와동일!
	$(function(){
			push();
			$('#send').click(function(){
				eventSource.close();
				push();
				$(".chat").scrollTop(0);
				var fdata = {
						model:"sns",
						submod:"insertSns",
						smem:"${v.memnum}",
						sdept:"${v.memdept}",
						scont:$("#btn-input").val()
					};
				$('#btn-input').val("");
				$.ajax({
					type:"POST",
					url:"sumware",
					data:fdata
				});
			});
	});
	function snsComm(snum,p){
		var page=p;
		var data={
			model:"sns",
			submod:"snsComm",
			page:page,
			snum:snum
		};
		$.ajax({
			type:"POST",
			url:"sumware",
			data:data,
			success: function(result){
				alert(result);
				eventSource.close();
				$("#wrap3").html(result);
			}
		});
	}
	function snsInsertComm(snum){
		alert("cocont:"+$('#cocont').val());
		var data={
				model:"sns",
				submod:"snsCommInset",
				comem:"${v.memnum}",
				page:"1",
				commsns:snum,
				cocont:$('#cocont').val()
			};
		$.ajax({
			type:"POST",
			url:"sumware",
			data:data,
			success: function(result){
				$("#wrap3").html(result);
			}
		});
	}
</script>
<style>
	#loading img{float:none; width:40px;}
</style>
</head>
<body>
	<div class="col-lg-4" style="width: 40%">
				<div class="chat-panel panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> <strong
							class="primary-font">부서 SNS</strong>
					</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<ul class='chat' style="height:450px; overflow-y:scroll;" onscroll="pageScoll()">
						</ul>
						<div id="loading" style="width: 100%; float:left; text-align: center;">
					
						</div>
					</div>
					
					<!-- /.panel-body -->
					<div class="panel-footer">
						<div class="input-group">
							<input id="btn-input" type="text" class="form-control input-sm" placeholder="메시지를 입력해주세요">
							<span class="input-group-btn">
								<button class="btn btn-warning btn-sm" id="send">Send</button>
							</span>
						</div>
					</div>
					<!-- /.panel-footer -->
				</div>
				<!-- /.panel .chat-panel -->
			</div>	
			 <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#wrap3">Open Modal</button>	
			<%@include file="snsComm.jsp" %>
</body>
</html>