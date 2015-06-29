package com.sumware.mvc.model;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class IndexModel{
	
	@RequestMapping(value={"/home","/"})
	public String indexForm(Model model){
		return "home/index";
	}
//	@Override
//	public ModelForward exe(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		String url = "index.jsp";
//		boolean method = false;
//		
//		return new ModelForward(url, method);
//	}

}
