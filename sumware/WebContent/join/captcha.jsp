<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
window.onload = function() { 
	document.getElementById("zsfCode").focus();
	}
// 좌우 공백 제거 함수
function _trim ( str ) { 
	return str.replace(/(^\s*)|(\s*$)/g, ""); 
}
/*
	AJAX Start
	여기서부터 "AJAX End"까지는 AJAX 구현을 위해 필수적인 함수들이며,
	각 프로그램마다 각기 조금씩 다른 코드들로 구성되어 있음
*/
// AJAX 구현을 위해 (빌어머글) IE와 타 브라우저간의 작동 동일화
function getHTTPObject () {
	var xhr = false;
	if ( window.XMLHttpRequest ) { xhr = new XMLHttpRequest (); }
	else if ( window.ActiveXObject ) {
		try { xhr = new ActiveXObject ( "Msxml2.XMLHTTP" ); }
		catch ( e ) {
			try { xhr = new ActiveXObject ( "Microsoft.XMLHTTP" ); }
			catch ( e ) { xhr = false; }
		}
	}
	return xhr;
}
// 해당 파일 호출
function grabFile ( file, func ) {
	var req = getHTTPObject ();
	if ( req ) {
		req.onreadystatechange = function () { eval(func+"(req)"); };
		req.open ( "GET", file, true );
		req.send(null);
	}
}
// 파일 호출시 응답의 status중 필요한 status 발생시 return
	function ajaxOk ( req ) {	
	if ( req.readyState==4 && (req.status==200 || req.status==304) ) { 
		return true; 
	} else { 
		return false;
		} 
	}
/*
	AJAX End
*/

// // 스팸방지코드 이미지를 새로운 문제로 바꿈
function changeZsfImg() {
	document.getElementById("zsfImg").src="zmSpamFree/zmSpamFree.php?re&zsfimg="+new Date().getTime();
}

// AJAX를 이용한 스팸방지코드 검사
function checkZsfCode(obj) {
	var zsfCode = _trim(obj.value);	// 입력된 스팸방지코드의 값중 좌우 공백을 뺀 값
	if ( zsfCode.length > 0 ) {	// 스팸방지코드값이 입력된 경우
	grabFile ( "zmSpamFree/zmSpamFree.php?zsfCode="+zsfCode, "resultZsfCode" );	// 스팸방지코드값을 검증하여 결과값을 resultZsfCode 함수로 넘김
	}
}
// 스팸방지코드 검사결과를 hidden 폼에 입력시킴
	function resultZsfCode(req) {
		if ( ajaxOk(req) ) {
			var ret = req.responseText*1;	// AJAX 결과물값을 숫자 데이터로 변환
			document.getElementById("zsfCodeResult").value = ret;	// hidden 폼에 입력
			if ( !ret ) { changeZsfImg(); }	// AJAX 결과물값이 0일 경우 캅차 이미지 바꿈
		}
	}
	function checkFrm() {
		var zsfCode = _trim(document.getElementById("zsfCode").value);	// 스팸방지코드값에서 공백 제거
		if ( !zsfCode ) {	// 스팸방지코드값이 없을 경우
			alert ("스팸방지코드(Captcha Code)를 입력해 주세요.");
			document.getElementById("zsfCode").focus();	// 스팸방지코드 입력폼에 focus
			return false;
		}
		if ( document.getElementById("zsfCodeResult").value*1 < 1 ) {	// 검사결과값이 거짓(0)일 경우
			alert ("스팸방지코드(Captcha Code)가 틀렸습니다. 다시 입력해 주세요.");
			changeZsfImg();	// 캅챠 이미지 새로 바꿈 (생략 가능)
			document.getElementById("zsfCode").value="";	// 스팸방지코드 입력폼 값 제거
			document.getElementById("zsfCode").focus();		// 스팸방지코드 입력폼에 focus
			return false;
		}
	}
</script>
</head>
<body>
	<form method="post" action="" onsubmit="return checkFrm(); ">
	<p class="alignCenter mt10"></p>
	<table class="baduk mt10">
	<colgroup>
		<col width="90" />
		<col width="100" />
		<col width="210" />
	</colgroup>
	<tr>
		<td><img src="http://www.casternet.com/spamfree/zmSpamFree/zmSpamFree.php?zsfimg" alt="여기를 클릭해 주세요." id="zsfImg""/></td>
	</tr>
	<tr>
		<td><input type="text" id="zsfCode" name="zsfCode" onblur="checkZsfCode(this);" /></td>
	</tr>
	<tr>
		<td><input type="text" id="zsfCodeResult" disabled="disabled" /></td>
	</tr>
	</table>
	<p class="alignCenter mt10"><input type="submit" value="확인" /></p>
	</form>
</body>
</html>