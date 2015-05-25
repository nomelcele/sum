<%@page import="dto.MemberVO"%>
<%@page import="dao.MessengerDao"%>
<%@page import="dto.MessengerVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	response.setHeader("cache-control", "no-cache");
	response.setContentType("text/event-stream");
	
	ArrayList<MessengerVO> list = MessengerDao.getDao().getentList();
	StringBuffer outs = new StringBuffer();
	outs.append("data:");
	for(MessengerVO e : list){
		
		int memberNum = e.getMesmember();
// 		System.out.println("memberNum : "+memberNum);
		MemberVO v = (MemberVO)session.getAttribute("v");
		int userNum = v.getMemnum();
// 		System.out.println("userNum : "+userNum);
		String openyn = e.getOpenmemberyn();
// 		System.out.println("openyn : "+openyn);
		if(memberNum == userNum && openyn.equals("N")){
			System.out.println("방번호는 : "+e.getMasnum());
			outs.append(e.getMasnum());
			outs.append("/");
			outs.append(e.getMesmember());
			System.out.println("회원 체크 if문");
		} else{
			
		}		
// 		e.getMasnum();
// 		e.getMesmember();
// 		e.getOpenmemberyn();
// 		e.getEntstdate();
// 		e.getEntendate();
	} outs.append("\n\n");
%><%=outs %>

