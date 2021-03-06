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
<spring:url value="resources/font-awesome/css/font-awesome.css"
	var="font" />
<spring:url value="resources/font-awesome/css/font-awesome.min.css"
	var="font2" />
<spring:url value="resources/css/bootstrap.min.css" var="boot" />
<spring:url value="resources/css/signForm.css" var="sign" />
<spring:url value="resources/css/auction.css" var="auction" />
<link rel="stylesheet" type="text/css" href="${auction}" />
<link rel="stylesheet" type="text/css" href="${sign }" />
<link rel="stylesheet" type="text/css" href="${css }" />
<link rel="stylesheet" type="text/css" href="${font }" />
<link rel="stylesheet" type="text/css" href="${font2}" />
<link rel="stylesheet" type="text/css" href="${boot}" />
<!-- CSS 라이브러리(E)  -->
<!-- 자바스크립트 -->
<!-- todo일 때 sns부분 -->
<!-- 모달 -->
<script src="js/sumware.js"></script>
<script src="js/auction.js"></script>
<script src="js/board.js"></script>
<script src="js/mail.js"></script>
<script src="js/http.js"></script>
<script src="js/todo.js"></script>
<script src="js/admin.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/notification.js"></script>
<script src="js/meminfo.js"></script>
<c:if test="${sessionScope.model eq 'sign' }">
	<script>
	var id=['formnum','stitle','startdate','enddate','sgwriter','sfname','sgreturncomm','sdate','splace','sps'];
	var val=['${sf.sfnum}','${sgvo.stitle}','${sgvo.startdate}','${sgvo.enddate}','${sgvo.memname}','${sgvo.sfname}','${sgvo.sgreturncomm}','${sgvo.sdate}','${sgvo.splace}','${sgvo.sps}'];
		$(function(){
			memnum="${sessionScope.v.memnum}";		
			var signMode="${signMode}";
			var mgrs={};
			var names={};
			var status ={};
			"<c:forEach var='sn' items='${sgNames }' varStatus='index'>";
				names['${index.count}']='${sn}';
			"</c:forEach>";
			$("#formnum").val("${formnum}");
			if(signMode=='write'){
				"<c:forEach var='sm' items='${signMgrs }' varStatus='index'>";
					mgrs['${index.count}']='${sm}';
					size='${index.count}';
				"</c:forEach>";
				$('#sgwriter').val("${sessionScope.v.memname}");
				
				addSignDiv(mgrs,names,"${sessionScope.v.memdept}");
				
			}else if(signMode='detail'){
				var signimg={};
				"<c:forEach var='ss' items='${ssList}' varStatus='index'>";
					mgrs['${index.count}']='${ss.stepmemnum}';
					status['${index.count}']='${ss.stepconfirm}';
					size='${index.count}';
					signimg['${index.count}']='${ss.memsignimg}';
				"</c:forEach>";
				
				if("${!empty sgvo.scont}"=="true"){
					$("#scont").val($("#targetScont").val());
					$("#scont").attr("readonly","readonly");
					$("#targetScont").val("");
				}
				if("${!empty sgvo.sreason}"=="true"){
					$("#sreason").val($("#targetSreason").val());
					$("#sreason").attr("readonly","readonly");
					$("#targetSreason").val("");
				}else{
					
				}
				for(var f=0; f<id.length; f++){
					if(val[f]!=""){
						setSignValue(id[f],val[f]);
					}
				}
				if("${sgvo.ycount eq sgvo.count}"){
					$("#sgDocBtn").attr("type","button");
				}
				
				addSignDiv(mgrs,names,status,signimg,"${sgvo.sgreturn}","${expired}");
				
				
				if("${!empty sgvo.sgreturncomm}"=="true"){
					var signComm="<table style='margin-left:20px'><tr><td><h4 style='font-weight:bold'><i class='fa fa-thumb-tack'style='color:#5D5D5D'></i> Comment</h4></td></tr><tr><td><textarea class='form-control' readonly='readonly' rows='3' cols='50' style='resize:none;' readonly='readonly'>${sgvo.sgreturncomm}</textarea></td></tr>";
					$('#signCommDiv').html(signComm);
					$('#sgReturnBtn').attr("type","hidden");
					$('#sgBtn').attr("type","hidden");
				}
			}
		});
	</script>
	<script src="js/sign.js"></script>
