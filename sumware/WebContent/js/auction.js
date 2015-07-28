/**
 * Auction - javascript function 
 */

$(function(){
	// productList.jsp 에서 상품등록 버튼 누르면 작동 되는 메소드.
	$('#auctionBtn1 #productWrite').click(function(){
		$.ajax({
			url : "sawriteForm",
			type : "post",
			success : function(result){
				$('#mTarget').html(result);
				$('#proRegister').modal('toggle');
			}
		});
	});
	$("#auctionPaging a").click(function(e){
		e.preventDefault();
		var $page = $(this).text();
		$("#auctionPaging form #propage").attr("value",$page);
		$("#productList").submit();
	});
});

// 상품 목록 클릭시(이미지를 클릭하면 작동)
function detailGo(no){
	location='saproDetail?pronum='+no;
}

// promodal.jsp 에서 사용 파일 업로드시 미리보기 시켜주는 메소드.
function preview(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			$('#imgTarget').html("<img id='imgt' src='' style='width:250px;'>");
			$('#imgt').attr('src',e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

// 상품등록 모달에서 완료 버튼 클릭시 (Done)
function doneClick(){
	// 입력 받은 값이 호가에 나누어 떨어지는 경우에만 서브밋.
		$('#doneForm').submit();
		$('#proRegister').modal('toggle');
}


// 입찰 하기 버튼 눌렀을 때 동작.(proDetail.jsp)
function bidBtn(){
	$.ajax({
		url:"saproBid",
		type : "post",
		success:function(res){
			$('#bidTarget').html(res);
			$('#bidModal').modal('toggle');
		}
	});
}

// 입찰 버튼 눌렀을 때 동작.(promodal.jsp)
function bidExe(step,min,nowget){
	var $nowget = parseInt(nowget.replace(/(^\s*)|(\s*$)|,/g, ''),10);
	var $bidprice = parseInt($('#bidprice').val(),10);
	var $bidstep = parseInt(step.replace(/(^\s*)|(\s*$)|,/g, ''),10);
	// 받은값으로 검증 해야됨.
	if($bidprice <= min ){
		alert("현재 가격 보다 높은 금액을 입력하십시오.");
	}else if(($bidprice-min)%$bidstep != 0){
		alert("호가에 의거하여 입력 하십시오.")
	}else if($bidprice >= $nowget){
		nowgetBtn(nowget);
	}else{
		$('#bidForm').submit();
		$('#bidModal').modal('toggle');
	}
}

//String 을 int 형으로 변환 해주는 함수(promodal.jsp 에서 #bidprice 가 onchange 일때.)
function parseIntMethod(data){
	var $numberData = data.replace(/(^\s*)|(\s*$)|,/g, ''); // trim, 콤마 제거
	$('#bidprice').attr('step',$numberData);
}

// 입찰정보 버튼 눌렀을 때 동작.(productList.jsp)
// bidpronum : 상품번호를 가지고.. 컨트롤러로 가서 입찰정보를 불러올 것임.
function bidInformation(bidpronum){
	$.ajax({
		url:"bidInfo",
		data : {bidpronum:bidpronum},
		type:"post",
		success:function(result){
			$('#bidTarget').html(result);
			$('#bidInfoModal').modal('toggle');
		}
	});
}

// 즉시구매 버튼 눌렀을 경우에 작동.(promodal.jsp)
function nowgetBtn(nowget){
	var $nowget = nowget.replace(/(^\s*)|(\s*$)|,/g, '');
	$('#bidprice').attr('value',$nowget);
	$('#bidForm').submit();
	$('#bidModal').modal('toggle');
}





