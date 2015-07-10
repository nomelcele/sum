<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${!empty sessionScope.adminv }">
<div id="MainMenu">
  <div class="list-group panel">
    <a href="#demo3" class="list-group-item strong" data-toggle="collapse" data-parent="#MainMenu">사원 관리 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo3">
      <a href="javascript:adminSelectMenu('adminMemList')" class="list-group-item">&nbsp; &nbsp; 사원 조회</a>
      <a href="javascript:adminSelectMenu('addMem')" class="list-group-item">&nbsp; &nbsp; 사원 입사 처리</a>
    </div>
    <a href="#demo4" class="list-group-item strong" data-toggle="collapse" data-parent="#MainMenu">급여 관리 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo4">
      <a href="javascript:adminSelectMenu('adminPayInfoList')" class="list-group-item">&nbsp; &nbsp; 급여 조회</a>
      <a href="javascript:adminSelectMenu('adminPayManagement')" class="list-group-item">&nbsp; &nbsp; 급여 지급</a>
    </div>
    <a href="#demo5" class="list-group-item strong" data-toggle="collapse" data-parent="#MainMenu">전자결재 양식 관리 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo5">
      <a href="#" class="list-group-item">&nbsp; &nbsp; 양식 목록</a>
      <a href="javascript:adminSelectMenu('addSignForm')" class="list-group-item">&nbsp; &nbsp; 양식 추가</a>
    </div>
     <a href="#demo6" class="list-group-item strong" data-toggle="collapse" data-parent="#MainMenu">게시판 관리 <i class="fa fa-caret-down"></i></a>
    <div class="collapse" id="demo6">
      <a href="javascript:adminSelectMenu('adminBoardListMain')" class="list-group-item">&nbsp; &nbsp; 게시판 열람</a>
      <a href="javascript:adminSelectMenu('addBoard')" class="list-group-item">&nbsp; &nbsp; 게시판 추가</a>
      <a href="javascript:adminSelectMenu('adminDeleteBoardForm')" class="list-group-item">&nbsp; &nbsp; 게시판 삭제</a>
    </div>
  </div>
</div>
</c:if>

