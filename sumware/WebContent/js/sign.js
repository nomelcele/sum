/**
 * SignJS
 */
var size="";
var memnum="";
var signimg={};
$(function(){
	
});
function addSignDiv(){
	// 메서드의 Overloading 기능을 구현하기 위해
	// 인자값의 갯수에 따라 구분
	var argslen = arguments.length;
	switch(argslen){
	// 인자값이 3개인 경우
	case 3:
		var mgrs=arguments[0];
		var names=arguments[1];
		var memdept=arguments[2];
		
		$('#signImg').html("");
		var sgHtml="";
		for(var h=1; h<=size; h++){
			sgHtml+="<input type='hidden' name='sgMgr"+h+"'value='"+mgrs[h]+"'>";
			sgHtml+="<input type='hidden' id='sgImg"+mgrs[h]+"' name='sgImg"+h+"'value='n'/>";
		}
		sgHtml+="<input type='hidden' name='sgwriter' value='"+memnum+"'>";
		sgHtml+="<input type='hidden' name='sgdept' value='"+memdept+"'>";
		sgHtml+="<table><tr>";
		for(var n=1; n<=size; n++){
			sgHtml+="<td style='border: 1px solid;'>"+names[n]+"</td>";
		}
		sgHtml=sgHtml+"</tr><tr>";
		for(var m=1; m<=size; m++){
			sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
		}
		sgHtml+="</tr></table>";
		console.log(sgHtml);
		$('#signImg').html(sgHtml);
		for(var index=0; index<id.length; index++){
			if($('#'+id[index]).length<=0){
				sgHtml+="<input type='hidden' name='"+id[index]+"'>";
			}
		}
		if($("#scont").length<=0){
			sgHtml+="<input type='hidden' name='scont'>";
		}
		if($('#sreason').length<=0){
			sgHtml+="<input type='hidden' name='sreason'>";
		}
		$('#signImg').html(sgHtml);
		break;
		
	// 인자값이 5개인 경우
	case 6:
		var mgrs=arguments[0];
		var names=arguments[1];
		var status=arguments[2];
		var signimg=arguments[3];
		var sgreturn=arguments[4];
		var expired=arguments[5];
		
		$('#signImg').html("");
		var sgHtml="";
		for(var h=1; h<=size; h++){
			sgHtml+="<input type='hidden' name='sgMgr"+h+"'value='"+mgrs[h]+"'>";
			sgHtml+="<input type='hidden' id='sgImg"+mgrs[h]+"' name='sgImg"+h+"'value='"+status[h]+"'/>";
		}
		sgHtml+="<table><tr>";
		for(var n=1; n<=size; n++){
			sgHtml+="<td style='border: 1px solid;'>"+names[n]+"</td>";
		}
		sgHtml=sgHtml+"</tr><tr>";
		var exflag=false;
		for(var m=1; m<=size; m++){
			//sgreturn 값이 1이면 반려 된상태 expired값이 1이면 진행중 상태
			if(sgreturn=='0'&&expired=="1"){
				if(status[m]=='y'){
					sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'><img src='resources/signImg/"+signimg[m]+"' id='targetSignImg"+mgrs[m]+"' draggable='false'	ondragstart='signDrag(event)' width='79' height='79'></div></td>";
				}else{
					if(memnum==mgrs[m]){
						if(status[m+1]=='y'||status[m+1]==undefined){
							sgHtml+="<td><div ondrop='signDrop(event)' ondragover='signAllowDrop(event)' id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
						}else{
							sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
						}
						
						$('#sgReturnBtn').attr("type","button");
						$('#sgDocBtn').attr("type","hidden");
					}else{
						sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
						$('#sgDocBtn').attr("type","hidden");
					}
				}
			}else{
				if(status[m]=='y'){
					sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'><img src='resources/signImg/"+signimg[m]+"' id='targetSignImg"+mgrs[m]+"' draggable='false'	ondragstart='signDrag(event)' width='79' height='79'></div></td>";
				}else{
					sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
					$('#sgDocBtn').attr("type","hidden");
					exflag=true;
				}
			}
		}
		
		if(expired=="0"&&sgreturn=='0'&&exflag){
			alert("기안일이 지난 문서입니다!!!");
		}
		
		sgHtml+="</tr></table>";
		console.log(sgHtml);
		$('#signImg').html(sgHtml);
		for(var index=0; index<id.length; index++){
			if($('#'+id[index]).length>0){
				$("#"+id[index]).attr("readonly","readonly");
			}
		}		
		break;
	}
}
function signAllowDrop(ev){
	ev.preventDefault();
}
function signDrag(ev){
	
	ev.dataTransfer.setData("targetId",ev.target.id);
}
function signDrop(ev){
	ev.preventDefault();
	var data = ev.dataTransfer.getData("targetId");
	var x =document.getElementById(data);
	var targetSrc=document.getElementById(data).getAttribute("src");
	console.log("src::"+targetSrc);
	var setImg="<img src='"+targetSrc+"' id='targetSignImg' draggable='false'	ondragstart='signDrag(event)' width='79' height='79'>";
	console.log(setImg);
	ev.target.appendChild(document.getElementById(data));
	
	var targetId=ev.target.getAttribute("id");
	setTargetValue(targetId);
	$('#mySignDiv').html(setImg);
}
function setTargetValue(targetId){
	for(var i=1; i<= size; i++){
		if(("signImg"+i)==targetId){
			console.log("이프문 들어옴");
			document.getElementsByName("sgImg"+i)[0].value="y";
			$('#sgReturnBtn').attr("type","hidden");
			$('#sgBtn').attr("type","button");
		}
	}
}
function sgDetail(res){
	if(res.value=='결재'){
		$("#signDetailF").attr("action","saconfirm");
		$("#signDetailF").submit();
	}else if(res.value=='반려'){
		$("#signDetailF").attr("action","sasignReturn");
		$("#signReturnModal").modal('toggle');
	}else if(res.value=='출력'){
		$("#signDetailF").attr("action","sagetDoc");
		$("#signDetailF").submit();
	}else{
		location='sagetSignList?page=1';
	}
}
function setSignValue(id,val){
	$("#"+id).val(val);
}
function signMenu(res){
	if(res=="signWrite"){
		signFormListModal();
	}else if(res=="signAll"){
		signFormList("0");
	}else if(res=="signReceive"){
		signFormList("1");
	}else if(res=="signStandBy"){
		signFormList("2");
	}else if(res=="signComplete"){
		signFormList("3");
	}else if(res=="signReturn"){
		signFormList("4");
	}
	
}
function signFormListModal() {
	$.ajax({
		type : "POST",
		url : "sagetSignFormList",
		success : function(result) {
			$("#signModalBody").html(result);
			$("#signModal").modal('toggle');
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}
function signFormList(div) {
	location="sagetSignList?signdiv="+div+"&page=1";
}

function searchSignList(res){
	if(res.value=="검색"){
		$("#except").val("0");
	}else if(res.value=="제외"){
		$("#except").val("1");
	}else if(res.value=="오늘"){
		$("#selectDay").val("today");
	}else if(res.value=="7일"){
		$("#selectDay").val("week");
	}else if(res.value=="3개월"){
		$("#selectDay").val("month");
	}
	$('#searchSignForm').submit();
}

function searchReset(){
	$("#searchStartDay").val("");
	$("#searchEndDay").val("");
	$("#searchType").val("0");
	$("#searchName").val("");
	$("#searchDocDiv").val("0");
	$("#searchDocState").val("0");
	$("#searchDept").val("0");
	
}