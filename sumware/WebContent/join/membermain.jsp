<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<%@include file="../top.jsp"%>
</div>

<div class="container">
	<div class="row info" style="text-align: center;">
		<div class="col-xs-12 alert alert-info"></div>
	</div>
	<div class="resume">
		<header class="page-header">
			<h1 class="page-title">프로필</h1>
			<small> <i class="fa fa-clock-o"></i> Last Updated on: <time>Sunday,
					October 05, 2015</time></small>
		</header>
		<div class="row">
			<div
				class="col-xs-12 col-sm-12 col-md-offset-1 col-md-10 col-lg-offset-2 col-lg-8">
				<div class="panel panel-default">
					<div class="panel-heading resume-heading">
						<div class="row">
							<div class="col-lg-12">
								<div class="col-xs-12 col-sm-4">
									<figure>
										<img class="img-circle img-responsive" alt=""
											src="http://placehold.it/200x200"style="width: 200px; height: 200px;">
									</figure>

									<div class="row">
										<div class="col-xs-12 social-btns">

											<div class="col-xs-3 col-md-1 col-lg-1 social-btn-holder">
												<a href="#" class="btn btn-social btn-block btn-google">
													<i class="fa fa-google"></i>
												</a>
											</div>
										</div>
									</div>

								</div>

								<div class="col-xs-12 col-sm-8">
									<ul class="list-group">
										<li class="list-group-item">아이디</li>
										<li class="list-group-item">비번</li>
										<li class="list-group-item">주소</li>
										<li class="list-group-item"><i class="fa fa-phone"></i>
											이메일</li>
		
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="bs-callout bs-callout-danger">
					
						<div class="form-group">
									<div class="">
										<div class="pull-right">
											
											<button type="submit" class="btn btn-primary"><i class="fa fa-floppy-o"></i></button>
										</div>
									</div>
								</div>
					</div>

				</div>

			</div>
		</div>

	</div>

</div>


<div>
	<%@include file="../footer.jsp"%>
</div>