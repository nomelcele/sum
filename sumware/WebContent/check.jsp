<%@page import="dto.MemberVO"%>
<%@page import="dao.MessengerDao"%>
<%@page import="dto.MessengerVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	response.setHeader("cache-control", "no-cache");
	response.setContentType("text/event-stream");
// 	retry: 10000;
	System.out.println("서버 푸시 영역");
	
	MemberVO v = (MemberVO)session.getAttribute("v");
	int userNum = v.getMemnum();
	int memberNum = 0;
	String openyn = null;
	String stdate = "default";
	
	ArrayList<MessengerVO> list = MessengerDao.getDao().getentList(userNum);
	StringBuffer outs = new StringBuffer();
	outs.append("data:");
	for(MessengerVO e : list){
		
		memberNum=e.getMesmember();

		openyn = e.getOpenmemberyn();
		System.out.println("openyn : "+openyn);
		System.out.println("memberNum : "+memberNum);		
		System.out.println("userNum : "+userNum);

		stdate = e.getEntstdate();		
		
		if(memberNum == userNum && openyn.equals("N") && stdate == null ){
			System.out.println("방번호는 : "+e.getMasnum());
			outs.append(e.getMasnum());
			outs.append("/");
			outs.append(e.getMesmember()); // userNum을 보내고 있으나 추가적으로 IP주소를 전송하도록
			outs.append("\n\n");
%><%=outs %> <%	
		 } 		
 	
		 else{
			
		}		

	} 
	%>

