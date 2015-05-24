<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%request.getAttribute("toNum");
	System.out.println("받는 사람 사번입니다. : "+request.getAttribute("toNum"));
%>

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
	
	function loadData(){
		/* 읽어만 오기에 param은 null */
		sendRequest("check.jsp", null, res, "get");
	}
	function res(){
		if(xhr.readyState == 4 && xhr.status == 200){
			document.getElementById("target").innerHTML=xhr.responseText;
		}
	}
	var inter = setInterval(function(){
		loadData();
	
	}, 3000);
	
	
	
	
</script>


<!-- 사용자 정보(사진, 이름) -->
<div class="container">
	<div class="col-lg-3">
		<div class="media">
			<div class="media-left media-middle">

				<form action="sumware" method="post" id="mesform" name="mesform">
					<input type="hidden" id="mod"    name="model"> 
					<input type="hidden" id="submod" name="submod">
					<input type="hidden" id="fromNum" name="fromNum">
					<input type="hidden" id="toName" name="toNum">
					<input type="hidden" name="entNum">

					
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




