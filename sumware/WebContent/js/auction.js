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
	// 종료 일자유무 판단 후 검증 처리.
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
function bidExe(step,min){
	var $bidprice = $('#bidprice').val();
	// 받은값으로 검증 해야됨.
	if($bidprice < min || $bidprice==min){
		alert("현재 가격 보다 높은 금액을 입력하십시오.");
	}else if(($bidprice-min)%step != 0){
		alert("호가에 의거하여 입력 하십시오.")
	}else{
		$('#bidForm').submit();
		$('#bidModal').modal('toggle');
	}
}

//String 을 int 형으로 변환 해주는 함수
function parseIntMethod(data){
	var $numberData = "" + data.replace(/(^\s*)|(\s*$)|,/g, ''); // trim, 콤마 제거
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













