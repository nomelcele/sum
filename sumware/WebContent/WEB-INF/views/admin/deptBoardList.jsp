<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- Search (S) -->
		<div>
			<select id="searchDept" onchange="getDeptBoards()">
				<option value="0">부서</option>
				<option value="100">인사부</option>
				<option value="200">총무부</option>
				<option value="300">영업부</option>
				<option value="400">전산부</option>
				<option value="500">기획부</option>
			</select>
			<select id="searchDeptBoard">
				<option value="0">게시판</option>
			</select>
			&nbsp;
			<input type="button" class="btn btn-default btn-sm" value="게시판 보기" onclick="getDeptBoardList()">
			<br/><br/>
		</div>
	<!-- Search (E) -->
	
	<!-- Board -->
	<div id="deptBoard"></div>
