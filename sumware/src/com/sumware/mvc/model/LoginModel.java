package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.LoginDao;


@Controller
public class LoginModel{
	@Autowired
	private LoginDao dao;
	
	@RequestMapping(value="login")
	public void login(MemberVO mvo,HttpSession session,HttpServletResponse response) throws IOException{
		String result="home.index";
		try {
			String res = dao.ckFirstLogin(mvo);

			System.out.println("res:::"+res);		
			if (res.equals("1")) {
				
				System.out.println("첫번째 이용자다!!!!");
				session.setAttribute("memnum", mvo.getMemnum());
				session.setAttribute("mempwd", mvo.getMempwd());
				
				result="1";
				//회원정보입력창으로 이동.
				//이동후에 memnum입력란에 자동으로 입력시켜주고
				//mempwd는 유효성검사 할때 쓰기위하여 보냄.
	
			} else if(!res.equals("1")&&!res.equals("0")){
				System.out.println("ddddddddd");
				mvo = dao.login(mvo);
				// sessionScope에 아이디를 저장
				session.setAttribute("v", mvo);
				//login 기록 저장.
//				dao.inLog(mvo.getMemnum());	
			}else{
				result="0";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();
	}
	
	@RequestMapping(value="logout")
	public void logout(int memnum,HttpSession session,HttpServletResponse response) throws IOException{
		System.out.println("로그아웃 컨트롤러");
//		dao.outLog(memnum);
		session.removeAttribute("v");
		session.removeAttribute("teamNameList");
		session.invalidate();
		PrintWriter pw = response.getWriter();
		pw.write("success");
		pw.flush();
		pw.close();
	}
	
	@RequestMapping(value="firstLoginForm")
	public String firstLoginForm(HttpSession session){
		System.out.println("첫번째 이용자!! 정보를 입력해볼까??");
		session.setAttribute("model", "memjoin");
		return "join.member";
	}
}
