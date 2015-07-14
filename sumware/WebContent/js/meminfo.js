/**
 * 
 */
// Left 메뉴
function memInfoSelectMenu(res, data) {
	if (res == 'modifyProfile') {
		$.ajax({
			url : "modifyProfileMenu",
			type : "post",
			success : function(result) {
				$('.contents').html(result);
			}
		});
	} else if (res == 'payInfo') {
		$.ajax({
			type : "post",
			url : "memPayInfoDetail",
			data : {
				memnum : data
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
	} else if (res == 'commute') {

	}
}

// 급여 조회에서 년도 바꾸면 수행
function memchangeyear(memnum) {
	$.ajax({
		type : "POST",
		url : "memPayInfoDetail",
		data : {
			memnum : memnum,
			hisdate : $('#hisdate').val()
		},
		success : function(result) {
			$('.contents').html(result);
		}
	});
}
