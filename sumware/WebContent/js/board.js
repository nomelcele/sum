// 게시판
// boardList 에서 boardDetail 로 넘어 갈때. ----------------------------------
// boardDetail?
/*


*/
$(function(){
	$("#paging a").click(function(e){
		e.preventDefault();
		var $page = $(this).text();
		$("#paging form #page").attr("value",$page);
		$("#plist").submit();
	});
	$("#board-left-menu a").click(function(e){
		e.preventDefault();
		var $bgnum = $(this).next().text();
		var $bname = $(this).text();
		$("#board-left-menu form #bgnum").attr("value",$bgnum);
		$("#board-left-menu form #bname").attr("value",$bname);
		$("#listtt").submit();
		$('#board-left-menu span p').text("");
		$bgnum = "";
	});
});
//게시판 검색(네이버 메일 검색기능 따라하기)
var boardCheck = false;
var boardLoopbSearch = false;
var sBgnum ="";
var sBdeptno ="";
function boardSearch(bgnum,bdeptno){
	sBgnum=bgnum;
	sBdeptno=bdeptno;
	if(boardCheck == false){
		setTimeout("sendSearch()", 500);
		console.log("boardSearch 함수 들어옴");
		boardLoopbSearch = true;
	}
	boardrCheck =true;
}
function sendSearch(){
	if (boardLoopbSearch == false) {
		return;
	}
	var bSearch = $('#bSearch').val();
	var bgnum = $('#bgnum').val();
	var bdeptno = $('#bdeptno').val();
	var lastbSearch = '';
	if (bSearch == '' || bSearch == '  ') {
		document.getElementById("boardView").style.display = "none";
	} else if (bSearch != lastbSearch) {
		lastbSearch = bSearch;
		var param = "bSearch=" + bSearch;
		sendRequest("boardSearchSug", param, SearchRes, "get");
	}

	setTimeout("sendSearch();", 500);
}
var jsonObj = null;
function SearchRes() {
	if (xhr.readyState == 4) {
		if (xhr.status == 200) {
			var response = xhr.responseText;
			jsonObj = JSON.parse(response.trim());
			searchResultView();
		} else {
			document.getElementById("boardView").style.display = "none";

		}
	}
}
function searchResultView() {
	var vD = document.getElementById("boardView");
	var htmlTxt = "<table>";
	for (var i = 0; i < jsonObj.length; i++) {
		htmlTxt += "<tr style='background:white;'><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='bSearchSelect("
			+ i + ")'>" + jsonObj[i] + "</td></tr>";
	console.log(jsonObj[i]);
	}
	htmlTxt += "</table>";
	vD.innerHTML = htmlTxt;
	vD.style.display = "block";
	vD.style.width = "250px";
}
function bSearchSelect(index){
	console.log("클릭했네");
	var select = jsonObj[index];
	var sel=select.split(" ");
	sel1=sel[0];
	sel2=sel[1];
	
	location="boardSearchSelect?bSearch="+sel1+"&div="+sel2+"&bgnum="+sBgnum+"&bdeptno="+sBdeptno;
}
//게시판 검색 종료
function detail(no,bgnum,bname,bdeptno,page){
	$.ajax({
		url:"boardDetail",
		type :"post",
		data:{
			no:no, bgnum:bgnum, bname:bname, bdeptno:bdeptno,page:page
		},
		success : function(result){
			$(".contents").html(result);
		}
	});
}

// 댓글 입력
function commIn(memnum,bnum){
	var $cocont =$("#cocont").val();
	$.ajax({
		url : "commIn",
		type : "post",
		data : {
			cocont:$cocont, comem:memnum, coboard:bnum
		},
		success : function(result){
			$("#coTarget").html(result);
		}
	});
}
// 댓글 삭제
function commDelete(conum,bnum){
	$.ajax({
		url : "commDelete",
		type : "post",
		data : {conum:conum,coboard:bnum},
		success : function(result){
			$("#coTarget").html(result);
		}
	});
}

// 각각의 폼을 전송해주는 메서드
function formGo(where){
	if(where=='list'){
		$('#listForm').submit();
	}else if(where=='write'){
		$('#writeForm').submit();
	}else if(where=='d'){
		$('#dform').submit();
	}else{
		$('#boardInsert').submit();
	}
}













