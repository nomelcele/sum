<%@page import="util.Suggest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
[<%
 // 모델에서 수행하도록 수정
 // 모델2로 변환할 때-> 모델에서 받게 하고 suggests 배열 값을 attribute로 보내서 foreach 문으로 돌린다.
 	System.out.println("mailSuggest.jsp 들어옴");
 	request.setCharacterEncoding("UTF-8");
	String key = request.getParameter("key");
	System.out.println("입력한 값: "+key);
	
	String[] suggests = Suggest.getSuggest().getSuggest(key); // 배열 리턴
	if(suggests != null){
		for(int i=0; i<suggests.length; i++){
%>"<%=suggests[i]%>"<% if(!(i == suggests.length-1)){out.print(",");} %>			
<%}}%>]