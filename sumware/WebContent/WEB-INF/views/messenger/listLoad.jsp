<%@page import="com.sumware.mvc.dao.MessengerDao"%>
<%@page import="com.sumware.dto.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setHeader("cache-control", "no-cache");
	response.setContentType("text/event-stream");
	
	System.out.println("사용자 List 출력, listLoad.jsp");
	// 현재 사용자 정보를 가져옴
	MemberVO v = (MemberVO)session.getAttribute("v");
	int userNum = v.getMemnum();
	
	// DB에서 검색한 사원 정보를  list에 저장
	ArrayList<MemberVO> list = MessengerDao.getDao().getList(userNum);
	System.out.println("listLoad Array size : "+list.size());
	
	StringBuffer outs = new StringBuffer();
	outs.append("data:");
	System.out.println("userNum : "+userNum);
	for(MemberVO e : list){
		outs.append("<tr>");
		outs.append("<td>");		
		outs.append("<img src='profileImg/");
		outs.append(e.getMemprofile());
		outs.append("' alt='' class='img-circle' style='width: 50px; height: 50px;'>");
		outs.append("<a href='javascript:mesgoUrl(");
		outs.append(e.getMemnum());
		outs.append(")' class='primary-font'>");
		outs.append("<strong class='primary-font'>");
		outs.append(e.getMemname());
		outs.append("</strong>");
		outs.append("<strong class='primary-font'>");
		outs.append(e.getMemnum());
		outs.append("</strong>");
		outs.append("<strong class='primary-font'>");
		outs.append(e.getDename());
		outs.append("</strong>");		
		outs.append("</a>");
		outs.append("</td>");
		outs.append("</tr>");
	}
	outs.append("\n\n");
	System.out.println("전송될 파라미터 : "+outs);
%><%=outs %>	
	