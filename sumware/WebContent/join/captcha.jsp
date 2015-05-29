<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://www.casternet.com/spamfree/common.js"></script>
<script>
window.onload = function() { document.getElementById("zsfCode").focus(); }
//공백 제거
function _trim ( str ) { return str.replace(/(^\s*)|(\s*$)/g, ""); }

	// AJAX Start
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
	function grabFile ( file, func ) {
		var req = getHTTPObject ();
		if ( req ) {
			req.onreadystatechange = function () { eval(func+"(req)"); };
			req.open ( "GET", file, true );
			req.send(null);
		}
	}
	function axOk ( req ) {	if ( req.readyState==4 && (req.status==200 || req.status==304) ) { return true; } else { return false; } }
	// AJAX End

	// 설정에 따라 스팸방지이미지 변경
	function changeImgConfig() {
		var img_size = document.getElementById("img_size").value;
		var img_distortion = document.getElementById("img_distortion").checked ? "D" : "";
		var qKind = document.getElementById("qKind").value ? "&q_kind="+document.getElementById("qKind").value : "";
		var cfg = img_size[0]!="0" ? "&cfg=zsfCfg_"+img_size + img_distortion + qKind : "";
		document.getElementById("zsfImg").src="zmSpamFree/zmSpamFree.php?re"+cfg+"&zsfimg="+new Date().getTime();
	}
	// AJAX를 이용한 스팸방지코드 검증
	function checkZsfCode(obj) {
		var zsfCode = _trim(obj.value);
		if ( zsfCode.length > 0 ) {
		grabFile ( "zmSpamFree/zmSpamFree.php?zsfCode="+zsfCode, "resultZsfCode" );
		}
	}
	function resultZsfCode(req) {
		if ( axOk(req) ) {
			var ret = req.responseText*1;
			document.getElementById("zsfCodeResult").value = ret;
			if ( !ret ) { changeImgConfig(); }
		}
	}

	function checkZsfFrm() {
		var zsfCode = _trim(document.getElementById("zsfCode").value);
		if ( !zsfCode ) { alert ("스팸방지코드(Captcha Code)를 입력해 주세요."); document.getElementById("zsfCode").select(); return false; }
		var memo_nick = _trim(document.getElementById("memo_nick").value);
		if ( !memo_nick ) { alert ("별명(Nick)을 입력해 주세요."); document.getElementById("memo_nick").select(); return false; }
		var memo = _trim(document.getElementById("memo_txt").value);
		if ( !memo ) { alert ("코멘트(Comment)를 입력해 주세요."); document.getElementById("memo_txt").select(); return false; }
		if ( document.getElementById("memo_txt").value.length > 140 ) {
			alert ("코멘트(Comment) 길이를 140자 이내로 맞춰 주세요.");
			document.getElementById("memo_txt").focus();
			return false;
		}
			if ( document.getElementById("zsfCodeResult").value*1 < 1 ) {
			alert ("스팸방지코드(Captcha Code)가 틀렸습니다. 다시 입력해 주세요.");
			changeImgConfig();
			document.getElementById("zsfCode").value="";
			document.getElementById("zsfCode").focus();
			return false;
		}
	}
	/* textarea의 문자 수 세기 시작 (2009-11-20) */
	var tmr = null;	// TiMeR
	preVal = 140;	// 이전 글자수 값
	function calcLen() {
		var obj = document.getElementById("memo_len");	// textarea 객체
		var remain = 140-document.getElementById("memo_txt").value.length;	// 140에서 현재 글자수 뺀 값
		if ( preVal != remain ) {	// 이전 글자수 값과 현재 글자수 값이 다를 경우
			obj.innerHTML = remain;	// 현재 글자수 값 출력
			if ( remain < 0 )	{ obj.style.color = "#dd0000"; }
						else	{ obj.style.color = "#ffffff"; }
			preVal = remain;	// 현재 글자수 값을 이전 값에 대입
		}
		tmr = window.setTimeout('calcLen()',100);	// 0.1초에 한 번씩 반복
	}
	function stopCalcLen() {
		clearTimeout(tmr);
		tmr = null;
	}
	/* textarea의 문자 수 세기 끝 */
//]]>
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