</c:if>
<script>
$(function(){
	if("${empty v.meminmail}"=="false"){
		//메신저
		console.log("Messenge typeof:" + typeof (EventSource));
		if (typeof (EventSource) != "undefined") {
			var eventMesSourceList = new EventSource("samesCountMsg");
			eventMesSourceList.onmessage = function(event) {
				$('#countRoomNum').html(event.data);
			};
		} else {
			alert("해당 브라우저는 지원이 안됩니다.");
		}
		// The user needs to allow this
		console.log("meminmail:::${v.meminmail}");
		// push를 받을 수 있는 브라우저
		if (typeof (EventSource) != "undefined") {
			// EventSource 객체를 생성하면 파라미터로 들어간 URL로 계속 요청이 감
			eventSourceCount = new EventSource(
					"satmCount?mailreceiver=${v.meminmail}&memnum=${v.memnum}");
			// 서버로부터 응답을 받을 경우 실행될 이벤트 리스너 설정
			eventSourceCount.onmessage = function(event) {
				var data = event.data; // 서버에서 data 필드에 담아 전송한 데이터
				console.log("notification::"+data);
				if(data=="tx"){ // 새로운 업무가 등록됐을 때
					console.log("todo");
					// 알림 띄움
					Notify("todo","새로운 업무가 등록되었습니다.","safirsttodoForm?model=todo");
				}else if(data=="m"){ // 새로 온 메일이 있을 때
					console.log("mail");
					Notify("mail","새로운 메일이 도착하였습니다.","samailFromList?model=mail&page=1");
				}else if(data=="tm"){ // 새로운 업무, 메일이 있을 때
					console.log("todo&mail");
					Notify("todo","새로운 업무가 등록되었습니다.","safirsttodoForm?model=todo");
					setTimeout(function(){
						Notify("mail","새로운 메일이 도착하였습니다.","samailFromList?model=mail&page=1");
					}, 3000);
			};
		} 
		}else {
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
		if(typeof(EventSource)!="undefined"){
			console.log("conf notification");
			eventSourceConf = new EventSource("saconfNotify?confmem=${v.memnum}");
			eventSourceConf.onmessage = function(event){
				Notify("Conference","회의에 초대되셨습니다.",event.data);
			}
		} else {
			$(".chat").html("해당 브라우저는 지원이 안됩니다.");
		}
	}
	
	
});
</script>
<c:if
	test="${sessionScope.model eq 'join' || sessionScope.model eq 'memjoin' }">
	<%--우편번호 다음 링크 --%>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
	$(function(){
		if("${!empty sessionScope.v.memprofile}"=="true"){
			// 프로필 수정 시 지정해준 사진값(memprofile)이 없으므로 프로필 사진을등록해달라고 함!
			// 그래서 프로필 수정 시 memprofile의 value값을 지정해 주어야 함
			$('#targetimg').attr('src',"resources/profileImg/${sessionScope.v.memprofile}").css(
					'width', '200').css('height', '200');
		}
		<%--본래 비밀번호 비밀번호 수정시 버튼 --%>

		$('#chbtn').click(function() {
			if($('#mempwd').val() == "${mempwd}" && "${sessionScope.v.mempwd }" == ""){
				// 첫 프로필 수정시
				$('.dhpwd').show("slow");
				
			}else if($('#mempwd').val() == "${sessionScope.v.mempwd }" && "${sessionScope.v.mempwd }" != ""){
				// 사원 프로필 수정시
				$('.dhpwd').show("slow");
				
			}	else {
		
				$('#targetpw').html('<p style="color: red;">비밀번호가 일치 하지 않습니다.</p>');
				setTimeout(function(){
					$('#targetpw').html(' ');
				}, 2000);
			}  
	});
	});
</script>
	<script src="js/member.js"></script>
</c:if>
<c:if test="${sessionScope.model eq 'board' }">
	<spring:url value="resources/css/boardCSS.css" var="boardCss" />
	<link rel="stylesheet" type="text/css" href="${boardCss }" />
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
	<script src="js/myckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			chkUpload();
		});
	</script>
</c:if>
<c:if test="${sessionScope.model eq 'calendar' }">
	<!-- 캘린더 -->
	<spring:url value="resources/fjs/fullcalendar.min.css"
		var="fullcalendarCss" />
	<spring:url value="resources/fjs/lib/moment.min.js" var="momentJs" />
	<spring:url value="resources/fjs/fullcalendar.min.js"
		var="fullcalendarJs" />
	<spring:url value="resources/fjs/lang-all.js" var="langJs" />
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
			              url: "sacalDelete",
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
		      $.ajax({
	              url: "sacalInsert",
	              type: "POST",
	              data: {
	                  title:encodeURIComponent(title),
	                  calstart:start.format(),
	                  calend:end.format(),
	                  selCal:selCal
	              },
	              dataType: "html",
	              success: function(res) {
					location=res;		            	 
	              },
	              error: function(a, b) {
	                  alert("Request: " + JSON.stringify(a));
	              }
	          });
		    }
		    $('#calendar').fullCalendar('unselect');
		    
// 		    alert("selected from: " + start.format() + ", to: " + end.format());
		   //셀렉트된 결과를 서버로 전송.
		    
		   },
		   editable: true,
		   eventLimit: true, 
		   events:[${calJson}]
		  })
	 });
</script>
	<!-- /캘린더 -->
</c:if>
<!-- Todo - SNS(S) -->
<c:if test="${sessionScope.model eq 'todo' }">
	<script>
//push Client 설정 (받는쪽)
var rowsPerPage = 8; // sns에 쓸 행수
var eventSource;
var cheight = $('.chat').height() - 50;// sns
var ch;// snsComm
var pageB = 5; // snscomm에서 쓸 페이지 행수
$(function() {
	push();
});
function push() {
	if (typeof (EventSource) != "undefined") {
		// push를 받을수 있는 브라우져인지 판단.
		eventSource = new EventSource(
				"sapushSns?sdept=${v.memdept}&page=1&rowsPerPage=" + rowsPerPage);
		eventSource.onmessage = function(event) {
			$(".chat").html(event.data);
		};
	} else {
		$(".chat").html("해당 브라우저는 지원이 안됩니다.");
	}
}
</script>
</c:if>
<!-- Todo - SNS(E) -->

<!-- Board(S) -->
<c:if test="${param.submod eq 'writeForm' }">
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>
	<script src="js/myckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			chkUpload();
		});
	</script>
</c:if>
<!-- Board(E) -->

<c:if test="${sessionScope.model eq 'mail'}">
	<script src="//cdn.ckeditor.com/4.5.0/basic/ckeditor.js"></script>
	<script src="js/myckeditor.js"></script>
	<script type="text/javascript">
		$(function() {
			mailChkUpload();
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