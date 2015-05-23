<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="top.jsp"%>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	function mesgoUrl(){
		$('#mod').attr("value","messenger")
		$('#submod').attr("value","messengerChat")
// 		$('#tomemNum').attr("value","10000")
		$('#frommemNum').attr("value","${sessionScope.v.memnum}")
		$('#mesform').submit();

	}
</script>


<!-- 사용자 정보(사진, 이름) -->
<div class="container">
	<div class="col-lg-3">		
		<div class="media">
			<div class="media-left media-middle">
			
		<form action="sumware" method="post" id="mesform">
			<input type="hidden" id="mod" name="model">
			<input type="hidden" id="submod" name="submod">
<!-- 			<input type="hidden" id="tomemNume" name="tomemNume"> -->
			<input type="hidden" id="frommemNum" name="frommemNum">
		</form>
			
				<!-- 사원 사진 불러오기  -->
				<a href="#"> <img class="media-object" src="${sessionScope.v.memprofile }" alt="...">
				</a>
			</div>
			<div class="media-body">
			
				<!-- 로그인 사원 이름 불러오기 -->
				<a href="#">${sessionScope.v.memname }님</a>
			</div>
		</div>
		
		<!-- 친구 리스트 jstl을 통해 출력화면 -->
		<div class="col-lg-10">
			<div class="list-group">

				<c:forEach var="memList" items="${list}">
				<ul>
					<!-- 회원의 사진을 출력 -->
					
					<li><a href="javascript:mesgoUrl()"> 
					
					
					
					
					<%-- 				<img class="media-object" src="${memList.memprofile }" alt="..." style="width: 10px; height: 10px">				 --%>
						<img src="img/messenger.jpg" alt="..." style="width: 25px; height: 25px"> 
						
						<!-- 친구 list 출력시 본인 아이디와 같은 경우는 출력을 하지 않는 기능 추가 -->

						${memList.memname} <span>(${memList.memnum})</span><span> /
							${memList.dename}</span></a>
				</li>
				</ul>
				</c:forEach>
			</div>
		</div>
	</div>


<!-- 채팅페이지 구현 탭, 채팅창, 입력창 구현-->
	<div class="col-lg-9">
		<div class="col-lg-9">
			<ul class="nav nav-pills" id="mytap">
			
			
				<!-- for문을 사용하여 추가로 생성 될 수 있도록 한다. 
				탭으로 채팅창 생성이 되도록 쿼리문 작성 필요
				-->

				<li role="presentation"><a href="#malja">말자</a></li>
				<li role="presentation"><a href="#gura">구라</a></li>
				<li role="presentation"><a href="#gugi">거지</a></li>
			</ul>

		</div>

		<div class="col-lg-10" style="height: 300px; border: gray solid 1px;" id="malja">
				말자 방입니다.
				<!-- 채팅내용을 입력합니다. -->
		</div>

		
		<!-- 메세지 입력  -->
		<div class="col-lg-10">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="메세지를 입력하세여" />
				<span class="input-group-btn">
					<button class="btn btn-default" type="button">전송</button>
				</span>
			</div>
		</div>
	</div>
</div>

<%@include file="footer.jsp"%>


