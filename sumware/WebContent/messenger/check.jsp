<%@page import="dto.MemberVO"%>
<%@page import="dao.MessengerDao"%>
<%@page import="dto.MessengerVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	response.setHeader("cache-control", "no-cache");
	response.setContentType("text/event-stream");
	
	System.out.println("서버 푸시 영역");
	
	MemberVO v = (MemberVO)session.getAttribute("v");
	int userNum = v.getMemnum();
	int memberNum = 0;
	String openyn = null;
	String stdate = "default";
	int mesendNum = 0;
	
	// DB에서 userNum(받는 사람 사번)인 경우만 조회해서 list에 저장
	ArrayList<MessengerVO> list = MessengerDao.getDao().getentList(userNum);
	StringBuffer outs = new StringBuffer();
	outs.append("data:");
	for(MessengerVO e : list){
		
		memberNum=e.getMesmember(); // 사용자가 userNum인 경우만 참가자 목록 조회

		openyn = e.getOpenmemberyn();
		System.out.println("openyn : "+openyn);
		System.out.println("memberNum : "+memberNum);		
		System.out.println("userNum : "+userNum);

		stdate = e.getEntstdate();
		
		if(memberNum == userNum && openyn.equals("N") && stdate == null ){ // 받는 사람 
			System.out.println("방번호는 : "+e.getMesnum());
			outs.append(e.getMesnum()); // 방번호
			outs.append("/");
			outs.append(e.getMesreip()); // 방장 ip
			outs.append("/");
			outs.append(e.getMesmember()); // 수신자 사번
			outs.append("/");
			outs.append(e.getMesendnum()); // 송신자 사번			
			outs.append("\n\n");
%><%=outs %> <%	
		 } 		
 	
		 else{
			
		}		

	} 
	%>

