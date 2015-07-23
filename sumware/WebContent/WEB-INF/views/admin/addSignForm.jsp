<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-lg-3">
<div class="chat-panel panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-plus-square-o"></i> <strong class="primary-font">
			문서 양식 추가</strong>
	</div>
	<div class="panel-body">
		<div class="form-group">
			<label class="control-label">선택사항</label> 
			<p><label class="checkbox-inline"> <input type="checkbox" onchange ="javascript:checkAllElement()" id="checkAll" value="전체선택"> 전체선택 </label> 
			<p><label class="checkbox-inline"> <input type="checkbox" name="check" onchange ="javascript:manageForm('writerchk')" id="writerchk" value="기안자"> 기안자 </label> 
<!-- 			<p><label class="checkbox-inline"> <input type="checkbox" name="check"  onchange ="javascript:manageForm('stendatechk')" id="stendatechk" value="기안일"> 기안일 </label>  -->
			<p><label class="checkbox-inline"> <input type="checkbox" name="check"  onchange ="javascript:manageForm('stitlechk')" id="stitlechk" value="제목"> 제목 </label>
			<p><label class="checkbox-inline"> <input type="checkbox" name="check" onchange ="javascript:manageForm('sdatechk')" id="sdatechk" value="일시"> 일시 </label>
			<p><label class="checkbox-inline"> <input type="checkbox" name="check"  onchange ="javascript:manageForm('splacechk')" id="splacechk" value="장소"> 장소 </label>
			<p><label class="checkbox-inline"> <input type="checkbox" name="check"  onchange ="javascript:manageForm('scontchk')" id="scontchk" value="내용"> 내용 </label>
			<p><label class="checkbox-inline"> <input type="checkbox" name="check"  onchange ="javascript:manageForm('sreasonchk')" id="sreasonchk" value="사유"> 사유 </label> 
			<p><label class="checkbox-inline"> <input type="checkbox" name="check"  onchange ="javascript:manageForm('sps')" id="sps" value="특이사항"> 특이사항 </label>
		</div>
		<div class="form-group">
			<label class="control-label">양식 이름</label> 
			<input type="text" class="form-control"  id="sfname" placeholder="양식 이름 입력">
		</div>
		
		<div class="form-group">
			<input type="button" class="btn btn-outline btn-default" onclick="javascript: addForm()" value="추 가">
		</div>
	</div>
</div>
</div>
<div class="col-lg-8">
<div class="chat-panel panel panel-default">
	<div class="panel-heading">
		<i class="fa fa-table"></i> <strong class="primary-font">미리보기</strong>
	</div>
	<div class="panel-body"align="center">
		<div class="form-group" >
			<div id="completeForm">
			<div id="signWrap" style="border: solid;">
				<div id="signTop">
					<p>
					<div id="signDocNum" align="left">
						No : <input id="formnum" name="formnum" readonly="readonly">
					</div>
					<div id="signImg" style="text-align: center;"></div>
				</div><p>
				<div id="signBody" >
					<table>
						<tr>
							<td id="sgwriterTarget">
							</td>
						</tr>
						<tr>
							<td>
								기안일: <input type='date' id='startdate' name='startdate'> ~ <input type='date' id='enddate' name='enddate'>
							</td>
						</tr>
						<tr>
							<td id="stitleTarget" style="text-align: center;"></td>
						</tr>
						<tr>
						<td id="sdateTarget">
						</td>
						</tr>
						<tr>
							<td id="splaceTarget">
							</td>
						</tr>
						<tr id="scontTarget"></tr>
						<tr>
							<td id="sreasonTarget">
							</td>
						</tr>
						<tr>
							<td id="spsTarget">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>


