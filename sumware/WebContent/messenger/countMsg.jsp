<%@page import="dao.MessengerDao"%>
<%@page import="dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	response.setHeader("cache-control", "no-cache");
	response.setContentType("text/event-stream");
	System.out.println("Main Push 영역");
	
	MemberVO v = (MemberVO)session.getAttribute("v");
	int userNum = v.getMemnum();
	int countNum = MessengerDao.getDao().countRoomNum(userNum);
	StringBuffer outs = new StringBuffer();
	outs.append("data:");
	outs.append("(");
	outs.append(countNum);
	outs.append(")");
	outs.append("\n\n");
	System.out.println("Count Num 메세지 송신 시 전송될 파라미터 : "+outs);
%>
<%=outs %>