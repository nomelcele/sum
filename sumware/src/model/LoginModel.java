package model;

import java.io.IOException;
import java.sql.SQLException;

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

			int memnum = Integer.parseInt(request.getParameter("memnum"));
			String mempwd = request.getParameter("mempwd");
			// System.out.println("memnum : "+memnum);
			// System.out.println("mempwd : "+mempwd);

			MemberVO v = new MemberVO();
			v.setMemnum(memnum);
			v.setMempwd(mempwd);
			try {
				MemberVO vo = LoginDao.getDao().login(v);
				
				if (vo != null) {
					String res = LoginDao.getDao().ckFirstLogin(memnum);
					if(res.equals("0")){
						
						request.setAttribute("memnum", memnum);
						request.setAttribute("mempwd", mempwd);
						//회원정보입력창으로 이동.
						//이동후에 memnum입력란에 자동으로 입력시켜주고
						//mempwd는 유효성검사 할때 쓰기위하여 보냄.
						url="";
					}else{
						url = "main.jsp";
						// sessionScope에 아이디를 저장
						HttpSession session = request.getSession();
						session.setAttribute("v", vo);
						//login 기록 저장.
						LoginDao.getDao().enterLog(memnum);	
					}
				} else {
					// 로그인 실패
				}

			} catch (SQLException e) {

				e.printStackTrace();
			}
			
			method = true;

		} else if (submod != null && submod.equals("logout")) {
			url = "";
			String memnum = request.getParameter("memnum");
			HttpSession session = request.getSession();
			//저장된 세션 다 날림.
			session.invalidate();
			method = true;

		}
		System.out.println("url : " + url + "method : " + method);
		return new ModelForward(url, method);
	}

}
