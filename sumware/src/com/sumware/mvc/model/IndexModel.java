package com.sumware.mvc.model;

import org.springframework.stereotype.Controller;
@Controller
public class IndexModel{
	public String indexForm(){
		return "index";
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
