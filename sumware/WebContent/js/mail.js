/**
 * 
 */

function mailFormGo(res){
		if(res=='write'){ // 메일 쓰기
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailWriteForm"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='fromlist'){ // 받은 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailFromList",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }" },
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='tolist'){ // 보낸 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailToList",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='mylist'){ // 내게 쓴 메일함
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailMyList",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }"},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
		} else if(res=='trashcan'){ // 휴지통
			$.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailTrashcan",
					usernum: "${sessionScope.v.memnum}",
					userid: "${sessionScope.v.meminmail }"
				},
				success: function(result){
					$("#mainContent").html(result);
				}
			});
 		} 
	}
	// 메일-suggest 관련 함수
	
	var lastKey = "";
	var check = false;
	var loopKey = false;
	
	function startSuggest(){
		if(check == false){
			setTimeout("sendKeyword();",500);
			loopKey = true;
		}
		check = true;
	}
	
	function sendKeyword(){
		if(loopKey == false){
			return;
		}
		
		var key = f.toMem.value;
		
		if(key == '' || key == '  '){
			lastKey = '';
			document.getElementById("view").style.display = "none";
		} else if(key != lastKey){
			lastKey = key;
			var param = "key="+encodeURIComponent(key);
			// console.log("key: "+key);
			// 컨트롤러에서 처리하게 고칠 것
			sendRequest("mail/mailSuggest.jsp", param, res, "post");
			/* $.ajax({
				type: "post",
				url: "sumware",
				data: {model: "mail",
					submod: "mailSug",
					key: key}
			}); */
		}
		
		setTimeout("sendKeyword();",500);
	}
	
	var jsonObj = null;
	function res(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				var response = xhr.responseText;
				jsonObj = JSON.parse(response);
				viewTable();
			} else {
				document.getElementById("view").style.display = "none";
				
			}
		}
	}
	
	function viewTable(){
		var vD = document.getElementById("view");
		var htmlTxt = "<table>";
		for(var i=0; i<jsonObj.length; i++){
			htmlTxt += "<tr><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
				+ i + ")'>" + jsonObj[i] +"</td></tr>";
		}
		htmlTxt += "</table>";
		vD.innerHTML = htmlTxt;
		vD.style.display = "block";
	}
	
	function select(index){
		f.toMem.value = jsonObj[index];
		document.getElementById("view").style.display = "none";
		check = false;
		loopKey = false;
	}
