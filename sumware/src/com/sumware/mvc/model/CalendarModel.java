package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.CalendarVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.CalendarDAO;


@Controller
public class CalendarModel{
	
	@Autowired
	CalendarDAO dao;
	
	@RequestMapping(value="/sacalList")
	public String getCalList(CalendarVO cavo,Model model,HttpSession session){
		MemberVO vo = new MemberVO();
		String first = (String) session.getAttribute("first");
		if(first.equals("1")){
			return "safirstLoginForm";
		}else if(first.equals("0")){
			session.invalidate();
			return "home";
		}else{
		vo = (MemberVO) session.getAttribute("v");
		session.setAttribute("model", "calendar");
		cavo.setCaldept(vo.getMemdept());
		cavo.setCalmem(vo.getMemnum());
		
		if(cavo.getCal()==null||cavo.getCal().equals("0")){
			//리스트를 불러와서 json형식으로 바꿈
			List<CalendarVO> list =dao.getCalList(cavo);
			System.out.println("listsize::"+list.size());
			String json = dao.makeJson(list);
	
			model.addAttribute("calJson", json);
			model.addAttribute("selcal", "부서");
		}else{
			//리스트를 불러와서 json형식으로 바꿈
			List<CalendarVO> list = dao.getCalList(cavo);
			String json = dao.makeJson(list);
	
			model.addAttribute("calJson", json);
			model.addAttribute("selcal", "사원");
		}
		}
		return "calendar.calTest";
	}
	@RequestMapping(value="/sacalInsert",method=RequestMethod.POST)
	public void calInsert(String title,CalendarVO cavo,Model model,HttpSession session,
			HttpServletResponse response) throws IOException{
		System.out.println("일정 등록!");
		cavo.setCalcont(URLDecoder.decode(title,"UTF-8"));
		MemberVO vo = (MemberVO) session.getAttribute("v");
		//url 저장.
		String res="";
		//해당하지 않는 값을 0으로 세팅해준다.
		//같은키로 값을 세팅. 둘이 동시에 값이 들어가는 경우가 없으므로.
		if(cavo.getSelCal().equals("부서")){
			
			cavo.setCaldept(vo.getMemdept());
			
			res = "calList?&caldept="+vo.getMemdept()+"&cal=0";
		}else{
			
			cavo.setCalmem(vo.getMemnum());
			
			res = "calList?&calmem="+vo.getMemnum()+"&cal=1";
		}
		//-----------------------
		dao.calInsert(cavo);
		PrintWriter pw=response.getWriter();
		pw.write(res);
		pw.flush();
	}
	@RequestMapping(value="/sacalDelete",method=RequestMethod.POST)
	public String calDel(CalendarVO cavo,Model model,HttpSession session){
		String res="";
		MemberVO vo = (MemberVO) session.getAttribute("v");
		dao.calDel(cavo.getCalnum());
		
		if(cavo.getSelCal().equals("부서")){
			res="redirect:/sacalList?calmem=0&caldept="+vo.getMemdept();
		}else{
			res="redirect:/sacalList?caldept=0&calmem="+vo.getMemnum();
		}
		
		return res;
	}

}
