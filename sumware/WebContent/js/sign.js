/**
 * SignJS
 */
var size="";
var memnum="";
var signimg={};
function signFormListModal() {
	$.ajax({
		type : "POST",
		url : "getSignFormList",
		success : function(result) {
			$("#signModalBody").html(result);
			$("#signModal").toggle();
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}
function addSignDiv(){
	var argslen = arguments.length;
	switch(argslen){
	case 3:
		addSign3(arguments[0],arguments[1],arguments[2]);
		break;
	case 4:
		addSign4(arguments[0],arguments[1],arguments[2],arguments[3]);
		break;
	}
}
function addSign3(mgrs,names,status){
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
	for(var m=1; m<=size; m++){
		if(status[m]=='y'){
			sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'><img src='' id='targetSignImg"+mgrs[m]+"' draggable='false'	ondragstart='signDrag(event)' width='79' height='79'></div></td>";
		}else{
			if(memnum==mgrs[m]){
				sgHtml+="<td><div  ondrop='signDrop(event)' ondragover='signAllowDrop(event)' id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
			}else{
				sgHtml+="<td><div id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
			}
		}
	}
	sgHtml+="</tr></table>";
	console.log(sgHtml);
	$('#signImg').html(sgHtml);
	
	if($('#sgImg'+mgrs[i]).val()=='y'){
		$('#targetImg'+msgrs[i]).src(signimg);
	}
}
function addSign4(mgrs,names,memnum,memdept){
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
		sgHtml+="<td><div  ondrop='signDrop(event)' ondragover='signAllowDrop(event)' id='signImg"+m+"' style='width: 80px; height: 80px;'></div></td>";
	}
	sgHtml+="</tr></table>";
	console.log(sgHtml);
	$('#signImg').html(sgHtml);
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
		}else{
			console.log("엘스문 들어옴");
			document.getElementsByName("sgImg"+i)[0].value="n";
		}
	}
}
function sgDetail(res){
	if(res.value=='결재'){
		$("#signDetailF").attr("action","confirm");
		$("#signDetailF").submit();
	}else if(res.value=='반려'){
		
	}else{
		location='getSignList';
	}
}