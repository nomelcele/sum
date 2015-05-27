package model;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyMap;
import controller.ModelForward;
import dao.MemberDao;

public class JoinModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
	
		String submod= request.getParameter("submod");
		System.out.println("join submod:::::"+submod);
		String url="";
		boolean method = false;
		if(submod !=null && submod.equals("memberForm")){
			
			
			url ="join/member.jsp";
			method=true;
			
		}else if(submod !=null && submod.equals("signup")){
			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
			MemberDao.getDao().update(map);
			
			
			url="index.jsp";
			method=true;
		}
					
		return new ModelForward(url, method);
	}
	
	
	
}


