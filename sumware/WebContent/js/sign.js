/**
 * SignJS
 */
function signFormListModal() {
	$.ajax({
		type : "POST",
		url : "getSignFormList",
		success : function(result) {
			$("#signModalBody").html(result);
			$("#signModal").toggle();
		},
		error : function(a, b) {
			alert("Request: " + JSON.stringify(a));
		}
	});
}