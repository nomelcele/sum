/**
 * 
 */
// productList.jsp 에서 상품등록 버튼 누르면 작동 되는 메소드.
$(function(){
	$('#auctionBtn1 button').click(function(){
		$.ajax({
			url : "sawriteForm",
			type : "post",
			success : function(result){
				$('#mTarget').html(result);
				$('#myModal').modal('toggle');
			}
		});
	});
	$('#proimg').click(function(){
		location='saproDetail';
	});
});

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
	$('#myModal').modal('toggle');
}















