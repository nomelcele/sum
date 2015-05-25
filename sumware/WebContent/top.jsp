<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SumWare</title>
<!-- CSS 라이브러리(S)  -->
<link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<link href="css/main.css" rel="stylesheet"/>
<link href="css/boardList.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="css/common.css" />
<!-- CSS 라이브러리(E)  -->
<!-- 자바스크립트 -->
<script src="js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
	function formGo(res){
		$('#model').attr("value", "board");
		if(res == 'insert'){
			$('#submod').attr('value','boardInsert');
			$('#page').attr('value','1');
		}else if(res == 'list'){
			$('#submod').attr('value','boardList');
			$('#page').attr('value','1');
		}else if(res == 'update'){
			$('#submod').attr("value","boardUpdate");
		}else if(res == 'write'){
			$('#submod').attr("value", "writeForm");
		}
		$('form').submit();
	}
	function todoFormGo(res){
		$('#model').attr("value","todo");
		if(res==1){
			$('#submod').attr("value","fWMana");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			$('#goTodo').submit();
		}else if(res==2){
			$('#submod').attr("value","addtodoForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			console.log("memnum",$('#memnum').val());
			$('#goTodo').submit();
		}else if(res==3){
			// 팀장업무관리에서 승인버튼
			$('#okForm').submit();
		}else if(res==4){
			// 팀장업무관리에서 거절버튼
			$('#rejectForm').submit();
		}else if(res==5){
			// 팀장일때 팀장관리 버튼
			$('#submod').attr("value","checkTodoList");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			$('#goTodo').submit();
		}else if(res==6){
			//부장의 업무 추가 폼 작성 후 보내기버튼
			$('#addTodoForm').submit();
			alert("업무를 등록하였습니다.");
		}else if(res==7){
			// 부서의 업무리스트를 쭉 뽑아주는 버튼
			$('#submod').attr("value","deptList");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			$('#memdept').attr("value","${sessionScope.v.memdept}");
			$('#goTodo').submit();
		}else if(res==8){
			// 팀장이 사원들에게 업무를 부여하기 위한 폼
			$('#submod').attr("value","giveJobForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
			
			$('#goTodo').submit();
		}
	}
</script>
</head>

<nav class="navbar navbar">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#body"><img src="img/sum.png"
				alt="SumWare"></a> <a class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse"> <span
				class="glyphicon glyphicon-chevron-down"></span>
			</a>
		</div>
		<div class="nav navbar-right">
			<ul class="nav navbar-nav">
				<li><a href="#">메인</a></li>
				<li><a href="#">내정보</a></li>
				<li><a href="javascript:todoFormGo(7)">ToDo</a></li>
				<li><a href="#">메일</a></li>
				<li><a href="#">게시판</a></li>
			</ul>
			<ul class="nav navbar-right navbar-nav">
				<li><a href="#"><i class="fa fa-check fa-lg"></i>로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>