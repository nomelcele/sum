package com.sumware.mvc.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class IndexModel{
	
	// 요청이 home 이거나, 아무 요청이 없을 경우 
	// 작동 됨.
	@RequestMapping(value={"/home","/","/index"})
	public String indexForm(Model model){
		return "index";
	}
	
	//
	@RequestMapping(value="/goFunc", method=RequestMethod.POST)
	public ModelAndView goFunc(HttpServletRequest request){
		System.out.println("indexModel!!!!!!!!!!!!!!!!!!!!!");
		String page=request.getParameter("model");
		HttpSession ses = request.getSession();
		ses.setAttribute("model", page);
		
		if(page.toLowerCase().equals("board")){
			page = "board/boardList";
		}else if(page.toLowerCase().equals("todo")){
			System.out.println("todo들어옴");
			page = "todo/todoMain";
		}else if(page.toLowerCase().equals("mail")){
			page = "mail/mailList";
		}else if(page.toLowerCase().equals("calendar")){
			page="calendar/calTest";
		}
		ModelAndView mav = new ModelAndView(page);
		mav.addObject(request);
		return mav;
	}
}
