package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.LoginDao;
import com.sumware.mvc.dao.MailDao;
import com.sumware.mvc.dao.TodoDao;
@Controller
public class IndexModel{
	@Autowired
	private MailDao mdao;
	@Autowired
	private TodoDao tdao;
	@Autowired
	private LoginDao ldao;

	// 요청이 home 이거나, 아무 요청이 없을 경우 
	// 작동 됨.

	

	@RequestMapping(value={"/home","/","/index"},method=RequestMethod.GET)
	public String indexForm(Model model){
		return "home.index";
	}
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String indexForm(Principal principal,HttpSession session){
		System.out.println(":::::::"+principal.getName());
		int memnum = Integer.parseInt(principal.getName());
		try {
			String res = ldao.ckFirstLogin(memnum);

			System.out.println("res:::"+res);		
			if (res.equals("1")) {
				
				System.out.println("첫번째 이용자다!!!!");
				session.setAttribute("memnum", memnum);
				
				session.setAttribute("first", "1");
				//회원정보입력창으로 이동.
				//이동후에 memnum입력란에 자동으로 입력시켜주고
				//mempwd는 유효성검사 할때 쓰기위하여 보냄.
	
			} else if(!res.equals("1")&&!res.equals("0")){
				System.out.println("ddddddddd");
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
		return "home.index";
	}
	
	//Notification
	@RequestMapping(value="/satmCount")
	public void noti(String mailreceiver,int memnum,HttpSession session,HttpServletResponse response) throws IOException{
//		System.out.println("새로운것이 왔나??");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", mailreceiver);
		map.put("usernum",String.valueOf(memnum));
		if(session.getAttribute("mailCount")==null||session.getAttribute("todoCount")==null){
			session.setAttribute("mailCount", mdao.getListNum(map)[0]);
			session.setAttribute("todoCount",tdao.getTodoCount(map));
		}
		Integer tCount = (Integer) session.getAttribute("todoCount");
		Integer mCount = (Integer) session.getAttribute("mailCount");
		StringBuffer res = new StringBuffer();
		res.setLength(0);
		res.append("retry:5000\n");
		res.append("data:");
		if(tCount<tdao.getTodoCount(map)){
			res.append("t");
			session.setAttribute("todoCount",tdao.getTodoCount(map));
		}
		if(mCount< mdao.getListNum(map)[0]){
			res.append("m");
			session.setAttribute("mailCount",mdao.getListNum(map)[0]);
		}else{
			res.append("x");
		}
		res.append("\n\n");
//		System.out.println("으음???~~:"+res.toString());
		response.setHeader("cache-control", "no-cache");
		response.setContentType("text/event-stream");
		PrintWriter pw = response.getWriter();
		pw.print(res);
		pw.flush();
	}
}
