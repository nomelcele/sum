<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sumware Admin</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<!-- CSS 라이브러리(S)  -->
<spring:url value="resources/css/common.css" var="css" />
<spring:url value="resources/font-awesome/css/font-awesome.css" var="font" />
<spring:url value="resources/font-awesome/css/font-awesome.min.css" var="font2" />
<spring:url value="resources/css/bootstrap.min.css" var="boot" />
<spring:url value="resources/css/bootstrap.vertical-tabs.css" var="admin"/>
<!-- <link rel="stylesheet" href="resources/css/bootstrap.vertical-tabs.css"> -->
<!-- <link rel="stylesheet" href="resources/css/tabs.css"> -->
<!-- <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"> -->
<!--   <link rel="stylesheet" href="resources/css/bootstrap.vertical-tabs.css"> -->
<!--   <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script> -->
<!--   <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script> -->

<link rel="stylesheet" type="text/css" href="${css }" />
<link rel="stylesheet" type="text/css" href="${font }" />
<link rel="stylesheet" type="text/css" href="${font2}" />
<link rel="stylesheet" type="text/css" href="${boot}" />

<!-- CSS 라이브러리(E)  -->
<!-- js, MODAL (S) -->
<script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="js/sumware.js"></script>
<script src="js/admin.js"></script>
<!-- js (E) -->
</head>
<body>
	<!-- header -->
	<tiles:insertAttribute flush="true" name="header" />
	<div class="wrap-layout board" id="global">
		<c:if test="${!empty sessionScope.adminv }">
		<div class="lnb-area" id="lnb-area">
			<!-- menu -->
			<tiles:insertAttribute flush="true" name="menu" />
		</div>
		</c:if>
		<div class="contents">
			<!-- body -->
			<tiles:insertAttribute flush="true" name="body" />
		</div>
	</div>
	<!-- footer -->
	
	<tiles:insertAttribute flush="true" name="footer" />
</body>
</html>