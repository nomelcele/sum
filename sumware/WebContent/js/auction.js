/**
 * 
 */
// productList.jsp 에서 상품등록 버튼 누르면 작동 되는 메소드.
$(function(){
	$('#auctionBtn1 button').click(function(){
		$.ajax({
			url : "writeForm",
			type : "post",
			success : function(result){
				$('#mTarget').html(result);
				$('#myModal').modal('toggle');
			}
		});
	});
});

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

function doneClick(){
	$('#doneForm').submit();
	$('#myModal').modal('toggle');
}
