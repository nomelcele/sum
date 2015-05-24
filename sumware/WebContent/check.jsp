<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = request.getParameter("toNum");
	String seskey = request.getParameter("key");
	int toNum = Integer.parseInt(num);
	int sessionkey = Integer.parseInt(seskey);
	System.out.println("toNum"+toNum);
	System.out.println("seskey"+sessionkey);


%>

