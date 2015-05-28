<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 부서 업무 부분 뷰 ajax -->



			<div class="chat-panel panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-pencil-square-o"></i> <strong class="primary-font">부서업무</strong>
				</div>
				<div class="panel-body">
					<div class="column" style="overflow: auto">
					<c:forEach var="deptjoblist" items="${deptJobList }">
						
						
						<div class="low-lg-${deptjoblist.tonum }">
							<div class="panel panel-success">
								<div class="panel-heading">
								<i class="fa fa-pencil"></i>
								${deptjoblist.totitle }
								</div>
								<div class="panel-body">
									<p><i class="fa fa-user"></i> manager : ${deptjoblist.memname }
									<p><i class="fa fa-calendar-o"></i> date : ${deptjoblist.tostdate } ~
													${deptjoblist.toendate }</p>
		
									
								</div>
								<div class="panel-footer">
									
									<a class="fa fa-align-justify" 
									onclick="javascript:getJobDetail(${deptjoblist.tonum })"
									style="cursor:pointer"> detail</a>
									<div id="memlisttarget${deptjoblist.tonum }" style="display:none"></div>
									<div id="detail${deptjoblist.tonum }" style="display:none">
									<br/>
									<p>${deptjoblist.tocont }</p>
									<p>첨부파일 다운로드 부분</p>
									</div>
									
								</div>
								
							</div>
						</div>
					
					
					</c:forEach>
						
						
						<!-- /.col-lg-4 -->
					</div>
				</div>
			</div>


