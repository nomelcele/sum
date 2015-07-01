<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		<div style="text-align: right;padding: 10px;">
			<input type="button" class="btn btn-outline btn-primary btn-xs" id="calDept" value="부서일정" onclick="location='calList?cal=0'">
			<input type="button" class="btn btn-outline btn-primary btn-xs" id="calMem" value="사원일정" onclick="location='calList?cal=1'">
		</div>
		<div id='calendar'></div>
