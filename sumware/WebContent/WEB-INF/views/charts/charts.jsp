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
		var comnames = JSON.parse('${comnames}'.trim());
		var comsums = JSON.parse('${comsums}'.trim());
		var snschart = JSON.parse('${snschart}'.trim());
		alert(comnames)
		alert(comsums)
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
					} ]
				});

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
	});
	
</script>
<body>
	<div class="col-lg-6">
		<div class="row-lg-6">
			<div id="payment" style="width: 400px; height: 300px; margin: 0 auto"></div>
		</div>
		<div class="row-lg-6">
			<div id="sns" style="width: 400px; height: 300px; margin: 0 auto"></div>
		</div>
	</div>
	<div class="col-lg-6">
		<div id="todo" style="width: 600px; height: 600px; margin: 0 auto; border:2px"></div>
	</div>
	

</body>
</html>