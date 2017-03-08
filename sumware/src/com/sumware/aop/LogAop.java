package com.sumware.aop;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.LoginDao;

@Component
@Aspect
public class LogAop {
	@Autowired
	private LoginDao logDao;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession session;
	@AfterReturning(pointcut="execution(* com.sumware.mvc.dao.Lo*.ckFirstLogin(..))",returning="ret")
	public void inLog(JoinPoint jp,Object ret){
//		System.out.println("로그인 기록을 남기자~!");
		String res = String.valueOf(ret);
//		System.out.println(res);
		if(!res.equals("1")&&!res.equals("0")){
		int memnum = Integer.parseInt(res);
		logDao.inLog(memnum);
		}
	}
	@Before("execution(* com.sumware.mvc.controller.Lo*.logout(..))")
	public void outLog(JoinPoint jp){
//		System.out.println("로그아웃 기록을 남기자~");
		MemberVO mv = (MemberVO) session.getAttribute("v");
		if(mv!=null){
			logDao.outLog(mv.getMemnum());
		}
	}
}
