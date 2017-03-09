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
	
	// Before Advice를 적용할 메서드 설정
	@Before("execution(* com.sumware.mvc.controller.Ma*.*(..))")
	public void mail(){
		// 메일 관련 페이지에 있을 때, 항상 좌측에 각 메일함의 이름과 함께 그 메일함에 있는 메일의 수를 표시
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("usernum",String.valueOf(mvo.getMemnum()));
		map.put("userid", mvo.getMeminmail());
		// 받은 메일함, 보낸 메일함, 내게 쓴 메일함, 휴지통에 있는 메일 개수를 셈
		int[] numArr = mailDao.getListNum(map);
//	 	for(int e:numArr){
//	 		System.out.println("메일 갯수: "+e);
//	 	}
		// 좌측 메뉴(contentLeft)에서 메일 수 표시
	 	request.setAttribute("numArr", numArr);
	}
}
