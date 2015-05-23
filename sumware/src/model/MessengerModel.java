package model;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ModelForward;
import dao.MessengerDao;
import dto.MemberVO;
import dto.MessengerVO;

public class MessengerModel implements ModelInter{
	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		String submod = request.getParameter("submod");
		System.out.println("submod : "+submod);
		String url = "main.jsp";
		boolean method = true;
		
		if(submod != null && submod.equals("messengerForm")){
			url = "messenger.jsp";
			method = true;
		
			ArrayList<MemberVO> list = MessengerDao.getDao().getList();
			request.setAttribute("list", list);
			System.out.println("MessengerModel 영역입니다.");
		}else if(submod != null && submod.equals("messengerChat")){
			url = "messengerChat.jsp";
			method = true;
			


			
		}
		
		
		return new ModelForward(url, method);
	}

}
