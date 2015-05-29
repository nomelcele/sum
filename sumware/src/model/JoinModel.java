package model;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.CaptchasDotNet;
import util.MyMap;
import controller.ModelForward;
import dao.MemberDao;

public class JoinModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
	
		String submod= request.getParameter("submod");
		System.out.println("join submod:::::"+submod);
		String url="";
		boolean method = false;
		if(submod !=null && submod.equals("memberForm")){
			
			
			url ="join/member.jsp";
			method=true;
			
		}else if(submod !=null && submod.equals("signup")){
			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
			MemberDao.getDao().update(map);
			HttpSession session = request.getSession();
			session.invalidate();
			
			url="index.jsp";
			method=true;
		}else if(submod != null && submod.equals("viewCap")){
			// Construct the captchas object
			// Use same settings as in query.jsp
			CaptchasDotNet captchas = new util.CaptchasDotNet(
					request.getSession(true), // Ensure session
					"jtrip", // client
					"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
			);
			// Read the form values
//			String id =request.getParameter("id");
//			String pw =request.getParameter("pw");
			String password = request.getParameter("password");
			System.out.println("cappwd "+password);
//			// Check captcha
			String body;
			switch (captchas.check(password)) {
			case 's':
				body = "Session seems to be timed out or broken. ";
				body += "Please try again or report error to administrator.";
				break;
			case 'm':
				body = "Every CAPTCHA can only be used once. ";
				body += "The current CAPTCHA has already been used. ";
				body += "Please use back button and reload";
				break;
			case 'w':
				body = "You entered the wrong password. ";
				body += "Please use back button and try again. ";
				break;
			default:
				body = "ok";
				
				break;
			}
			System.out.println("aa : " + captchas.check(password));
			request.setAttribute("body", body);
			url="join/captcha.jsp";
			method=true;
		}else if(submod != null && submod.equals("getCap")){
			CaptchasDotNet captchas = new util.CaptchasDotNet(
					request.getSession(true), // Ensure session
					"jtrip", // client
					"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
			);
			request.setAttribute("capImg", captchas.image());
			url="join/getCap.jsp";
			method=true;
			
		}else if(submod !=null && submod.equals("modifyProfile")){
			// 프로필 수정 폼
			url="join/member.jsp";
			method=true;
		}else if(submod !=null && submod.equals("modify")){
			// 수정 버튼
			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
			MemberDao.getDao().modify(map);
			
			HttpSession session = request.getSession();
			//저장된 세션 다 날림.
			session.removeAttribute("v");
			session.removeAttribute("teamNameList");

			url="index.jsp";
			method = false;

		}
		System.out.println("url:"+url+" method:"+method);
		return new ModelForward(url, method);
	}
	
	
	
}


