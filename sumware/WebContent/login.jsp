<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div id="carousel-example" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example" data-slide-to="1"></li>
                    <li data-target="#carousel-example" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="http://www.prepbootstrap.com/Content/images/template/carouselstaticheader/slide_03.jpg" alt="First slide" />
                        <div class="carousel-caption">
                            <h3>Product A</h3>
                            <p>
                                Best Suitable for individuals...
                            </p>
                            <p><a class="btn btn-clear btn-sm btn-min-block" href="#">More Details</a></p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="http://www.prepbootstrap.com/Content/images/template/carouselstaticheader/slide_02.jpg" alt="Second slide" />
                        <div class="carousel-caption">
                            <h3>Product B</h3>
                            <p>
                                Best Suitable for small businesses 
                            </p>
                            <p><a class="btn btn-clear btn-sm btn-min-block" href="#">More Details</a></p>
                        </div>
                    </div>
                    <div class="item">
                        <img src="http://www.prepbootstrap.com/Content/images/template/carouselstaticheader/slide_01.jpg" alt="Third slide" />
                        <div class="carousel-caption">
                            <h3>Product B</h3>
                            <p>
                                Best Suitable for small businesses 
                            </p>
                            <p><a class="btn btn-clear btn-sm btn-min-block" href="#">More Details</a></p>
                        </div>
                    </div>
                </div>

                <!-- Left and right controls -->
                <a class="left carousel-control" href="#carousel-example" role="button" data-slide="prev">
                    <span class="fa fa-arrow-left" aria-hidden="true"></span>
                </a>
                <a class="right carousel-control" href="#carousel-example" role="button" data-slide="next">
                    <span class="fa fa-arrow-right" aria-hidden="true"></span>
                </a>
            </div>
            <div class="main-text hidden-xs">
                <div class="col-md-12 text-center">
                    <h1>Affordable products</h1>
                    <h3>Pick up the one that suits you best
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- --%>
<div class="container">
	<form class="form-inline" role="form" action="sumware" method="post">
		<input type="hidden" name="model" value="login"> <input
			type="hidden" name="submod" value="login">
		<div class="porm-group">
			<label class="control-label-" for="sabun"> 사원번호 :</label> <input
				type="text" id="memnum" name="memnum" placeholder="사원번호"> <label
				class="control-label" for="Password"> 비밀번호 :</label> <input
				type="password" id="mempwd" name="mempwd" placeholder="비밀번호">
			<button type="submit" class="btn btn-xs btn-info">로그인</button>
		</div>
	</form>
</div>