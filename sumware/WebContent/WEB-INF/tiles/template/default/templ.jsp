<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<title>SumWare</title>
<!-- CSS 라이브러리(S)  -->
<spring:url value="resources/css/common.css" var="css" />
<spring:url value="resources/font-awesome/css/font-awesome.css"	var="font" />
<spring:url value="resources/font-awesome/css/font-awesome.min.css"	var="font2" />
<spring:url value="resources/css/bootstrap.min.css" var="boot" />
<link rel="stylesheet" type="text/css" href="${css }" />
<link rel="stylesheet" type="text/css" href="${font }" />
<link rel="stylesheet" type="text/css" href="${font2}" />
<link rel="stylesheet" type="text/css" href="${boot}" />
<!-- CSS 라이브러리(E)  -->
<!-- 자바스크립트 -->
<!-- todo일 때 sns부분 -->
<!-- 모달 -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="js/sumware.js"></script>
<script src="js/board.js"></script>
<script src="js/http.js"></script>
<!-- <script src="js/bootstrap.min.js"></script> -->
<c:if test="${sessionScope.model eq 'calendar' }">
	<!-- 캘린더 -->
	<spring:url value="resources/fjs/fullcalendar.min.css" var="fullcalendarCss"/>
	<spring:url value="resources/fjs/lib/moment.min.js" var="momentJs"/>
	<spring:url value="resources/fjs/fullcalendar.min.js" var="fullcalendarJs"/>
	<spring:url value="resources/fjs/lang-all.js" var="langJs"/>
	<link rel='stylesheet' href='${fullcalendarCss }' />
	<script src='${momentJs }'></script>
	<script src='${fullcalendarJs }'></script>
	<script src='${langJs }'></script>
	<script src='${mainJs}'></script>
	<script>
$(function(){
	  var currentLangCode = 'ko';
	  var selCal="${selcal}";
	  $('#calendar').fullCalendar('destroy');
	  $('#calendar').fullCalendar({
	   
	   //lang: currentLangCode,
	   dragable:false,  //드래그앤 드랍 옵션
	            timeFormat: 'hh:mm', //시간 포멧
	            lang: 'ko',  //언어타입
	            header: {
	     left: 'prev,next today',
	     center: 'title',
	     right: 'month,agendaWeek,agendaDay'
	      },
	   //삭제클릭이벤트
	   eventClick : function(calEvent,view){ //달력 이벤트 클릭 - 이 소스에서는 false!
		   var r=confirm("Delete " + calEvent.title);
	   		console.log("delete calEvent:",calEvent);
			   if (r===true)
				   {
				   //_id 캘린더의 한 바의 아이디.
				   alert("eventid:"+calEvent._id);
				   	//삭제할 ajax
				    $.ajax({
			              url: "calDelete",
			              type: "POST",
			              data: {
			                  calnum:calEvent._id,
			                  selCal:selCal
			              },
			              dataType: "html",
			              success: function() {
			            	  //캘린더에서 삭제.
			            	  $('#calendar').fullCalendar('removeEvents', calEvent._id);
			              },
			              error: function(a, b) {
			                  alert("Request: " + JSON.stringify(a));
			              }
			          });
				   }
		   },
	   defaultView: 'month',//기본 뷰 - 옵션   //첫 페이지 기본 뷰 옵션
	   editable: false,                                             //에디터 가능 옵션
	   selectable: true,
	   selectHelper: true,
	   //캘린더 셀렉트 된 값을 컬럼에 표시
	   select: function(start, end,event) {
		   console.log("end"+(end-start));
			var title = prompt('Event Title:');
		    var eventData;
		    if (title) {
		     eventData = {
		      title: title,
		      start: start,
		      end: end
		     };
		     $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
		    }
		    $('#calendar').fullCalendar('unselect');
		    
// 		    alert("selected from: " + start.format() + ", to: " + end.format());
		   //셀렉트된 결과를 서버로 전송.
		          $.ajax({
		              url: "calInsert",
		              type: "POST",
		              data: {
		                  title:encodeURIComponent(title),
		                  calstart:start.format(),
		                  calend:end.format(),
		                  selCal:selCal
		              },
		              dataType: "html",
		              success: function(res) {
		            	alert("success::"+res);
						location=res;		            	 
		              },
		              error: function(a, b) {
		                  alert("Request: " + JSON.stringify(a));
		              }
		          });
		   },
		   editable: true,
		   eventLimit: true, 
		   events:[${calJson}]
		  })
	 });
</script>
	<!-- /캘린더 -->
</c:if>
<c:if test="${param.submod eq 'writeForm' }">
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
	<script src="js/myckeditor.js"></script>
	<script src="js/util.js"></script>
	<script type="text/javascript">
		$(function() {
			chkUpload();
		});
	</script>
</c:if>
</head>
<body>
	<tiles:insertAttribute flush="true" name="header" />
	<div class="wrap-layout board" id="global">
	<div class="lnb-area" id="lnb-area">
		<tiles:insertAttribute flush="true" name="menu" />
	</div>
	<div class="contents">
		<!-- body -->
		<tiles:insertAttribute flush="true" name="body" />
	</div>
	</div>
	<!-- footer -->
	<tiles:insertAttribute flush="true" name="footer" />
</body>
</html>