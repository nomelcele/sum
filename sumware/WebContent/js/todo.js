/**
 * 
 */

function insertJob(tonum) {

	if ($('#memjobName' + tonum).val() == "") {
		alert("사원을 선택해 주세요.");
	} else {
		$.ajax({
			type : "post",
			url : "sainsertMemJob",
			data : {
				jobmemnum : $('#memjobName' + tonum).val(),
				jobtonum : tonum,
				jobcont : $('#jobcont' + tonum).val()
			},
			success : function(result) {
				$("#membersjob" + tonum).html(result);
				$('#jobcont' + tonum).val("");
				alert("업무 지정이 완료되었습니다.");
			}
		});
	}
}

function getDetail(tonum) {

	$("#detail" + tonum).toggle("slow");

	$.ajax({
		type : "post",
		url : "sashowMembersJob",
		data : {
			jobtonum : tonum,
		},
		success : function(result) {
			$("#membersjob" + tonum).html(result);
		}
	});
}

// SNS //////////////////////

function pageScoll() {
	var sctop = $('.chat').scrollTop();
	if (sctop > cheight) {
		$("#loading").html(
				"<img src='resources/img/loading.gif' alt='loading'>");
		setTimeout(function() {
			rowsPerPage += 5;
			cheight += ($('.chat').scrollTop() + 100);
			eventSource.close();
			$("#loading img").remove();
			push();

		}, 1000);

	}
}

function snsSend(memnum, memdept) {
	$(".chat").scrollTop(0);
	var fdata = {
//			smem : "${v.memnum}",
//			sdept : "${v.memdept}",
		smem : memnum,
		sdept : memdept,
		scont : $("#btn-input").val()
	};
	$('#btn-input').val("");
	$.ajax({
		type : "POST",
		url : "sainsertSns",
		data : fdata
	});
}
function snsComm(snum) {
	var rowsPerPage = 10;
	var data = {
		page : "1",
		rowsPerPage : rowsPerPage,
		snum : snum
	};
	$.ajax({
		type : "POST",
		url : "sasnsComm",
		data : data,
		success : function(result) {
			$("#wrapbody").html(result);
			$("#snsCommBtn").click();
			ch = $('#snsCommList').height() - 100;
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}
function snsInsertComm(snum, memnum) {
	var data = {
		comem : memnum,
//		comem : "${v.memnum}",
		page : "1",
		rowsPerPage : pageB,
		snum : snum,
		cocont : $('#cocont').val()
	};
	$.ajax({
		type : "POST",
		url : "sasnsCommInsert",
		data : data,
		success : function(result) {
			$("#wrapbody").html(result);
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}
function snsCommDelete(conum, commsns) {
	var data = {
		page : "1",
		rowsPerPage : pageB,
		snum : commsns,
		conum : conum
	};
	$.ajax({
		type : "POST",
		url : "sasnsCommDelete",
		data : data,
		success : function(result) {
			$("#wrapbody").html(result);
		}
	});

}
function snsCommScroll(snum) {
	var st = $('#snsCommList').scrollTop();
	console.log("st:" + st);
	console.log("ch:" + ch);
	if (st >= ch) {
		$("#commloading").html("<img src='img/loading.gif' alt='loading'>");
		setTimeout(function() {
			ch += $('#snsCommList').height() - 200;
			$("#commloading img").remove();

			pageB += 5;
			var page = pageB;
			var rowsPerPage = pageB;
			var data = {
				page : "1",
				rowsPerPage : rowsPerPage,
				snum : snum
			};
			$.ajax({
				type : "POST",
				url : "sasnsComm",
				data : data,
				success : function(result) {
					$("#wrapbody").html(result);
					$('#snsCommList').scrollTop(st);
				}
			});
		}, 1000);
	}
}
//SNS////////////