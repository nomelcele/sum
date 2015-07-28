package com.sumware.mvc.model;

import java.security.Principal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.LoginVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.dao.LoginDao;
import com.sumware.util.MyPage;
import com.sumware.util.SendEmail;


@Controller
public class LoginModel{
	@Autowired
	private LoginDao ldao;
	@Autowired
	private AdminDao adao;
	private int capCount;
	
	//시큐리티
	@RequestMapping(value="/login")
	public void login(HttpServletRequest request, Model model){
	}
	//로그인 실패시 이동할페이지 ( 시큐리티)
	@RequestMapping(value="index",method=RequestMethod.GET)
	public String indexForm(HttpSession session){
		capCount++;
		System.out.println("들어옴:"+capCount);
		session.setAttribute("capCount", capCount);
		return "home.index";
	}
	//login AuthenticationSuccessHandler를 사용해서 바꾸자.
	//logout AuthenticationFailureHandler
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String indexForm(Principal principal,HttpSession session){
		System.out.println(":::::::"+principal.getName());
		capCount=0;
		int memnum = Integer.parseInt(principal.getName());
		String str ="";
		if(memnum !=1){
			str= "home.index";
			try {
				String res = ldao.ckFirstLogin(memnum);
	
				System.out.println("res:::"+res);		
				if (res.equals("1")) {
					
					System.out.println("첫번째 이용자다!!!!");
					session.setAttribute("memnum", memnum);
					session.setAttribute("mempwd",ldao.firstPwd(memnum));
					
					session.setAttribute("first", "1");
					//회원정보입력창으로 이동.
					//이동후에 memnum입력란에 자동으로 입력시켜주고
					//mempwd는 유효성검사 할때 쓰기위하여 보냄.
					str="redirect:safirstLoginForm";
				} else if(!res.equals("1")&&!res.equals("0")){
					System.out.println("ddddddddd");
					session.setAttribute("first", "2");
					MemberVO mvo = ldao.login(memnum);
					session.setAttribute("model", "join");
					// sessionScope에 아이디를 저장
					session.setAttribute("v", mvo);
					//login 기록 저장.
	//				dao.inLog(mvo.getMemnum());	
					if(mvo.getMemresign() != null){
						// 퇴사일 컬럼에 값이 있을 경우(퇴사한 사원이 로그인했을 경우)
						// 로그인하지 못하게 함
						session.setAttribute("first", "0");
					}
				}else{
					session.setAttribute("first", "0");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else{
			session.setAttribute("first", "2");
			MemberVO adminVo = adao.adminLogin(memnum);
			session.setAttribute("adminv", adminVo);
			str= "admin.adminMain";
		}
		return str;
	}
	
	@RequestMapping(value="/logout",method=RequestMethod.POST)
	public String logout(HttpSession session){
		System.out.println("로그아웃 컨트롤러");
		session.invalidate();
		return "redirect:logoutgo";
	}
	@RequestMapping(value="/logoutgo")
	public void logoutgo(HttpServletRequest request, Model model){
	}
	@RequestMapping(value="/safirstLoginForm")
	public String firstLoginForm(HttpSession session){
		System.out.println("첫번째 이용자!! 정보를 입력해볼까??");
		session.setAttribute("model", "memjoin");
		return "join.member";
	}
	
	// 비밀번호 찾기/////////////////////////////
	// 인증번호 메일로 전송
	@RequestMapping(value="/sendCode", method = RequestMethod.POST)
	public String sendCode(MemberVO vo, Model model,HttpSession session) throws Exception{
		
		MemberVO mvo = ldao.findPW(vo);
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
	@RequestMapping(value="/checkCode", method = RequestMethod.POST)
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
		ldao.changePW(mvo);
		return "join/enterCodeCallback";
	}
	
	// 사원의 로그인 히스토리
	@RequestMapping(value="/samemLoginHistory")
	public String memLoginHistory(LoginVO lvo, Model model, HttpServletRequest req){
			
			// 페이지 처리
			int totalCount = adao.getLoginHistoryCount(lvo);
			Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,totalCount, 0);
			lvo.setBegin(pmap.get("begin"));
			lvo.setEnd(pmap.get("end"));
			System.out.println("begin :: "+pmap.get("begin"));
			System.out.println("end::::"+pmap.get("end"));
			
			List<LoginVO> lgList =  adao.getLoginHistory(lvo);
			
			model.addAttribute("lgList", lgList);
			model.addAttribute("plomem", lvo.getLomem());
			model.addAttribute("plostdate", lvo.getLostdate());
			model.addAttribute("ploendate", lvo.getLoendate());
			
			return "meminfo/memLoginHistory";
		}
	}
