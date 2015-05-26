<%@page import="util.MakeXML"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MakeXML.updateXML();
	// 사원의 이름+아이디가 저장된 xml 파일
	// 회원이 추가될 때마다 업데이트되도록 고칠 것
%>