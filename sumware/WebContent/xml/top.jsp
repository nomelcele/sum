<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>SunWare</title>

<link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />


<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">




<style>
.main-text {
	position: absolute;
	top: 50px;
	width: 96.66666666666666%;
	color: #FFF;
}

.btn-min-block {
	min-width: 170px;
	line-height: 26px;
}

.btn-clear {
	color: #FFF;
	border-color: #FFF;
	border-width: 2px;
	margin-right: 15px;
}

.btn-clear:hover {
	color: #000;
	background-color: #6699CC;
}

.arrowalign {
	top: 50%;
}

.arrowalign:hover {
	vertical-align: middle;
}

.carousel-control {
	color: #fff;
	top: 50%;
	bottom: auto;
	padding-top: 0px;
	width: 30px;
	height: 30px;
	text-shadow: none;
	opacity: 0.9;
}

.main {
	padding-top: 30px;
}
.footer {
	background-color: #0eb493;
	padding: 30px;
	color: #fff;}

</style>

</head>
<nav class="navbar navbar">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#body"><img src="img/sum.png"
				alt="SumWare"></a> <a class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse"> <span
				class="glyphicon glyphicon-chevron-down"></span>
			</a>
		</div>
		<div class="nav navbar-right">
			<ul class="nav navbar-nav">
				<li><a href="#">메인</a></li>
				<li><a href="#">내정보</a></li>
				<li><a href="#">ToDo</a></li>
				<li><a href="#">메일</a></li>
				<li><a href="#">게시판</a></li>
				
			</ul>
			<ul class="nav navbar-right navbar-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="glyphicon glyphicon-search"></i></a>
					<ul class="dropdown-menu" style="padding: 12px;">
						<form class="form-inline">
							<button type="submit" class="btn btn-default pull-right">
								<i class="glyphicon glyphicon-search"></i>
							</button>
							<input type="text" class="form-control pull-left"
								placeholder="Search">
						</form>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i>
						<i class="glyphicon glyphicon-chevron-down"></i></a>
					<ul class="dropdown-menu">
						<li><a href="#">Login</a></li>
						<li><a href="#">Profile</a></li>
						<li class="divider"></li>
						<li><a href="#">About</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>

