package com.sumware.aop;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.MailDao;

@Component
@Aspect
public class MailAop {
	@Autowired
	private HttpSession session;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private MailDao mailDao;
	@Before("execution(* com.sumware.mvc.controller.Ma*.*(..))")
	public void mail(){
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("usernum",String.valueOf(mvo.getMemnum()));
		map.put("userid", mvo.getMeminmail());
		int[] numArr = mailDao.getListNum(map);
//	 	for(int e:numArr){
//	 		System.out.println("메일 갯수: "+e);
//	 	}
	 	request.setAttribute("numArr", numArr);
	}
}
