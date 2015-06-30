package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
				
				result="join/firstmember";
				//회원정보입력창으로 이동.
				//이동후에 memnum입력란에 자동으로 입력시켜주고
				//mempwd는 유효성검사 할때 쓰기위하여 보냄.
	
			} else if(!res.equals("1")&&!res.equals("0")){
				System.out.println("ddddddddd");
				mvo = dao.login(mvo);
				// sessionScope에 아이디를 저장
				session.setAttribute("v", mvo);
				//login 기록 저장.
				dao.inLog(mvo.getMemnum());	
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
		dao.outLog(memnum);
		session.removeAttribute("v");
		session.removeAttribute("teamNameList");
		session.invalidate();
		PrintWriter pw = response.getWriter();
		pw.write("success");
		pw.flush();
		pw.close();
	}
	
	@RequestMapping(value="firstLoginForm")
	public String firstLoginForm(){
		return "join/member";
	}
	
//	@Override
//	pubString submod = request.getParameter("submod");
//		System.out.println("submod:" + submod);
//		String url = "index.jsp";
//		boolean method = false;
//		
//		if (submod != null && submod.equals("login")) {
//			MemberVO vo = null;
//			int memnum = Integer.parseInt(request.getParameter("memnum"));
//			String mempwd = request.getParameter("mempwd");
//			System.out.println("memnum:"+memnum);
//			System.out.println("mempwd:"+mempwd);
//			MemberVO v = new MemberVO();
//			v.setMemnum(memnum);
//			v.setMempwd(mempwd);
//
//			try {
//				String res = LoginDao.getDao().ckFirstLogin(memnum, mempwd);
//
//				System.out.println("res:::"+res);		
//				if (res.equals("1")) {
//					
//					System.out.println("첫번째 이용자다!!!!");
//					System.out.println("사원 번호: "+memnum);
//					System.out.println("사원 비번: "+mempwd);
//					HttpSession session = request.getSession();
//					session.setAttribute("memnum", memnum);
//					session.setAttribute("mempwd", mempwd);
//					url="join/firstmember.jsp";
//					//회원정보입력창으로 이동.
//					//이동후에 memnum입력란에 자동으로 입력시켜주고
//					//mempwd는 유효성검사 할때 쓰기위하여 보냄.
//		
//				} else if(!res.equals("1")&&!res.equals("0")){
//					System.out.println("ddddddddd");
//					vo = LoginDao.getDao().login(v);
//					// sessionScope에 아이디를 저장
//					HttpSession session = request.getSession();
//					session.setAttribute("v", vo);
//					System.out.println("memnum::"+v.getMemnum());
//					//login 기록 저장.
//					LoginDao.getDao().inLog(memnum);	
//				}else{
//					url="join/error.jsp";
//					method=true;
//				}
//
//			} catch (SQLException e) {
//
//				e.printStackTrace();
//			}
//			method = true;
//
//		} else if (submod != null && submod.equals("logout")) {
//			System.out.println("로그아웃~!");
//			url = "index.jsp";
//			int memnum = Integer.parseInt(request.getParameter("memnum"));
//			LoginDao.getDao().outLog(memnum);
//			
//			HttpSession session = request.getSession();
//			//저장된 세션 다 날림.
//			session.removeAttribute("v");
//			session.removeAttribute("teamNameList");
//			session.invalidate();
//			method = false;
//
//
//		}else if(submod != null && submod.equals("firstLoginForm")){
//			url = "join/member.jsp";
//			method=true;
//		}
//		System.out.println("url : " + url + " method : " + method);
//		return new ModelForward(url, method);
//	}

}
