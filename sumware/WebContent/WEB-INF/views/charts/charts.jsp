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
		// 개인 급여
		var comnames = JSON.parse('${comnames}'.trim());
		var comsums = JSON.parse('${comsums}'.trim());
		var snschart = JSON.parse('${snschart}'.trim());
// 		var tododept = JSON.parse('${tododept}'.trim());
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

		// 부서별 총 업무수
		$('#deptWorks')
				.highcharts(
						{
							chart : {
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false,
								type : 'pie'
							},
							title : {
								text : '부서별 업무'
							},
							tooltip : {
								pointFormat : '{series.name}: <b>{point.y} : {point.percentage:.1f}%</b>'
							},
							plotOptions : {
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',
									dataLabels : {
										enabled : false
									},
									showInLegend : true
								}
							},
							series : [ {
								name : "Department",
								colorByPoint : true,
								data : [ {
									name : "인사부",
									y : 56,
									sliced : true,
									selected : true
								}, {
									name : "총무부",
									y : 22,

								}, {
									name : "기획부",
									y : 10
								}, {
									name : "전산부",
									y : 30
								} ]
							} ]
						});

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

		//todo
		$('#todo').highcharts({
							chart : {
								type : 'pie'
							},
							title : {
								text : '부서별 업무'
							},
							subtitle : {
								text : 'Click the slices to view detail'
							},
							plotOptions : {
								series : {
									dataLabels : {
										enabled : true,
										format : '{point.name}: {point.percentage:.2f}%'
									}
								}
							},

							tooltip : {
								headerFormat : '<span style="font-size:11px">{series.name}</span><br>',
								pointFormat : '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}개</b> <br/>'
							},
							series : [ {
								name : "Department",
								colorByPoint : true,
								data : ${tododept},
								drilldown : {
									series : [
											{
												name : "인사부",
												id : "인사부",
												data : [ [ "팀장1", 3 ],
														[ "팀장2", 3 ],
														[ "팀장3", 6 ] ]
											},
											{
												name : "기획부",
												id : "기획부",
												data : [ [ "팀장1", 5 ],
														[ "팀장2", 5 ],
														[ "팀장3", 5 ],
														[ "팀장4", 9 ] ]
											},
											{
												name : "전산부",
												id : "전산부",
												data : [ [ "팀장1", 2 ],
														[ "팀장2", 2 ],
														[ "팀장3", 2 ],
														[ "팀장4", 4 ] ]
											},
											{
												name : "영업부",
												id : "영업부",
												data : [ [ "팀장1", 2 ],
														[ "팀장2", 2 ],
														[ "팀장3", 0 ] ]
											},
											{
												name : "총무부",
												id : "총무부",
												data : [ [ "팀장1", 1 ],
														[ "팀장2", 1 ],
														[ "팀장3", 1 ],
														[ "팀장4", 0 ] ]
											} ]
								}
							}]

						});
	});
</script>
<body>
	<div id="payment" style="width: 400px; height: 400px; margin: 0 auto"></div>
	<div id="deptWorks"
		style="width: 400px; height: 400px; max-width: 600px; margin: 0 auto"></div>
	<div id="sns" style="width: 400px; height: 400px; margin: 0 auto"></div>
	<div id="todo"
		style="width: 400px; max-width: 600px; height: 400px; margin: 0 auto"></div>

</body>
</html>