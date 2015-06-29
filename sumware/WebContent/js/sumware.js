/**
 * 
 */

// $(function(){}) == document.ready
// $(window).load(function(){}); == window.onload (이미지, js, 임포트된 외부 리소스 모두 로드
// 이후에 js 해석)
$(function() {
	// DOM 요소 로드 이후에 실행되기 떄문에 이벤트가 뻑날일이 없음
	$(".navbar-nav li a").click(function(e) {
		// 앵커태그 새로고침 이벤트 방지
		e.preventDefault();
		var pageName = $(this).text().toLowerCase();
		switch (pageName) {
		case ("main"):
			window.location.href = "home";
			break;
		case ("todo"):
			window.location.href = "todo";
			break;
		case ("calendar"):
			window.location.href = "calList";
			break;
		case ("board"):
			$(".navbar-nav form").attr("action",pageName);
			$(".navbar-nav input").attr("value",pageName);
			$(".navbar-nav form").submit();
//			window.location.href = "boardList";
			break;
		window.location.href = "messenger";
		break;
		}
	});
});