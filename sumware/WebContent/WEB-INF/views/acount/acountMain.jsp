<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<table>
		<tr>
			<td colspan="5"><h2>내가 받은 문서</h2></td>
		</tr>
		<tr>
			<td><input type="button" id="accAll" value="전체(0)"></td>
			<td><input type="button" id="accStandBy" value="결재 대기(0)"></td>
			<td><input type="button" id="accFinish" value="완료 문서(0)"></td>
			<td><input type="button" id="accReceive" value="수신 문서(0)"></td>
			<td><input type="button" id="accRetrun" value="내 반려문서(0)"></td>
		</tr> 
	</table>
	<table>
		<tr>
			<td>문서번호</td>
			<td>문서분류</td>
			<td>제목</td>
			<td>소속</td>
			<td>기안일</td>
			<td>결재일</td>
			<td>문서상태</td>
		</tr>
		<tr>
			<td colspan="7">문서가 존재하지않습니다.</td>
		</tr>
		<tr>
			<td colspan="7"><input type="button" id="accPrint" value="문서 출력"> </td>
		</tr>
	</table>
	
</div>