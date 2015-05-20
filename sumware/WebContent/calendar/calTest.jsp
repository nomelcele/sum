<%@page import="java.util.ArrayList"%>
<%@page import="dto.CalendarVO"%>
<%@page import="dao.CalendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel='stylesheet' href='fjs/fullcalendar.min.css' />
<script src='fjs/lib/moment.min.js'></script>
<script src='fjs/fullcalendar.min.js'></script>
<script src='fjs/lang-all.js'></script>
<script>
$(function(){
	  var currentLangCode = 'ko';
	  var caldiv =1; //같은 날짜에 스케줄이 등록되었을시 구분하기.
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
// 	   eventClick : function(calEvent,jsEvent,view){ //달력 이벤트 클릭 - 이 소스에서는 false!
// 		   var r=confirm("Delete " + calEvent.title);
// 			   if (r===true)
// 				   {
// 				   //_id 캘린더의 한 바의 아이디.
// 				   alert("eventid:"+calEvent._id);
// 				   	$('#calendar').fullCalendar('removeEvents', calEvent._id);
// 				   }
// 		   },
	   defaultView: 'agendaWeek',//기본 뷰 - 옵션   //첫 페이지 기본 뷰 옵션
	   editable: false,                                             //에디터 가능 옵션
	   selectable: true,
	   selectHelper: true,
	   //캘린더 셀렉트 된 값을 컬럼에 표시
	   select: function(start, end,event) {
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
		    
		    alert("selected from: " + start.format() + ", to: " + end.format());
		   //셀렉트된 결과를 서버로 전송.
		          $.ajax({
		              url: "sumware?mod=calendar&summod=calInsert",
		              type: "POST",
		              data: {
		                  title:encodeURIComponent(title),
		                  start:start.format(),
		                  end:end.format(),
		                  caldiv:caldiv
		              },
		              dataType: "html",
		              success: function(a) {
		                  alert("Data: " + a);
		              },
		              error: function(a, b) {
		                  alert("Request: " + JSON.stringify(a));
		              }
		          });
		   caldiv = (parseInt(caldiv,10)+1);
		   console.log("caldiv:"+caldiv);
		   },
		   editable: true,
		   eventLimit: true, 
		   events:"${calJson}"

		  })
	 });
	
</script>
</head>
<body>
	<div id='calendar'></div>
</body>
</html>