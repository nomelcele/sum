<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	var size="";
	$(function(){
		var mgrs={};
		"<c:forEach var='sm' items='${signMgrs }' varStatus='index'>"
		mgrs['${index.count}']='${sm}';
		size='${index.count}';
		"</c:forEach>"
		var names={};
		"<c:forEach var='sn' items='${sgNames }' varStatus='index'>"
		names['${index.count}']='${sn}';
		"</c:forEach>"
		$('#sgwriter').val("${sessionScope.v.memname}");
		addSign(mgrs,names,"${sessionScope.v.memnum}");
	});
	function addSign(mgrs,names,memnum){
		$('#signImg').html("");
		var sgHtml="";
		for(var h=1; h<=size; h++){
			sgHtml+="<input type='hidden' name='sgMgr"+h+"'value='"+mgrs[h]+"'>";
			sgHtml+="<input type='hidden' id='sgImg"+h+"' name='sgImg"+h+"'value='n'/>";
		}
		sgHtml+="<input type='hidden' name='sgwriter' value='"+memnum+"'>";
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
		var setImg="<img src='"+targetSrc+"' id='targetSignImg' draggable='false'	ondragstart='signDrag(event)' width='79' height='79'>"
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
				document.getElementById("sgImg"+i).value="y";
			}else{
				console.log("엘스문 들어옴");
				document.getElementById("sgImg"+i).value="n";
			}
		}
	}
 
</script>
${sf.sform}