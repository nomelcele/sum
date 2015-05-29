package model;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		}else if(submod !=null && submod.equals("modifyProfile")){
			// 프로필 수정 폼
			url="join/member.jsp";
			method=true;
		}else if(submod !=null && submod.equals("modify")){
			// 수정 버튼
			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
			MemberDao.getDao().modify(map);
			
			HttpSession session = request.getSession();
			//저장된 세션 다 날림.
			session.removeAttribute("v");
			session.removeAttribute("teamNameList");

			url="index.jsp";
			method = false;

		}
					
		return new ModelForward(url, method);
	}
	
	
	
}


