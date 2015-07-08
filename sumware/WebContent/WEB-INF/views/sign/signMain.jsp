<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="writeSign" method="post">
	<div id="signWrap">
		<div id="signTop">
			<div id="signDocNum">
				문서 번호: <input id="formnum" name="formnum" value="1" readonly="readonly">
			</div>
			<div id="signImg" style="text-align: center;">
				<table>
					<tr>
						<td style="border: 1px solid;">김명준</td>
						<td style="border: 1px solid;">김주상</td>
						<td style="border: 1px solid;">홍명표</td>
						<td style="border: 1px solid;">김성호</td>
					</tr>
					<tr>
						<td>
							<div id="signImg1" style="width: 80px; height: 80px;">
							</div>
						</td>
						<td>
							<div id="signImg2" style="width: 80px; height: 80px;">
							</div>
						</td>
						<td>
							<div id="signImg3" style="width: 80px; height: 80px;">
							</div>
						</td>
						<td>
							<div id="signImg4" style="width: 80px; height: 80px;">
							</div>
						</td>
					</tr>		
				</table>
			</div>
		</div>
		<div id="signBody">
			<table>
				<tr>
					<td>
						기안자: <input type="text" id="sgwriter" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>
						기안일: <input type="date" id="startdate" name="startdate"> ~ <input type="date" id="enddate" name="enddate">
					</td>
				</tr>
				<tr>
					<td style="text-align: center;"><input type="text" id="stitle" name="stitle" placeholder="Title"></td>
				</tr>
				<tr>
					<td><textarea rows="20" cols="110" id="scont" name="scont"></textarea></td>
				</tr>
				<tr>
					<td>
						<input type="submit" id="signWriteBtn" value="작성">
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>