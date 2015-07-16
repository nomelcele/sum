package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.LoginDao;
import com.sumware.util.SendEmail;


@Controller
public class LoginModel{
	@Autowired
	private LoginDao dao;

	@RequestMapping(value="/salogin")
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
				session.setAttribute("model", "join");
				// sessionScope에 아이디를 저장
				session.setAttribute("v", mvo);
				//login 기록 저장.
//				dao.inLog(mvo.getMemnum());	
				if(mvo.getMemresign() != null){
					// 퇴사일 컬럼에 값이 있을 경우(퇴사한 사원이 로그인했을 경우)
					// 로그인하지 못하게 함
					result="0";
				}
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
	

	@RequestMapping(value="/salogout")
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
	
	@RequestMapping(value="/safirstLoginForm")
	public String firstLoginForm(HttpSession session){
		System.out.println("첫번째 이용자!! 정보를 입력해볼까??");
		session.setAttribute("model", "memjoin");
		return "join.member";
	}
	
	// 비밀번호 찾기/////////////////////////////
	// 인증번호 메일로 전송
	@RequestMapping(value="/sasendCode", method = RequestMethod.POST)
	public String sendCode(MemberVO vo, Model model,HttpSession session) throws Exception{
		
		MemberVO mvo = dao.findPW(vo);
		// 인증번호 6자리 생성
		int code = (int)((Math.random()*900000)+100000);
		System.out.println("code : "+code);
		if(mvo != null){
			String mailsubject = "[비밀번호 찾기] 인증번호 메일입니다.";
			String mailcont = mvo.getMemname()+"님, 인증번호는 "+code+" 입니다. 입력 후 비밀번호를 변경 해 주세요.";
			int res = SendEmail.getSendemail().sendEmailToMem(mvo, mailsubject, mailcont);
			if (res == 0) {
				throw new Exception("인증번호 전송 실패");
			}
			session.setAttribute("code", code);
			model.addAttribute("mvo", mvo);
		}else{
			throw new Exception("사원번호와 E-mail이 일치하는 사원이 없습니다. 다시 시도 해 주세요.");
		}

		return "join/enterCodeCallback";
	}
	
	//인증번호 일치하는지 체크
	@RequestMapping(value="/sacheckCode", method = RequestMethod.POST)
	public ModelAndView checkCode(int code, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("join/enterCodeCallback");
		int realcode = (int) session.getAttribute("code");
		System.out.println("mycode : "+code+",, realcode : "+realcode);
		if(realcode == code){
			return mav;
		}else{
			throw new Exception("인증번호 불일치");
		}
	}
	
	// 비밀번호 변경
	@RequestMapping(value="changePW", method = RequestMethod.POST)
	public String changePW(MemberVO mvo){
		dao.changePW(mvo);
		return "join/enterCodeCallback";
	}
}
