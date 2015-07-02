<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="container">
	<div class="row info">
		<div class="row">
			<div class="col-sm-10 col-sm-offset-1">
				<div class="resume">
				
					
					<c:if test="${sessionScope.model ne 'join'}">
					<form class="form-horizontal" role="form" method="post"
						action="signup" id="myform" name="myform" >
					<input type="hidden" name="memnum" value="${memnum}"> 
					</c:if>
					<c:if test="${sessionScope.model eq 'join' }">
						<form class="form-horizontal" role="form" method="post"
							action="modify" id="myform" name="myform" >
						<input type="hidden" name="memnum" value="${sessionScope.v.memnum}"> 
					</c:if>
					<input type="hidden" name="memnum" value="${memnum}"> 
					<input type="hidden" name="memaddr" id="address">
					<input type="hidden" name="memprofile" id="memprofile">
					
					<header class="page-header">
						<h1 class="page-title">Profile Modify</h1>
						<small><i class="fa fa-clock-o"></i> Last Updated on: <time>Sunday,
								October 05, 2015</time></small>
					</header>
					<div class="panel panel-default">
						<div class="panel-heading resume-heading">
							<div class="row">
								<div class="profileimg">
									<figure>
									<c:if test="${sessionScope.model ne 'join'}">
										<img class="img-circle" alt="프로필 사진 "
											id="targetimg" src="resources/img/imgx.jpg">
									</c:if>
									<c:if test="${sessionScope.model eq 'join' }">
										<img class="img-circle" alt="프로필 사진 "
											id="targetimg" src="resources/profileImg/${sessionScope.v.memprofile }">
									</c:if>
									</figure>
									<div class="btn-group">
										<input type="file" id="fileimg" name="fileimg">
										<img src="resources/img/ion.JPG">
									</div>
								</div>
							</div>
						</div>
						</div>
						<div style="padding-top:10px;">
						<h3 class="page-title2">Detailed Matters</h3>
						</div>
						<div class="bs-callout bs-callout-danger">
							<div class="row">
							<div class="col-sm-8 col-sm-offset-2">
								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput">아이디</label>
									<c:if test="${sessionScope.model eq 'join' }">
									<div class="col-sm-6">
										<input type="text" id="meminmail" name="meminmail" readonly=readonly
											value="${sessionScope.v.meminmail }" class="form-control">
										<div id="target"></div>
									</div>
									</c:if>
									<c:if test="${sessionScope.model ne 'join' }">
									<div class="col-sm-6">
										<input type="text" id="meminmail" name="meminmail"
											placeholder="사내 이메일" class="form-control">
										<div id="target"></div>
									</div>
									</c:if>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput">기존
										비밀번호</label>
									<div class="col-sm-6">
										<input type="password" placeholder="기존 비밀번호"
											class="form-control" id="mempwd">
											<div id="targetpw"></div>
									</div>
									<input type="button" class="btn btn-default" value="비밀번호 변경"
										id="chbtn" name="chbtn">
										
								</div>
								<div class="dhpwd">
									<div class="form-group">
										<label class="col-sm-3 control-label" for="textinput">새
											비밀번호 </label>
										<div class="col-sm-6">
											<input type="password" placeholder="새 비밀번호"
												class="form-control" id="mempwd1">
												
										</div>
										
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label" for="textinput">새
											비밀번호 재 확인 </label>
										<div class="col-sm-6">
											<input type="password" placeholder="새 비밀번호 확인"
												class="form-control" id="mempwd2" name="mempwd">
												<div id="targetpwd"></div>
										</div>
										
									</div>
									
								</div>
								<!-- Text input-->
								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput">우편번호</label>
									<div class="col-sm-3">
										<input type="text" class="form-control"
											id="sample6_postcode1">
									</div>
									<div class="col-sm-3">
										<input type="text" class="form-control"
											id="sample6_postcode2">
									</div>

									<input type="button" class="btn btn-default"
										onclick="sample6_execDaumPostcode()" value="우편번호 찾기">

								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput">주소</label>
									<div class="col-sm-6">
										<input type="text" placeholder="주소" class="form-control"
											id="sample6_address">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label" for="textinput">상세주소</label>
									<div class="col-sm-6">
										<input type="text" placeholder="상세주소" class="form-control"
											id="sample6_address2">
									</div>
								</div>
								<div class="form-group" style="text-align: center;">
									

										<button type="button" class="btn btn-primary" id="btn">
											<i class="fa fa-floppy-o"></i>
										</button>
							
								</div>
							</div>

						</div>
						</div>
				</form>
				</div>

			</div>
		</div>
	</div>
</div>
