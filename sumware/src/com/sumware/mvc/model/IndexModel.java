package com.sumware.mvc.model;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class IndexModel{
	
	// 요청이 home 이거나, 아무 요청이 없을 경우 
	// 작동 됨.
	@RequestMapping(value={"/home","/"})
	public String indexForm(Model model){
		return "home/index";
	}
}
