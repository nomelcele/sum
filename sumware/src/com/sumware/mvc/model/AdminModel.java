package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.BnameVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.service.ServiceInter;
import com.sumware.util.SendEmail;


@Controller
public class AdminModel {

	@Autowired
	private AdminDao adao;
	
	@Autowired
	@Qualifier(value="admin")
	private ServiceInter service;
	
	// 관리자 로그인
	@RequestMapping(value="/adminLogin")
	public void adminLogin(MemberVO mvo , HttpSession session, HttpServletResponse response) throws IOException{
		MemberVO adminVo = adao.adminLogin(mvo);
		String result = "admin.adminMain";
		if(adminVo == null){
			// 로그인 실패 시
			System.out.println("로그인실패");
			result = "0";
		}else{
			// 관리자에 대한 정보
			System.out.println("로그인성공");
			session.setAttribute("adminv", adminVo);
		}
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();

	}
	
	//관리자 로그아웃
	@RequestMapping(value="adminLogout")
	public void adminLogout(int memnum,HttpSession session,HttpServletResponse response) throws IOException{
		System.out.println("로그아웃 컨트롤러");
		session.removeAttribute("adminv");
		session.invalidate();
		PrintWriter pw = response.getWriter();
		pw.write("success");
		pw.flush();
		pw.close();
	}
	
	
	
	// 관리자페이지 진입
	@RequestMapping(value="/admin")
	public String adminForm(HttpSession session, String model){
		session.setAttribute("model", model);
		return "admin.adminMain";
	}

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
	public String addMember(MemberVO mvo, Model model,HttpSession session) throws Exception{
		System.out.println("사원 추가버튼 클릭!!!");
		// 사원을 디비에 저장하고 부여받은 사번과 정보들을 다시가져옴
		MemberVO nmvo = service.addNewMember(mvo);
		try {
			// 메일전송 클래스를 이용하여 메일전송
			int res = SendEmail.getSendemail().sendEmailToNewMem(nmvo);
			if(res==0){
				//메일 전송 실패 시 디비 삭제
				adao.cancelAddMem(nmvo.getMemnum());
					throw new Exception("메일 전송 실패");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "admin/addMember";
	}

	// 부서선택하면 부서에 대한 팀장들 리스트가져옴
	@RequestMapping(value="/getMemMgr",method=RequestMethod.POST)
	public String getMemMgr(int memdept,Model model){
		List<MemberVO> memmgrlist= adao.getMemMgr(memdept);
		model.addAttribute("mgrList", memmgrlist);
		return "admin/getMgrListCallback";
	}
	
	//게시판 추가
	@RequestMapping(value="/addBoard",method=RequestMethod.POST)
	public String addBoard(BnameVO bnvo){
		System.out.println("보드추가 매핑됨");
		//디비에 게시판 추가
		adao.addBoard(bnvo);
		return "admin/addBoard";
	}

}
