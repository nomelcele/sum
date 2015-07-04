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













