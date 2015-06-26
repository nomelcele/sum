<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="memlist" items="${memberjoblist }">
	<img src="profileImg/${memlist.memprofile }" class="img-circle" style="width:60px; height:70px">
</c:forEach>