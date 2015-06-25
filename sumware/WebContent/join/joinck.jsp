<%@page import="com.sumware.mvc.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String meminmail = request.getParameter("meminmail");
	System.out.println("meminmail:"+meminmail);
	int res = MemberDao.getDao().ckid(meminmail);
	if(res==1){
		%>
		<p>사용 불가능한 아이디입니다.</p>
		<%
	}else{
		%>
		<p>사용가능한아이디입니다.</p>
		<%
	}
%>
