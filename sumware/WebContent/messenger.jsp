<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	function mesgoUrl(res){
		var resNum = res;
		var opt="width=700, height=900, scrollbars=yes";
		var f = document.mesform;
		f.model.value="messenger";
		f.submod.value="messengerChat";		
		f.entNum.value = resNum+","+${sessionScope.v.memnum};
		f.fromNum.value = ${sessionScope.v.memnum};
		f.toNum.value = resNum;
		
		f.target="messengerChatroom";
		window.open("","messengerChatroom",opt);
		f.submit();	
	}
	
	
	console.log("typeof:"+typeof(EventSource));	
	if(typeof(EventSource) != "undefined"){
		var eventSource = new EventSource("check.jsp"); // push를 받을수 있는 브라우져인지 판단.
		// EventSource EventListener의 종류
		// onmessage : 서버가 보낸 push메세지가 수신되면 발생
		// onerror : 서버가 보낸 push에서 에러가 발생되었을때
		// onopen : 서버가 연결이 되었을 때 발생
		
		eventSource.onmessage = function(event){
			var edata1 = event.data;
			regoUrl(edata1);
			alert("메세지가 도착했습니다.");			
		};
	}else{
		alert("해당 브라우저는 지원이 안됩니다.")
	}
	
	function regoUrl(edata1){
		var winopt="width=700, height=800, scrollbars=yes"
		var f1 = document.entform;
		var evdata = edata1;
		
		f1.model.value="messenger";
		f1.submod.value="msgReceieve";		
		f1.edata1.value = evdata;
		f1.userNum2.value = ${sessionScope.v.memnum};

		
		f1.target="msgrecRoom";
		window.open("","msgrecRoom",winopt);
		f1.submit();	
	}

	
	
	
	
</script>


<!-- 사용자 정보(사진, 이름) -->
<div class="container">
	<div class="col-lg-3">
	<div id="target">
	</div>
		<div class="media">
			<div class="media-left media-middle">

				<form action="sumware" method="post" id="mesform" name="mesform">
					<input type="hidden" id="mod"    name="model"> 
					<input type="hidden" id="submod" name="submod">
					<input type="hidden" id="fromNum" name="fromNum">
					<input type="hidden" id="toName" name="toNum">
					<input type="hidden" name="entNum">
				</form>
				
				<form action="sumware" method="post" id="entform" name="entform">
					<input type="hidden" id="mod"    name="model"> 
					<input type="hidden" id="submod" name="submod">
					<input type="hidden" id="edata1" name="edata1">
					<input type="hidden" id="userNum2" name="uerNum2">
				</form>

				<!-- 사원 사진 불러오기  -->
				<a href="#"> <img class="media-object" src="${sessionScope.v.memprofile }" alt="..."></a>
			</div>
			<div class="media-body">

				<!-- 로그인 사원 이름 불러오기 -->
				<a href="#">${sessionScope.v.memname }님</a>
			</div>
		</div>

		<!-- 친구 리스트 jstl을 통해 출력화면 -->

		<div class="col-lg-10">
			<div class="list-group">
				<ul>
				<c:forEach var="memList" items="${list}">
					
						<!-- 회원의 사진을 출력 -->

						<li>
							<a href="javascript:mesgoUrl(${memList.memnum})"> 
							<%-- 				<img class="media-object" src="${memList.memprofile }" alt="..." style="width: 10px; height: 10px">				 --%>
								<img src="img/messenger.jpg" alt="..."style="width: 25px; height: 25px"> 
								
								<!-- 친구 list 출력시 본인 아이디와 같은 경우는 출력을 하지 않는 기능 추가 -->

								${memList.memname} <span>(${memList.memnum})</span><span> / ${memList.dename}</span></a></li>
					
				</c:forEach>
				</ul>
			</div>
		</div>
	</div>	
</div>




