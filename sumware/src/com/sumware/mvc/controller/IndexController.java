package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.mvc.dao.MailDao;
import com.sumware.mvc.dao.TodoDao;
import com.sumware.mvc.service.ServiceInter;
@Controller
public class IndexModel{
	@Autowired
	private MailDao mdao;
	@Autowired
	private TodoDao tdao;
	@Autowired
	@Qualifier(value="index")
	private ServiceInter service;
	
	// 요청이 home 이거나, 아무 요청이 없을 경우 
	// 작동 됨.
	@RequestMapping(value={"/home","/"},method=RequestMethod.GET)
	public String indexForm(Model model){
		return "home.index";
	}
	
	//Notification
	@RequestMapping(value="/satmCount")
	public void noti(String mailreceiver,int memnum,HttpSession session,HttpServletResponse response) throws IOException{
//		System.out.println("새로운것이 왔나??");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", mailreceiver);
		map.put("usernum",String.valueOf(memnum));
		//세션이 저장되어있지 않다면 새로 세션을 저장한다.=>처음 로그인시
		if(session.getAttribute("mailCount")==null||session.getAttribute("todoCount")==null){
			session.setAttribute("mailCount", mdao.getListNum(map)[0]);
			session.setAttribute("todoCount",tdao.getTodoCount(map));
		}
		Integer tCount = (Integer) session.getAttribute("todoCount");
		Integer mCount = (Integer) session.getAttribute("mailCount");
		StringBuffer res = new StringBuffer();
		res.setLength(0);
		// 메일 또는 todo 에 새로운 업무가 왔을 때 푸쉬를 해주는데 
		// 그 때 푸쉬 해주는 간격을 설정 해주는 로직.
		res.append("retry:5000\n");
		// 푸쉬를 받을 때 예약어로 data 가 날아가야 javascript 가 받아줌.
		res.append("data:");
		// 처음 저장했던 메일,업무 수와 현재 디비의 입력되어있는 수를 비교하여
		// 디비의 수가 크다면 res에 't' 또는 'm'을 추가한다.
		// 그 뒤에 현 세션을 다시 업데이트 시킨다. 
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
	
	@RequestMapping(value="/saconfNotify")
	public void confNotify(int confmem,HttpServletResponse response) throws IOException{
		String confurl = service.confNotify(confmem);
		
		// ConferenceVO confvo = cdao.getConfurl(confmem);
		// String confurl = confvo.getConfurl();
		// int confnum = confvo.getConfnum();
		StringBuffer sb = new StringBuffer();
		sb.append("data:").append(confurl).append("\n\n");
		
		response.setHeader("cache-control", "no-cache");
		response.setContentType("text/event-stream");
		PrintWriter pw = response.getWriter();
		pw.print(sb);
		pw.flush();
		
		// cdao.deleteConfnum(confnum);
	}
	
}
