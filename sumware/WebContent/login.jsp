<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- --%>
<div class="container">
   <div id="carousel1" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
         <div class="item active">
            <img alt="Bootstrap template" src="img/slide_01.jpg">
         </div>
         <div class="item">
         <c:if test="${sessionScope.v.memnum eq null}">
            <img alt="Bootstrap template" src="img/slide_02.jpg">
           </c:if>
           <c:if test="${sessionScope.v.memnum ne null}">
           <img alt="Bootstrap template" src="img/slide_02.jpg" onclick="location='sumware?model=board&submod=boardList&page=1&bdeptno=${sessionScope.v.memdept }&bgnum=0&bname=공지사항'" style="cursor:pointer">
           </c:if>
           
         </div>

         <div class="item">
         	<c:if test="${sessionScope.v.memnum eq null}">
         	<img alt="Bootstrap template" src="img/slide_03.jpg">
         	</c:if>
         	<c:if test="${sessionScope.v.memnum ne null}">
            <img alt="Bootstrap template" src="img/slide_03.jpg" onclick="location='sumware?model=calendar&submod=calList'" style="cursor:pointer">
            </c:if>
         </div>
      </div>
      <ul class="nav nav-justified">
         <li data-target="#carousel1" data-slide-to="0" class="active"><a
            href="#"><i class="fa fa-suitcase"></i> 회사 소개</a></li>
         <li data-target="#carousel1" data-slide-to="1"><a href="#"><i class="fa fa-pencil"></i> 공지 사항</a>
         </li>
         <li data-target="#carousel1" data-slide-to="2"><a href="#"><i class="fa fa-calendar"></i> 주요 일정</a>
         </li>
      </ul>
   </div>
   <div class="container">
   </div>
</div>
