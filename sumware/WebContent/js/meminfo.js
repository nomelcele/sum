/**
 * 
 */
// Left 메뉴
function memInfoSelectMenu(res, data) {
	if (res == 'modifyProfile') {
		$.ajax({
			url : "samodifyProfileMenu",
			type : "post",
			success : function(result) {
				$('.contents').html(result);
			}
		});
	} else if (res == 'payInfo') {
		$.ajax({
			type : "post",
			url : "samemPayInfoDetail",
			data : {
				memnum : data
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
	} else if (res == 'memLoginHistory') {
		$.ajax({
			type : "post",
			url : "samemLoginHistory",
			data : {
				lomem : data,
				page : 1
			},
			success : function(result) {
				$('.contents').html(result);
			}
		});
	}
}

// 급여 조회에서 년도 바꾸면 수행
function memchangeyear(memnum) {
	$.ajax({
		type : "POST",
		url : "samemPayInfoDetail",
		data : {
			memnum : memnum,
			hisdate : $('#hisdate').val()
		},
		success : function(result) {
			$('.contents').html(result);
		}
	});
}
