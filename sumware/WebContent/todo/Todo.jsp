<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 부서 업무 부분 뷰 -->

<div class="row">
	

	<div class="wrap">
		<%@include file="/contentLeft.jsp" %>
		<!-- 부서업무 부분!! -->
		<div class="col-lg-2" style="width: 35%">
			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> <strong class="primary-font">부서업무</strong>
				</div>
				<div class="panel-body">
					<div class="column" style="overflow: auto">
						<div class="low-lg-1">
							<div class="panel panel-success">
								<div class="panel-heading">Primary Panel</div>
								<div class="panel-body">
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Vestibulum tincidunt est vitae ultrices accumsan. Aliquam
										ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>
								</div>
								<div class="panel-footer">Panel Footer</div>
							</div>
						</div>
						<div class="row-lg-2">
							<div class="panel panel-success">
								<div class="panel-heading">Primary Panel</div>
								<div class="panel-body">
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Vestibulum tincidunt est vitae ultrices accumsan. Aliquam
										ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>
								</div>
								<div class="panel-footer">Panel Footer</div>
							</div>
						</div>
						<!-- /.col-lg-4 -->
						<div class="row-lg-3">
							<div class="panel panel-success">
								<div class="panel-heading">Success Panel</div>
								<div class="panel-body">
									<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
										Vestibulum tincidunt est vitae ultrices accumsan. Aliquam
										ornare lacus adipiscing, posuere lectus et, fringilla augue.</p>
								</div>
								<div class="panel-footer">Panel Footer</div>
							</div>
						</div>
						<!-- /.col-lg-4 -->
					</div>
				</div>
			</div>
		</div>
		<!-- 부서업무 부분 끝!!! -->
		<%@include file="todoSns.jsp" %>
	</div>
	</div>

