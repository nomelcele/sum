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
<script src="js/http.js"></script>
<script src="js/json2.js"></script>
<script>
	var lastKey = "";
	var check = false;
	var loopKey = false;

	// 보낼 사람 입력할 때 실행
	function startSuggest() {
		if (check == false) {
			setTimeout("sendKeyword();", 500);
			loopKey = true;
		}
	}
</script>
</head>
<body>
	<form method="post" action="sumware" class="form-horizontal" role="form">
    	<input type="hidden" name= "mod" value="mail">
		<input type="hidden" name= "submod" value="mailWrite">
		<input type="hidden" name= "fromMem" value="${sessionScope.v.memnum}">
	    <div class="form-group">
	        <label for="receiver" class="col-sm-2 control-label">받는 사람</label>
	        <div class="col-sm-10">
	            <input type="text" class="form-control" id="toMem" name="toMem">
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