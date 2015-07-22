<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
<script src="http://code.highcharts.com/modules/drilldown.js"></script>
<script>
	$(function() {
		// 추가 급여 순위
		chartpayment();
		chartsns();
		charttodo();
		chartauction();

	});
	
	function chartpayment(){
		var comnames = JSON.parse('${comnames}'.trim());
		var comsums = JSON.parse('${comsums}'.trim());
		$('#payment').highcharts(
				{
					chart : {
						type : 'column'
					},

					title : {
						text : '전 월 추가급여 순위'
					},

					xAxis : {
						categories : comnames
					},

					yAxis : {
						allowDecimals : false,
						min : 0,
						title : {
							text : '성과금(만원)'
						}
					},

					tooltip : {
						formatter : function() {
							return '<b>' + this.x + '</b><br/>'
									+ this.series.name + ': ' + this.y
									+ '<br/>' + 'Total: '
									+ this.point.stackTotal;
						}
					},

					plotOptions : {
						column : {
							stacking : 'normal'
						}
					},

					series : [ {
						name : '성과금',
						data : comsums,
						color: Highcharts.getOptions().colors[7],
					} ]
				});
	}
	
	function chartsns(){
		var snschart = JSON.parse('${snschart}'.trim());
		// SNS 활동 순위
		$('#sns').highcharts({
			chart : {
				type : 'column'
			},
			title : {
				text : 'SNS 활동 순위'
			},
			subtitle : {
				text : ''
			},
			xAxis : {
				type : 'category',
				labels : {
					rotation : -45,
					style : {
						fontSize : '13px',
						fontFamily : 'Verdana, sans-serif'
					}
				}
			},
			yAxis : {
				min : 0,
				title : {
					text : '게시글 수'
				}
			},
			legend : {
				enabled : false
			},
			tooltip : {
				pointFormat : '<b>{point.y} 개</b>'
			},
			series : [ {
				name : '게시글',
				data : snschart,
				color: Highcharts.getOptions().colors[6],
				dataLabels : {
					enabled : true,
					rotation : -90,
					color : '#ffffff',
					align : 'right',
					format : '{point.y}', // one decimal
					y : 10, // 10 pixels down from the top
					style : {
						fontSize : '13px',
						fontFamily : 'Verdana, sans-serif'
					}
				}
			} ]
		});
	}
	
	function charttodo(){
		// 부서별 업무 성취 순위
		$('#todo').highcharts({
	        chart: {
	            type: 'pie'
	        },
	        title: {
	            text: '부서별 업무'
	        },
	        plotOptions: {
	            series: {
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name}: {point.percentage:.1f}%'
	                }
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}개</b><br/>'
	        },
	        series: [{
	            name: "Department",
	            colorByPoint: true,
	            data: ${tododept}}],
	        drilldown: {
	            series: ${todoteam}
	        }
	    });
	}
	
	
	function chartauction(){
		var auctionchart = JSON.parse('${auctionchart}'.trim());
		// 경매 입찰 순위
		$('#auction').highcharts({
			chart : {
				type : 'column'
			},
			title : {
				text : '경매 입찰 순위'
			},
			subtitle : {
				text : ''
			},
			xAxis : {
				type : 'category',
				labels : {
					rotation : -45,
					style : {
						fontSize : '13px',
						fontFamily : 'Verdana, sans-serif'
					}
				}
			},
			yAxis : {
				min : 0,
				title : {
					text : '입찰 수'
				}
			},
			legend : {
				enabled : false
			},
			tooltip : {
				pointFormat : '<b>{point.y} 개</b>'
			},
			series : [ {
				name : '품명',
				data : auctionchart,
				color: Highcharts.getOptions().colors[5],
				dataLabels : {
					enabled : true,
					rotation : -90,
					color : '#ffffff',
					align : 'right',
					format : '{point.y}', // one decimal
					y : 10, // 10 pixels down from the top
					style : {
						fontSize : '13px',
						fontFamily : 'Verdana, sans-serif'
					}
				}
			} ]
		});
	}
	
	function showbigsize(res){
	      if(res == 'todo'){
	         $('#payment').hide('slow');
	         $('#sns').hide('slow');
	         $('#auction').hide('slow');
	         $('#'+res).attr("style","width:700px; height:700px;")
	         $('#'+res).attr("onclick","")
	         $('#backbtn').show('slow');
	         charttodo();
	      }else if(res == 'payment'){
	         $('#todo').hide('slow');
	         $('#sns').hide('slow');
	         $('#auction').hide('slow');
	         $('#'+res).attr("style","width:700px; height:700px;")
	         $('#'+res).attr("onclick","")
	         $('#backbtn').show('slow');
	         chartpayment();
	      }else if(res == 'sns'){
	         $('#todo').hide('slow');
	         $('#payment').hide('slow');
	         $('#auction').hide('slow');
	         $('#'+res).attr("style","width:700px; height:700px;")
	         $('#'+res).attr("onclick","")
	         $('#backbtn').show('slow');
	         chartsns();
	      }else if(res == 'auction'){
		         $('#todo').hide('slow');
		         $('#payment').hide('slow');
		         $('#sns').hide('slow');
		         $('#'+res).attr("style","width:700px; height:700px;")
		         $('#'+res).attr("onclick","")
		         $('#backbtn').show('slow');
		         chartauction();
	      }
	   }
</script>

<div class="container" style="position: center;" align="center">
	<button type="button"  id="backbtn" onclick="location='sachart'" class="btn btn-default btn-sm"  style="float:right; display:none; margin-right: 30px"><i class="fa fa-reply"></i> Back</button>
	<div class="wrap">
		<div id="payment"
		style="width: 400px; height: 300px; float:left; margin-left:100px; cursor: zoom-in;"
		onclick="javascript:showbigsize('payment')"></div>
	<div id="todo"
		style="width: 400px; height: 300px; float:left; margin-left: 100px; cursor: zoom-in;"
		onclick="javascript:showbigsize('todo')"></div>
	</div>
	
	<div class="wrap" >
		<div id="auction"
		style="width: 400px; height: 300px; float:left; margin-left:100px; margin-top:100px; cursor: zoom-in;"
		onclick="javascript:showbigsize('auction')"></div>
		<div id="sns"
		style="width: 400px; height: 300px; float:left; margin-left: 100px;  margin-top:100px; cursor: zoom-in;"
		onclick="javascript:showbigsize('sns')"></div>
	</div>
</div>
