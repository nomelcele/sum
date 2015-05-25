<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <c:forEach var="memjobList" items="${membersjoblist}">
    	<p><img src="../profileImg/${memjobList.memprofile }" class="img-circle" style="width:20px">${memjobList.memname } : ${memjobList.jobcont }</p>
    </c:forEach>