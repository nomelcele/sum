package model;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import controller.ModelForward;
import dao.LoginDao;
import dao.MemberDao;
import dto.MemberVO;

public class LoginModel implements ModelInter {

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String submod = request.getParameter("submod");
		System.out.println("submod:" + submod);
		String url = "index.jsp";
		boolean method = false;
		
		if (submod != null && submod.equals("login")) {
			MemberVO vo = null;
			int memnum = Integer.parseInt(request.getParameter("memnum"));
			String mempwd = request.getParameter("mempwd");
			System.out.println("memnum:"+memnum);
			System.out.println("mempwd:"+mempwd);
			MemberVO v = new MemberVO();
			v.setMemnum(memnum);
			v.setMempwd(mempwd);

			try {
				String res = LoginDao.getDao().ckFirstLogin(memnum, mempwd);

				System.out.println("res:::"+res);		
				if (res.equals("1")) {
					
					System.out.println("첫번째 이용자다!!!!");
					System.out.println("사원 번호: "+memnum);
					System.out.println("사원 비번: "+mempwd);
					HttpSession session = request.getSession();
					session.setAttribute("memnum", memnum);
					session.setAttribute("mempwd", mempwd);
					url="join/firstmember.jsp";
					//회원정보입력창으로 이동.
					//이동후에 memnum입력란에 자동으로 입력시켜주고
					//mempwd는 유효성검사 할때 쓰기위하여 보냄.
		
				} else if(!res.equals("1")&&!res.equals("0")){
					System.out.println("ddddddddd");
					vo = LoginDao.getDao().login(v);
					// sessionScope에 아이디를 저장
					HttpSession session = request.getSession();
					session.setAttribute("v", vo);
					System.out.println("memnum::"+v.getMemnum());
					//login 기록 저장.
					LoginDao.getDao().inLog(memnum);	
				}else{
					url="join/error.jsp";
					method=true;
				}

			} catch (SQLException e) {

				e.printStackTrace();
			}
			method = true;

		} else if (submod != null && submod.equals("logout")) {
			System.out.println("로그아웃~!");
			url = "index.jsp";
			int memnum = Integer.parseInt(request.getParameter("memnum"));
			LoginDao.getDao().outLog(memnum);
			
			HttpSession session = request.getSession();
			//저장된 세션 다 날림.
			session.removeAttribute("v");
			session.removeAttribute("teamNameList");
			method = false;


		}else if(submod != null && submod.equals("firstLoginForm")){
			url = "join/member.jsp";
			method=true;
		}
		System.out.println("url : " + url + " method : " + method);
		return new ModelForward(url, method);
	}

}
