<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<img src="aucImg/${provo.proimg}" style="width: 300px;">
<span>${provo.product }</span>
<span>${provo.price}</span>
<button type="button" id="bidBtn" onclick="javascript:bidBtn()">입찰하기</button>
<div id="bidTarget"></div>
