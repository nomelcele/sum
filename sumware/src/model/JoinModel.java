package model;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ModelForward;

public class JoinModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
	
		String submod= request.getParameter("submod");
		String url="";
		boolean method = false;
		if(submod !=null && submod.equals("memberForm")){
			url ="join/member.jsp";
			method=true;
			
		}else if(submod !=null && submod.equals("join1")){
			url="join/membermain.jsp";
			method=true;
		}
					
		return new ModelForward(url, method);
	}
	
	
	
}

