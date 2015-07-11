<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Search (S) -->
		<div>
			<input type="text" id="searchName" placeholder="양식 이름">
			<input type="button" class="btn btn-default btn-sm" value="검색" onclick="adminSelectMenu('FormList')">
			<br/><br/>
		</div>
	<!-- Search (E) -->
	<!-- List (S) -->
    	<div>
			<table class="table table-condensed table-hover" id="listTable">
				<tbody>
					<tr style="background-color: #F5F5F5;">
						<td class="col-lg-1"><span>NO</span></td>
						<td class="col-lg-1"><span>양식 이름</span></td>
						<td class="col-lg-1"></td>
						
					</tr>
					
					<c:forEach var="sflist" items="${sfvoList}">
						<tr>
							<td>${sflist.sfnum}</td>
							<td>${sflist.sfname}</td>
							<td>
								<input type="button" class="btn btn-default btn-sm"  data-toggle="modal" data-target="#signFormDetail${sflist.sfnum}" value="상세 보기" >
							<!-- 							Modal(S) 양식 보기 -->
									<div class="modal fade" id="signFormDetail${sflist.sfnum}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title">${sflist.sfname}</h4>
												</div>
												<div class="modal-body">
													<div class="panel-body"align="center">${sflist.sform}</div>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default"
														data-dismiss="modal">닫기</button>
												</div>
											</div>
					
										</div>
									</div>
<!-- 				Modal(E) -->
								<input type="button" class="btn btn-default btn-sm" value="삭 제"  onclick="javascript:deleteSignForm(${sflist.sfnum})">
							</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- List (E) -->
		
	