package model;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ModelForward;

public class TodoModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		String submod = request.getParameter("submod");
		System.out.println("submod:"+submod);
		String url ="index.jsp";
		boolean method=false;
		
		if(submod.equals("todoForm")){
			url = "Todo.jsp";
			method = false;
			
		}
		
		return new ModelForward(url, method);
	}

}
