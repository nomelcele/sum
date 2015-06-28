<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!-- 캘린더 -->
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<spring:url value="resources/fjs/fullcalendar.min.css" var="fullcalendarCss"/>
<spring:url value="resources/fjs/lib/moment.min.js" var="momentJs"/>
<spring:url value="resources/fjs/fullcalendar.min.js" var="fullcalendarJs"/>
<spring:url value="resources/fjs/lang-all.js" var="langJs"/>
<link rel='stylesheet' href='${fullcalendarCss }' />
<script src='${momentJs }'></script>
<script src='${fullcalendarJs }'></script>
<script src='${langJs }'></script>
<!-- /캘린더 -->
<!-- Latest compiled and minified CSS -->
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
<!-- include 페이지에서 닫아주는 태그 가져와야 함.
	이게 tiles 로도 가능 하겠지?...
 -->
<div  class="wrap-layout wrap">
	<div class="lnb-area" id="lnb-area">
		<!-- left menu !!!! 들어갈 자리 -->
	</div>
	<div class="contents">

			<div class="">
				<div style="text-align: right;padding: 10px;">
					<input type="button" class="btn btn-outline btn-primary btn-xs" id="calDept" value="부서일정" onclick="location='calList?cal=0'">
					<input type="button" class="btn btn-outline btn-primary btn-xs" id="calMem" value="사원일정" onclick="location='calList?cal=1'">
				</div>
				<div id='calendar'></div>
			</div>
	</div>
</div>
