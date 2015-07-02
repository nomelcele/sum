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
});

function detail(no,bgnum,bname,bdeptno){
	$.ajax({
		url:"boardDetail",
		type :"post",
		data:{
			no:no, bgnum:bgnum, bname:bname, bdeptno:bdeptno
		},
		success : function(result){
			$(".contents").html(result);
		}
	});
}
// boardWrite 에서 사용 되는 메서드.

// 각각의 폼을 전송해주는 메서드
function formGo(where){
	if(where=='list'){
		$('#listForm').submit();
	}else if(where=='write'){
		$('#writeForm').submit();
	}else{
		$('#boardInsert').submit();
	}
}