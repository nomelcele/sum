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
import com.sumware.dto.CommissionVO;
import com.sumware.dto.MemberVO;
import com.sumware.dto.PayHistoryVO;
import com.sumware.dto.PayVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.service.ServiceInter;
import com.sumware.util.SendEmail;

@Controller
public class AdminModel {

	@Autowired
	private AdminDao adao;

	@Autowired
	@Qualifier(value = "admin")
	private ServiceInter service;

	// 관리자페이지 진입
	@RequestMapping(value = "/admin")
	public String adminForm(HttpSession session, String model) {
		session.setAttribute("model", model);
		return "admin.adminMain";
	}

	// 관리자 로그인
	@RequestMapping(value = "/adminLogin")
	public void adminLogin(MemberVO mvo, HttpSession session,
			HttpServletResponse response) throws IOException {
		MemberVO adminVo = adao.adminLogin(mvo);
		String result = "admin.adminMain";
		if (adminVo == null) {
			// 로그인 실패 시
			System.out.println("로그인실패");
			result = "0";
		} else {
			// 관리자에 대한 정보
			System.out.println("로그인성공");
			session.setAttribute("adminv", adminVo);
		}
		PrintWriter pw = response.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();

	}

	// 관리자 로그아웃
	@RequestMapping(value = "adminLogout")
	public void adminLogout(int memnum, HttpSession session,
			HttpServletResponse response) throws IOException {
		System.out.println("로그아웃 컨트롤러");
		session.removeAttribute("adminv");
		session.invalidate();
		PrintWriter pw = response.getWriter();
		pw.write("success");
		pw.flush();
		pw.close();
	}

	// / 모달에 mem정보
	@RequestMapping(value = "/getMemInfoForModal", method = RequestMethod.POST)
	public String getMemInfoForModal(CommissionVO comvo, MemberVO vo,
			Model model, String cmd) {
		MemberVO mvo = adao.getMemInfo(vo);
		model.addAttribute("memvo", mvo);
		// member pay 정보 가져옴
		// 급여 지급에선 월급 정보 보여주기 위해 (pmonthsalary)
		PayVO payvo = adao.getPayInfo(vo.getMemnum());
		model.addAttribute("payvo", payvo);

		if (cmd.equals("giveSalary")) {
			// 추가적으로 급여에 대한 정보 다가져와야 됨!!!
			// 달에 해당하는 추가급들 다 가져옴
			comvo.setCommem(vo.getMemnum());
			List<CommissionVO> comvos = adao.getComInfo(comvo);
			model.addAttribute("comList", comvos);

			// commission 총 합계 계산
			int comsum = 0;
			for (CommissionVO e : comvos) {
				comsum += e.getComamount();
			}
			model.addAttribute("comSum", comsum);
			// 총 지급 될 급여!!!!
			int totalSal = comsum + payvo.getPmonthsalary();
			model.addAttribute("totalSalary", totalSal);

		}
		return "admin/modal";
	}

	// ////////////////////////사원 관리(S)///////////////////////////

	// 사원 진급 처리
	@RequestMapping(value = "/adminPromoteMem", method = RequestMethod.POST)
	public String promoteMem(MemberVO mvo) {
		adao.promoteMem(mvo);
		return "redirect:/adminMemList";
	}

	// 사원 부서 이동
	@RequestMapping(value = "/adminMoveDept", method = RequestMethod.POST)
	public String moveDept(MemberVO mvo) {
		adao.moveDept(mvo);
		return "redirect:/adminMemList";
	}

	// 사원 퇴사 처리
	@RequestMapping(value = "/adminResignMem")
	public String resignMem(int memnum) {
		adao.resignMem(memnum);
		return "redirect:/adminMemList";
	}

	// 사원 개인 정보 리스트 가져오는 메서드
	@RequestMapping(value = "/adminMemList")
	public String getMemInfoList(MemberVO mvo, Model model) {
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		return "admin/memInfoList";
	}

	// 사원 추가 메뉴 진입
	@RequestMapping(value = "/adminaddMemberForm", method = RequestMethod.POST)
	public String addMemberForm() {
		return "admin/addMember";
	}

