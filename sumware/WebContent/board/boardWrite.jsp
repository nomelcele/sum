<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
#content2 {
	width: 100%;
	text-align: center;
}

#content2 #stboardWriter {
	width: 850px;
	margin-left: 100px;
}

#content2 table,tbody td {
	border-collapse: collapse;
	border: 1px solid #7d7d7d;
}

#content2 #stTitle,#stcontent {
	width: 100%;
	margin-top: 30px;
}

#content2 #stTitle tr td {
	height: 40px;
	background-color: #007bbe;
	color: #FFFFFF;
	font-family: "돋움";
	font-size: 25px;
}

#content2 #stcontent thead td {
	height: 30px;
	background-color: #007bbe;
	color: #FFFFFF;
	font-family: "돋움";
	font-size: 15px;
}

#content2 #stcontent tbody td {
	height: 30px;
	background-color: #FFFFFF;
	color: #7d7d7d;
	font-family: "돋움";
	font-size: 15px;
}
/* 스타일에서 클래스를  중복해서 정의하기 위한방법 */
#content2 #stcontent .td {
	text-align: left;
	padding-left: 25px;
}

#content2 #stcontent .title input {
	width: 350px;
}

#content2 #stcontent .instyle {
	background-color: #0099ff;
	height: 30px;
	color: #fff;
	font-weight: bold;
	font-size: 14px;
	font-family: "맑은고딕";
}

#content2 #stcontent .writer input {
	width: 250px;
}
#content2 #stcontent .tel input {
	width: 100px;
}

#content2 #stcontent .content textarea {
	width: 250px;
	height: 300px;
	text-align: left;
}

/*btn*/
#content2 #stcontent .btn {
	width: 120px;
	background-color: #f927a9;
	height: 25px;
	color: #fff;
	font-weight: bold;
	font-size: 14px;
	font-family: "맑은고딕";
}
</style>
<body>
	<div id="content2">
		<div id="stboardWriter">
			<table id="stTitle">
				<tr>
					<td>현재 페이지 : 스터디게시판 작성폼</td>
				</tr>
			</table>
			<form action="sumware" method="post">
				<input type="hidden" name="mod" value="board"> 
				<input type="hidden" name="submod" value="boardInsert">
				<table id="stcontent">
					<tr>
						<td colspan="2">스터디 게시판 작성폼</td>
					</tr>
					<tr>
						<td>제목</td>
						<td class="td title"><input name="btitle" id="btitle"
							class="instyle"></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td class="td writer"><input name="bwriter" id="bwriter" readonly="readonly"
							class="instyle" value="${sessionScope.mvo.memname }"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td class="td content2"><textarea rows="10" cols="30"
								name="bcont" id="bcont" class="instyle"></textarea></td>
						<input type="hidden" name="bgnum" value="1">
						<input type="hidden" name="bmem" value="${sessionScope.mvo.memnum }">
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="글작성" class="btn"
							id="save">&nbsp; <input type="submit" value="list"
							class="btn"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>