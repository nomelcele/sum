package com.sumware.mvc.model;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.jws.WebParam.Mode;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.MemberDao;
import com.sumware.util.CaptchasDotNet;
import com.sumware.util.MakeXML;


@Controller
public class JoinModel{
	
	@Autowired
	private MemberDao mdao;
	
	@RequestMapping(value="/samemberForm")
	public String memberForm(){
		return "join.member";	
	}
	
	@RequestMapping(value="/sajoinck")
	public void joinCk(String meminmail,HttpServletResponse response) throws IOException{
		int res = mdao.ckid(meminmail);
//		System.out.println("아이디중복검사");
		PrintWriter pw = response.getWriter();
		if(res==1){
			pw.write("<p>사용 불가능한 아이디입니다.</p>");
			pw.flush();
	
		}else{
			pw.write("<p>사용 가능한 아이디입니다.</p>");
			pw.flush();
		}
	}
	
	@RequestMapping(value="/sasignup")
	public String signup(MemberVO mvo, HttpSession session){
	
	    mdao.update(mvo);
	    List<MemberVO> list = mdao.getNameMailList();
	    // xml 파일 업데이트
	    MakeXML.updateXML(list);
	    //모든 세션 정보를 삭제함 ...
		session.invalidate();	
		return "home.index";	
	}
	
	@RequestMapping(value="/viewCap",method=RequestMethod.POST)
	public String viewCap(HttpServletRequest request){
		// Construct the captchas object
		// Use same settings as in query.jsp
		CaptchasDotNet captchas = new com.sumware.util.CaptchasDotNet(
				request.getSession(true), // Ensure session
				"jtrip", // client
				"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
		);
		// Read the form values
		String id =request.getParameter("id");
		String pw =request.getParameter("pw");
		String password = request.getParameter("password");
		System.out.println("cappwd "+password);
		// Check captcha
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
	
		return "join/cap/captcha";
		
	}
	
	
	@RequestMapping(value="/getCap",method=RequestMethod.POST)
	public String getCap(HttpServletRequest request){
		
		CaptchasDotNet captchas = new com.sumware.util.CaptchasDotNet(
				request.getSession(true), // Ensure session
				"jtrip", // client
				"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
		);
		request.setAttribute("capImg", captchas.image());
		
		return "join/cap/getCap";
	}
	
	
	@RequestMapping(value="/sajoinupload",method=RequestMethod.POST)
	public String joinupload(){
		return "join/joinupload";
	}
}


