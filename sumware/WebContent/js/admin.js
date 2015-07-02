/**
 * 
 */

function adminSelectMenu(res){

	if(res == 'addMem'){
		$.ajax({
			type:"POST",
			url:"addMemberForm",
			success: function(result){
				alert("됨됨");
				$('.contents').html(result);
			}
		});
		
	}else if(res == 'addBoard'){
		$.ajax({
			type:"POST",
			url:"addBoardForm",
			success: function(result){
				alert("됨");
				$('.contents').html(result);
			}
		});
	}
	

}