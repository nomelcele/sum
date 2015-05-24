package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

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
			
			int fromNum = Integer.parseInt(request.getParameter("fromNum"));
			int toNum = Integer.parseInt(request.getParameter("toNum"));
			String entryNum = request.getParameter("entNum");			
			String[] entryNum1 = entryNum.split(",");
			
			ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
			int entNum=0; // 참가자 사번 초기화
			String ckmem = "N";
			
			for(String e : entryNum1){
				MessengerVO v = new MessengerVO();
				entNum = Integer.parseInt(e);
				if(entNum==fromNum){
					ckmem = "Y";
					v.setMesmember(entNum);
					v.setOpenmemberyn(ckmem);
					
				}else{
					v.setMesmember(entNum);
					v.setOpenmemberyn(ckmem);
				}
				list.add(v);
				System.out.println(e);
			}
			System.out.println(list.size());
			
			int keynum = MessengerDao.getDao().insertCreateRoom(list);
			System.out.println("keynum : "+keynum);
			
			ArrayList<MemberVO> memList = MessengerDao.getDao().getList();
			request.setAttribute("memList", memList);
			request.setAttribute("toNum", toNum);
			request.setAttribute("key", keynum);
			url = "msgChat.jsp";
			method = true;
		}	
		
		
		return new ModelForward(url, method);
	}

}
