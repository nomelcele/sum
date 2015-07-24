<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
	<form method="post" action="sagetSignList" id="searchSignForm">
		<input type="hidden" name="page" value="${signPage }">
		<input type="hidden" name="memdept" value="${sessionScope.v.memdept }">
		<input type="hidden" id="selectDay" name="selectDay">
		<input type="hidden" id="except" name="except">
		
	<!-- Search (S) -->
		<div style="border: solid; border-color:gray; margin-bottom: 15px; width: 800px">
		<table>
		<tr>
		<td style="width: 651px;">
			<div>
				<input value="검색 일자 : " style="border: 0px; width: 80px; margin-left: 20px;"readonly="readonly">
				<input type="date" id="searchStartDay" name="searchStartDay" value="${searchInfo.searchStartDay }"> 부터 <input type="date" id="searchEndDay" name="searchEndDay" value="${searchInfo.searchEndDay }" style=" margin-top: 10px;margin-bottom: 10px">까지
				<input class="btn btn-default btn-sm" type="button" id="searchTodayBtn" value="오늘" onclick="javascript:searchSignList(this)">&nbsp;
				<input class="btn btn-default btn-sm" type="button" id="searchWeekBtn" value="7일" onclick="javascript:searchSignList(this)">&nbsp;
				<input class="btn btn-default btn-sm" type="button" id="searchMonthBtn" value="3개월" onclick="javascript:searchSignList(this)" style="margin-right: 5px"><br/>
				
				<input value="문서 검색 : " style="border: 0px; width: 80px;margin-bottom: 10px;  margin-left: 20px;" readonly="readonly">
				<select id="searchType" name="searchType">
					<option value="0">전체</option>
					<c:choose>
						<c:when test="${searchInfo.searchType eq '1'}">
							<option value="1" selected="selected">문서번호</option>
						</c:when>
						<c:otherwise>
							<option value="1">문서번호</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${searchInfo.searchType eq '2'}">
							<option value="2" selected="selected">제목</option>
						</c:when>
						<c:otherwise>
							<option value="2">제목</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${searchInfo.searchType eq '3'}">
							<option value="3" selected="selected">기안자</option>
						</c:when>
						<c:otherwise>
							<option value="3">기안자</option>
						</c:otherwise>
					</c:choose>
				</select>&nbsp;
				<input type="text" id="searchName"  name="searchName" value="${searchInfo.searchName }"><br/>
				
				<input value="문서 종류 : " style="border: 0px; width: 80px; ;margin-bottom: 10px;  margin-left: 20px;"readonly="readonly">
				<select id="searchDocDiv" name="searchDocDiv">
					<option value="0">전체</option>
					<c:forEach var="sf" items="${sfList}">
						<c:choose>
							<c:when test="${searchInfo.searchDocDiv eq sf.sfnum }">
								<option value="${sf.sfnum }" selected="selected">${sf.sfname }</option>
							</c:when>
							<c:otherwise>
								<option value="${sf.sfnum }">${sf.sfname }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>				
				</select><br/>
				
				<input value="문서 상태 : " style="border: 0px; width: 80px; margin-bottom: 10px;  margin-left: 20px;"readonly="readonly"/>
				<select id="searchDocState" name="searchDocState">
					<option value="0">전체</option>
					<c:choose>
						<c:when test="${searchInfo.searchDocState eq '1'}">
							<option value="1" selected="selected">완료</option>
						</c:when>
						<c:otherwise>
							<option value="1">완료</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${searchInfo.searchDocState eq '2'}">
							<option value="2" selected="selected">진행중</option>
						</c:when>
						<c:otherwise>
							<option value="2">진행중</option>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${searchInfo.searchDocState eq '3'}">
							<option value="3" selected="selected">반려</option>
						</c:when>
						<c:otherwise>
							<option value="3">반려</option>
						</c:otherwise>
					</c:choose>
				</select>
				
				<input value="부서 선택 : " style="border: 0px; width: 80px; margin-bottom: 10px;  margin-left: 20px;"readonly="readonly"/>
				<select id="searchDept" name="searchDept">
					<option value="0">전체</option>
					<c:forEach var="dept" items="${deptList}">
						<c:choose>
							<c:when test="${searchInfo.searchDept eq dept.denum }">
								<option value="${dept.denum }" selected="selected">${dept.dename }</option>
							</c:when>
							<c:otherwise>
								<option value="${dept.denum }">${dept.dename }</option>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>	
				</select> 
			</div>
			</td>
			<td style="border-left: solid 1px; border-color: gray; text-align: center; width: 149px">
					<div style="margin-top: 10px; margin-bottom: 10px">
						<input type="button" class="btn btn-default btn-sm" value="검색" onclick="javascript:searchSignList(this)" style="width: 100px; height:40px;"><br/><br/>
						<input type="button" class="btn btn-default btn-sm" value="제외" onclick="javascript:searchSignList(this)" style="width: 100px; height:40px;"><br/><br/>
						<input type="button" class="btn btn-default btn-sm" value="리셋" onclick="javascript:searchReset()" style="width: 100px; height:40px;">
					</div>
				</td>
			</tr>
		</table>
		</div>
		<div style="margin-bottom: 10px">
			<input type="button" class="btn btn-default btn-sm" onclick="signMenu('signAll')" value="전체선택(${signCount0 })">&nbsp; &nbsp;
			<input type="button" class="btn btn-default btn-sm" onclick="signMenu('signReceive')" value="수신 문서(${signCount1 })">&nbsp; &nbsp;
			<input type="button" class="btn btn-default btn-sm" onclick="signMenu('signStandBy')" value="대기 문서(${signCount2 })">&nbsp; &nbsp;
			<input type="button" class="btn btn-default btn-sm" onclick="signMenu('signComplete')" value="완료 문서(${signCount3 })">&nbsp; &nbsp;
			<input type="button" class="btn btn-default btn-sm" onclick="signMenu('signReturn')" value="반려 문서(${signCount4 })">
		</div>
	<!-- Search (E) -->
	<div>
		<table class="table table-condensed table-hover">
			<tbody>
				<tr style="background-color: #F5F5F5;">
					<td class="col-lg-1"><span>번호</span></td>
					<td class="col-lg-2"><span>문서 종류</span></td>
					<td class="col-lg-3"><span>제목</span></td>
					<td class="col-lg-1"><span>기안자</span></td>
					<td class="col-lg-3"><span>기안일</span></td>
					<td class="col-lg-2"><span>결재상태</span></td>
				</tr>
				<c:forEach var="sg" items="${sgList }">
					<tr>
						<td class="col-lg-1"><span>${sg.snum}</span></td>
						<td class="col-lg-2"><span>${sg.sfname }</span></td>
						<td class="col-lg-3"><span><a href="sasignDetail?snum=${sg.snum }">${sg.stitle }</span></td>
						<td class="col-lg-1"><span>${sg.memname }</span></td>
						<td class="col-lg-3"><span>${sg.startdate } ~ ${sg.enddate}</span></td>
						<c:choose>
							<c:when test="${!empty sg.sgreturncomm }">
								<td class="col-lg-2"><span>반려문서</span></td>
							</c:when>
							<c:when test="${sg.ycount ne sg.count }">
								<td class="col-lg-2"><span>진행중(${sg.ycount }/${sg.count })</span></td>	
							</c:when>
							<c:otherwise>
								<td class="col-lg-2"><span>완료</span></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	</form>
	<%-- 원래 위치 --%>
	<div class="paging">
		<c:set var="pageUrl" value="sagetSignList?signdiv=${signdiv}"/>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
				<c:otherwise>
					<%-- <button type="button" class="paging-prev">&lt;&lt;</button> --%>
					<a class="page-first" href="${pageUrl}&page=${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">&lt;&lt;</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
					<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">
						<a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}" end="${pageInfo.totalPages}" varStatus="num">
			            <a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>
			        </c:forEach>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">&gt;&gt;</c:when>
				<c:otherwise>
					<a class="page-last" href="${pageUrl}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">&gt;&gt;</a>
				</c:otherwise>
			</c:choose>
	</div>
<!-- 	<div class='modal' id='signModal' role='dialog'> -->
<!-- 		<div class="modal-dialog"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<button type="button" class="close" data-dismiss="modal">&times;</button> -->
<!-- 					<h4 class="modal-title">결재 문서 선택하기</h4> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body" id="signModalBody"> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
</div>