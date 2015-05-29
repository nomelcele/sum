<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messenger Main</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
</head> 
<script>
	// 사원 list 출력 시 채팅창으로 이동
	function mesgoUrl(res){
		var resNum = res;
		var opt="width=500, height=600, scrollbars=no";
		var f = document.mesform;
		f.model.value="messenger";
		f.submod.value="messengerChat";		
		f.entNum.value = resNum+","+"${sessionScope.v.memnum}";
		f.fromNum.value = "${sessionScope.v.memnum}";
		f.toNum.value = resNum;
		
		f.target="messengerChatroom";
		window.open("","messengerChatroom",opt);
		f.submit();	
	};
	
	// 사원 list를 push를 사용하여 출력 하자 ~~~ 
	if(typeof(EventSource) != "undefined"){		
		var eventSourceList = new EventSource("messenger/listLoad.jsp");
		eventSourceList.onmessage = function(event){
			$('#msgList').html(event.data);	
		};
	}else{
		alert("해당 브라우저는 지원이 안됩니다.");
	} 
	
	
	console.log("typeof:"+typeof(EventSource));	
	if(typeof(EventSource) != "undefined"){
		var eventSource = new EventSource("messenger/check.jsp");
		
		eventSource.onmessage = function(event){
			var edata1 = event.data;
			alert("메세지가 도착했습니다.");
			// 도착한 push data를 가공
			var dArr = event.data.split("/");
			for(var i in dArr){
				console.log("푸쉬로 넘어온 data : "+dArr[i]);
			}
			var mesendNum = dArr[3];
			var mesendName = dArr[4];
			regoUrl(edata1, mesendName);			
		};
	}else{
		alert("해당 브라우저는 지원이 안됩니다.")
	};
	
	function regoUrl(edata1, mesendName){
		
		var message = mesendName+"님의 대화가 요청되었습니다. 수락하시겠습니까?";
		var resMessage = confirm(message);
		var f1 = document.entform;
		var evdata = edata1;
		
		if(resMessage == true){
			alert("대화를 수락하였습니다.");
			var winopt="width=500, height=600, scrollbars=no";
			f1.model.value="messenger";
			f1.submod.value="msgReceieve";		
			f1.edata1.value = evdata; // 방번호, IP, 유저사번
			f1.userNum2.value = "${sessionScope.v.memnum}";
					
			f1.target="msgrecRoom";
			window.open("","msgrecRoom",winopt);
			f1.submit();
			
		} else if(resMessage == false){
			alert("대화요청을 거부하였습니다.");
			var f2 = document.disform;
			var winopt1="width=10, height=10, scrollbars=no, menubar=no";
			
			f2.model.value="messenger";
			f2.submod.value="refuseChat";
			f2.edata1.value = evdata; // 방번호, IP, 유저사번
			f2.uerNum2.value = "${sessionScope.v.memnum}";
			f2.stateMain.value = "mesMain";	
			f2.target="msgrefuse";
			
			window.open("","msgrefuse",winopt1);
			f2.submit();

		} else{
			alert("해당사항이 없습니다.");
			return;
		};
	};
	
</script>
<body>
	<form action="sumware" method="post" id="mesform" name="mesform">
		<input type="hidden" id="mod"    name="model"> 
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="fromNum" name="fromNum">
		<input type="hidden" id="toName" name="toNum">
		<input type="hidden" name="entNum">
	</form>
				
	<form action="sumware" method="post" id="entform" name="entform">
		<input type="hidden" id="model" name="model"> 
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="edata1" name="edata1">
		<input type="hidden" id="userNum2" name="uerNum2">
	</form>
				
	<form action="sumware" method="post" id="disform" name="disform">
		<input type="hidden" id="model1" name="model"> 
		<input type="hidden" id="submod99" name="submod">
		<input type="hidden" id="edata2" name="edata1">
		<input type="hidden" id="userNum3" name="uerNum2">
		<input type="hidden" id="stateMain" name="stateMain">
	</form>
	<div class="col-lg-3" style="width: 100%">
		<div class="panel panel-default">
			<div class="panel-heading">
				<strong class="primary-font">Messenger</strong>
			</div>
			<div class="panel-body">
				<table class="table table-condensed table-hover">
				
				<!-- 사용자 정보 출력 -->
					<thead>
					<tr class="active">
						<td>
							<img src="profileImg/${sessionScope.v.memprofile }" alt="" class="img-circle" style="width: 50px; height: 50px;">
							<strong class="primary-font">${sessionScope.v.memname }님</strong>						
						</td>						
					</tr>	
					</thead>
					
					<!-- 참여자 정보 출력 -->
					
					<tbody id = "msgList">
					<!-- push의 반복문 수정-->					
					<tr>
						<td>
							<img src='vo에서 profile 출력' alt='' class='img-circle' style='width: 50px; height: 50px;'>
							<a href='javascript:mesgoUrl(${memList.memnum})' class='primary-font'>
								<strong class='primary-font'>김성호</strong> 
								<strong class='primary-font'>사번</strong> 
								<strong class='primary-font'>부서이름</strong> 
							</a>
						</td>						
					</tr>
					<!-- 여기까지 반복문 -->
					
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!-- target은 메세지 거부 시 거부 메세지 송출 담당 -->
	<div id="target"></div>

</body>
</html>

