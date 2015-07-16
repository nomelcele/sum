package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.mvc.dao.MailDao;
import com.sumware.mvc.dao.TodoDao;
@Controller
public class IndexModel{
	@Autowired
	private MailDao mdao;
	@Autowired
	private TodoDao tdao;
	

	// 요청이 home 이거나, 아무 요청이 없을 경우 
	// 작동 됨.

	

	@RequestMapping(value={"/sahome","/","/saindex"})
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
