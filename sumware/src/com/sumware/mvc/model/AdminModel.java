package com.sumware.mvc.model;

import java.awt.List;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.BoardDao;
import com.sumware.mvc.dao.MemberDao;
import com.sumware.util.MyMap;


@Controller

public class AdminModel {
	
	@Autowired
	private MemberDao mdao;
	@Autowired
	private BoardDao bdao;
	
	
	@RequestMapping(value="/addMember",method=RequestMethod.POST)
	public String addMember(MemberVO mvo, Model model){
		//관리자 페이지에서 회원 추가 
		//HashMap<String, String> map= MyMap.getMaps().getMapList(request);
		
		mdao.addMember(mvo);
		
		
		model.addAttribute(" ");
		String memmail = map.get("newmail");
		MemberVO vo = MemberDao.getDao().getNewMemInfo(memmail);
		request.setAttribute("newmemVo", vo);
		
		return "admin/sendEmailUser";
		//이것도 나중에 수정
	}

	@RequestMapping(value="/getMemMgr",method=RequestMethod.POST)
	public String getMemMgr(int memdept,Model model){
		System.out.println("addMemberForm들어옴");
	// 부서선택하면 부서에 대한 팀장들 리스트가져옴
		//int memdept = Integer.parseInt(request.getParameter("memdept"));
		int memdt= memdept;
		List<MemberVO> memmgrlist= mdao.getMemMgr(memdt);
		model.addAttribute("mgrList",memmgrlist);
		
		//List<MemberVO> memmgrlist = MemberDao.getDao().getMemMgr(memdept);
		//request.setAttribute("mgrList", memmgrlist);
		
		return "admin/getMgrListCallback";
		
	}
	
	@RequestMapping(value="/addMemberForm")
	public String addMemberForm(){
		
		return "admin/admin";
		
	}
	@RequestMapping(value="/addBoard")
	public String addBoard(){
		
		HashMap<String, String> map = MyMap.getMaps().getMapList(request);
		BoardDao.getDao().addBoard(map);
		
		return "redirect:/addBordForm";
		
	}
	
	@RequestMapping(value="/addBoardForm",method=RequestMethod.POST)
	public String addBoardForm(){
		
		return "admin/addBoard.jsp";
		
	}
	

}
