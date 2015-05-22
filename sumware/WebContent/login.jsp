<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


		<section id="slider">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
			
				<!-- Indicators bullet -->
				<ol class="carousel-indicators">
					<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				</ol>
				<!-- End Indicators bullet -->				
				
				<!-- Wrapper for slides -->
				<div class="carousel-inner" role="listbox">
					
					<!-- single slide -->
					<div class="item active" style="background-image: url(img/banner.jpg);">
						<div class="carousel-caption">
							<h2 data-wow-duration="700ms" data-wow-delay="500ms" class="wow bounceInDown animated">Sum<span> Ware</span>!</h2>
							<h3 data-wow-duration="1000ms" class="wow slideInLeft animated"><span class="color">creative</span> one  tem.</h3>
							<p data-wow-duration="1000ms" class="wow slideInRight animated">We are a team of professionals</p>
							
							<ul class="social-links text-center">
								<li><a href="#"><i class="fa fa-twitter fa-lg"></i></a></li>
								<li><a href="#"><i class="fa fa-facebook fa-lg"></i></a></li>
								<li><a href="#"><i class="fa fa-google-plus fa-lg"></i></a></li>
								<li><a href="#"><i class="fa fa-dribbble fa-lg"></i></a></li>
							</ul>
						</div>
					</div>
					<!-- 슬라이드 -->
					<div class="item" style="background-image: url(img/banner.jpg);">
						<div class="carousel-caption">
							<h2 data-wow-duration="500ms" data-wow-delay="500ms" class="wow bounceInDown animated">Meet<span> Team</span>!</h2>
							<h3 data-wow-duration="500ms" class="wow slideInLeft animated"><span class="color">/creative</span> one page template.</h3>
							<p data-wow-duration="500ms" class="wow slideInRight animated">We are a team of professionals</p>
							<ul class="social-links text-center">
								<li><a href="#"><i class="fa fa-twitter fa-lg"></i></a></li>
								<li><a href="#"><i class="fa fa-facebook fa-lg"></i></a></li>
								<li><a href="#"><i class="fa fa-google-plus fa-lg"></i></a></li>
								<li><a href="#"><i class="fa fa-dribbble fa-lg"></i></a></li>
							</ul>
							
						</div>
						
					</div>
					<!-- end single slide -->
					
				</div>
				<!-- End Wrapper for slides -->
			</div>
		</section>
        <!--
        Home Slider
        ==================================== -->
		
		<section id="features" class="features">
			<div class="container">
				<div class="row">
					<div class="sec-title text-center mb50 wow bounceInDown animated" data-wow-duration="500ms">
						<h2>LOGIN</h2>
						<div class="devider"><i class="fa fa-heart-o fa-lg"></i></div>
					</div>
					<!-- service item -->
					<div class="col-md-12 wow fadeInLeft" data-wow-duration="500ms">
						<form class="form-inline" role="form" action="sumware" method="post">
								<input type="hidden" name="model" value="login">
								<input type="hidden" name="submod" value="login">
								<div class="porm-group">
									<label class="control-label-" for="sabun"> 사원번호 :</label> 
									<input type="text" id="memnum" name="memnum" placeholder="사원번호"> 
									<label class="control-label" for="Password"> 비밀번호 :</label> 
									<input type="password" id="mempwd" name="mempwd" placeholder="비밀번호">
									<button type="submit" class="btn btn-xs btn-info">로그인</button>
								</div>
							</form>
					</div>
					<!-- end service item -->
				</div>
			</div>
		</section>
		