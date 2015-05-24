<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<script>
	function formGoGo(res){
		if(res==1){
			$('#mod').attr("value","todo");
			$('#submod').attr("value","todoForm");
			$('#memnum').attr("value","${sessionScope.v.memnum}");
		}else if(res==2){
			$('#mod').attr("value","mail");
			$('#submod').attr("value","mailMain");
		}else if(res==3){
			$('#mod').attr("value","calendar");
			$('#submod').attr("value","calList");
		}else if(res==4){
			$('#mod').attr("value","board");
			$('#submod').attr("value","boardList");
			$('#page').attr("value","1");
		}else if(res==5){
// 			$('#mod').attr("value","messenger");
// 			$('#submod').attr("value","messengerForm");
			openWin();
		}
		$('form').submit();	
		
	}	
	function openWin(){
		var opt= "width=700, height=1000, scrollbars=yes";
		var f = document.frmmain;
		f.model.value="messenger";
		f.submod.value="messengerForm";
		window.open("","MessengerMain",opt);
		f.target="MessengerMain";	
		f.submit();
	}
	
	function checkmsg(toNum){
		var requNum = toNum;
		var userNum = ${sessionScope.v.memnum };
		if(userNum == toNum){
			console.log("두 사람이 같습니다.");
			window.open("main.jsp", "");
		}else{
			console.log("두 사람은 다릅니다.");
			
		}
	}
	
	

</script>
</head>
<body>
	<form action="sumware" method="post" name="frmmain">
		<input type="hidden" id="mod" name="model">
		<input type="hidden" id="submod" name="submod">
		<input type="hidden" id="memnum" name="memnum">
		<input type="hidden" id="page" name="page">
	</form>
	<div>
		${sessionScope.v.memname }님 로그인하셨습니다.
		<ul>
			<li><a href="javaScript:formGoGo(1)">Todo</a></li>
			<li><a href="javaScript:formGoGo(2)">Mail</a></li>
			<li><a href="javaScript:formGoGo(3)">Calendar</a>
			<li><a href="javaScript:formGoGo(4)">Board</a></li>
			<li><a href="javaScript:formGoGo(5)">Messenger</a></li>
		</ul>
	</div>
</body>
</html>
