package model;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.ModelForward;
import dao.MemberDao;
import dto.MemberVO;

public class LoginModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String submod = request.getParameter("submod");
		System.out.println("submod:"+submod);
		String url ="index.jsp";
		boolean method=false;
		if(submod != null && submod.equals("login")){
			
		 String memnum= request.getParameter("memnum");
		 String mempwd = request.getParameter("mempwd");
//		 System.out.println("memnum : "+memnum);
//		 System.out.println("mempwd : "+mempwd);
	
		 MemberVO v = new MemberVO();
		 v.setMemnum(Integer.parseInt(memnum));
		 v.setMempwd(mempwd);
		 try {
			MemberVO vo = MemberDao.getDao().login(v);
			
			if(vo != null){
				// sessionScope에 아이디를 저장
				HttpSession session = request.getSession();
				session.setAttribute("v", vo);
				
			}else{
				//로그인 실패 
			}
			
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
		 url = "sumware?mod=todo&submod=todoForm";
		 method=true;
		 
		 
		} else if(submod != null && submod.equals("logout")){
			url = "";
			HttpSession session = request.getSession();
			session.removeAttribute("mymemnum");
	
			method=true;
			
			
			
			
			
			
		}
		System.out.println("url : "+url+"method : "+method);
		return new ModelForward(url, method);
	}

}