<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setHeader("cache-control", "no-cache");
response.setContentType("text/event-stream");
%>
${outs }