	// 관리자 - 새 사원 추가
	@RequestMapping(value = "/adminaddMember", method = RequestMethod.POST)
	public String addMember(MemberVO mvo, PayVO payvo, Model model,
			HttpSession session) throws Exception {
		System.out.println("사원 추가버튼 클릭!!!" + mvo.getMemmgr());
		// 사원을 디비에 저장하고 부여받은 사번과 정보들을 다시가져옴
		MemberVO nmvo = service.addNewMember(mvo);
		try {
			// 메일전송 클래스를 이용하여 메일전송
			int res = SendEmail.getSendemail().sendEmailToNewMem(nmvo);
			if (res == 0) {
				// 메일 전송 실패 시 디비 삭제
				adao.cancelAddMem(nmvo.getMemnum());
				throw new Exception("메일 전송 실패");
			}
			payvo.setPmem(nmvo.getMemnum());
			adao.insertPay(payvo);

		} catch (IOException e) {
			e.printStackTrace();
		}
		return "admin/addMember";
	}

	// 부서선택하면 부서에 대한 팀장들 리스트가져옴
	@RequestMapping(value = "/admingetMemMgr", method = RequestMethod.POST)
	public String getMemMgr(int memdept, Model model) {
		List<MemberVO> memmgrlist = adao.getMemMgr(memdept);
		model.addAttribute("mgrList", memmgrlist);
		return "admin/getMgrListCallback";
	}

	// ////////////////////////사원 관리(E)///////////////////////////

	// ////////////////////////급여 관리(S)///////////////////////////
	// 추가 급여 지급
	@RequestMapping(value = "/giveBonus", method = RequestMethod.POST)
	public String giveBonus(CommissionVO comvo) {
		adao.giveBonus(comvo);
		return "redirect:/adminPayManagement";
	}

	// 월 급여 지급
	@RequestMapping(value = "/giveSalary", method = RequestMethod.POST)
	public String giveSalary(PayHistoryVO phvo) {
		System.out.println("aa:" + phvo.getHisamount());
		System.out.println("bb : " + phvo.getHismem());
		adao.giveSalary(phvo);

		return "redirect:/adminPayManagement";
	}

	// 급여조회 폼
	@RequestMapping(value = "/adminPayInfoList", method = RequestMethod.POST)
	public String adminPayInfoList(MemberVO mvo, Model model) {
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		return "admin/payInfoList";
	}

	// 급여지급 폼
	@RequestMapping(value = "/adminPayManagement")
	public String adminPayManagement(MemberVO mvo, Model model) {
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		return "admin/payManagement";
	}

	// 사원의 급여 디테일
	@RequestMapping(value = "/adminPayInfoDetail", method = RequestMethod.POST)
	public String adminPayInfoDetail(MemberVO vo,String hisdate, Model model) {
		System.out.println("memnum ::" + vo.getMemnum());

		// member 정보 가져옴
		MemberVO mvo = adao.getMemInfo(vo);
		model.addAttribute("memvo", mvo);
		// member pay 정보 가져옴
		PayVO payvo = adao.getPayInfo(vo.getMemnum());
		model.addAttribute("payvo", payvo);
		// member payhistory 정보 가져옴
		PayHistoryVO payhistoryvo = new PayHistoryVO();
		payhistoryvo.setHismem(vo.getMemnum());
		if(hisdate!=null && hisdate!=""){
			payhistoryvo.setHisdate(hisdate);
		}else{
			payhistoryvo.setHisdate(null);
		}
		List<PayHistoryVO> phvo = adao.getPayHistory(payhistoryvo);
		model.addAttribute("phvoList", phvo);
		// 사원마다 급여 지급 받은 이력이 있는 년도 뽑아옴 ( select태그에 추가하기 위해)
		List<PayHistoryVO> months = adao.getMonths(vo.getMemnum());
		model.addAttribute("monthList", months);
		
		return "admin/payInfoDetail";
	}

	// ////////////////////////급여 관리(E)///////////////////////////

	// ////////////////////////게시판 관리(S)///////////////////////////

	// 게시판 추가 메뉴 진입
	@RequestMapping(value = "/adminaddBoardForm", method = RequestMethod.POST)
	public String addBoardForm() {
		return "admin/addBoard";
	}

	// 게시판 추가
	@RequestMapping(value = "/adminaddBoard", method = RequestMethod.POST)
	public String addBoard(BnameVO bnvo) {
		System.out.println("보드추가 매핑됨");
		// 디비에 게시판 추가
		adao.addBoard(bnvo);
		return "admin/addBoard";
	}
	// ////////////////////////게시판 관리(E)///////////////////////////

}
