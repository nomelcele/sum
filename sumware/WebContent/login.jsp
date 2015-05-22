<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container">
	<div id="carousel1" class="carousel slide" data-ride="carousel">
		<div class="carousel-inner">
			<div class="item active">
				<img alt="Bootstrap template" src="img/slide_01.jpg">
				<div class="carousel-caption">
					<h3 style="font-size: 39pt;">Sum Ware</h3>
					<p>Founded in 1892 and headquartered in Fairfield, CT, General
						Electric Company (LSE; NYSE: GE) is a technology and financial
						services company. The company offers products and services ranging
						from aircraft engines, power generation, water processing, and
						household appliances, among others.</p>
				</div>
			</div>
			<div class="item">
				<img alt="Bootstrap template" src="img/slide_02.jpg">
				<div class="carousel-caption">
					<div class="col-lg-12 text-center v-center"
						style="font-size: 39pt;">
						<a href="#"><span class="avatar"><i
								class="fa fa-google-plus"></i></span></a> <a href="#"><span
							class="avatar"><i class="fa fa-linkedin"></i></span></a> <a href="#"><span
							class="avatar"><i class="fa fa-facebook"></i></span></a> <a href="#"><span
							class="avatar"><i class="fa fa-github"></i></span></a>
					</div>
				</div>
			</div>
			<div class="item">
				<img alt="Bootstrap template" src="img/slide_03.jpg">
				<div class="carousel-caption">
					<h3>Portfolio</h3>
					<p>This is a list of some of the work done by the company over
						the past quarter.</p>
				</div>
			</div>
		</div>
		<ul class="nav nav-justified">
			<li data-target="#carousel1" data-slide-to="0" class="active"><a
				href="#">Main</a></li>
			<li data-target="#carousel1" data-slide-to="1"><a href="#">Projects</a>
			</li>
			<li data-target="#carousel1" data-slide-to="2"><a href="#">Portfolio</a>
			</li>
		</ul>
	</div>
</div>
<%-- --%>
<div>
				<form class="form-inline" role="form" action="sumware" method="post">
					<input type="hidden" name="model" value="login"> <input
						type="hidden" name="submod" value="login">
					<div class="porm-group">
						<label class="control-label-" for="sabun"> 사원번호 :</label> <input
							type="text" id="memnum" name="memnum" placeholder="사원번호">
						<label class="control-label" for="Password"> 비밀번호 :</label> <input
							type="password" id="mempwd" name="mempwd" placeholder="비밀번호">
						<button type="submit" class="btn btn-xs btn-info">로그인</button>
					</div>
				</form>
</div>