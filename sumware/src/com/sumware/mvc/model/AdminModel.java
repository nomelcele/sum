package com.sumware.mvc.model;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.dao.BoardDao;
import com.sumware.mvc.dao.MemberDao;
import com.sumware.util.MyMap;


@Controller

public class AdminModel {
	
	@Autowired
	private MemberDao mdao;
	@Autowired
	private BoardDao bdao;
	@Autowired
	private AdminDao adao;
	
	// 게시판 추가 메뉴 진입
	@RequestMapping(value="/addBoardForm",method=RequestMethod.POST)
	public String addBoardForm(){
		
		return "admin/addBoard";
		
	}
	
	// 사원 추가 메뉴 진입
	@RequestMapping(value="/addMemberForm",method=RequestMethod.POST)
	public String addMemberForm(){
		
		return "admin/addMember";
		
	}
	
	
	// 관리자 - 새 사원 추가
	@RequestMapping(value="/addMember",method=RequestMethod.POST)
	public String addMember(MemberVO mvo, Model model){
		System.out.println("사원 추가버튼 클릭!!!");
		// 사원의 기본 정보를 가지고 디비에 추가
		adao.addMember(mvo);
		
		// 새 사원에 대한 정보 가져옴
		// 메일에 사원의 정보를 보여주기 위함
		String memmail = mvo.getMemmail();
		MemberVO nmvo = adao.getNewMemInfo(memmail);
		model.addAttribute("newmemVo", nmvo);
		
		return "admin/sendEmailUser";
	}
	
	// 관리자페이지 진입
	@RequestMapping(value="/admin")
	public String adminForm(HttpSession session, String model){
		
		session.setAttribute("model", model);
		
		return "admin.addMember";
	}
	


	// 부서선택하면 부서에 대한 팀장들 리스트가져옴
	@RequestMapping(value="/getMemMgr",method=RequestMethod.POST)
	public String getMemMgr(int memdept,Model model){

		
		List<MemberVO> memmgrlist= adao.getMemMgr(memdept);
		model.addAttribute("mgrList", memmgrlist);
		
		return "admin/getMgrListCallback";
		
	}
	
	//////// 수정해
	@RequestMapping(value="/addBoard")
	public String addBoard(){
		
//		HashMap<String, String> map = MyMap.getMaps().getMapList(request);
//		BoardDao.getDao().addBoard(map);
		
		return "redirect:/addBordForm";
		
	}
	

	

}
