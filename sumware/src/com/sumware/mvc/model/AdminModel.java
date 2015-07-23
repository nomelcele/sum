package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import com.sumware.dto.SignFormVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.service.ServiceInter;
import com.sumware.util.MyPage;
import com.sumware.util.SendEmail;

@Controller
public class AdminModel {

	@Autowired
	private AdminDao adao;

	@Autowired
	@Qualifier(value = "admin")
	private ServiceInter service;

//	// 관리자페이지 진입
//	@RequestMapping(value = "/admin")
//	public String adminForm(HttpSession session, String model) {
//		session.setAttribute("model", model);
//		return "admin.adminMain";
//	}

	// 관리자 로그인
//	@RequestMapping(value = "/adminLogin")
//	public void adminLogin(MemberVO mvo, HttpSession session,
//			HttpServletResponse response) throws IOException {
//		MemberVO adminVo = adao.adminLogin(mvo);
//		String result = "admin.adminMain";
//		if (adminVo == null) {
//			// 로그인 실패 시
//			System.out.println("로그인실패");
//			result = "0";
//		} else {
//			// 관리자에 대한 정보
//			System.out.println("로그인성공");
//			session.setAttribute("adminv", adminVo);
//		}
//		PrintWriter pw = response.getWriter();
//		pw.print(result);
//		pw.flush();
//		pw.close();
//
//
//	}
//
//	// 관리자 로그아웃
//	@RequestMapping(value = "adminLogout")
//	public void adminLogout(int memnum, HttpSession session,
//			HttpServletResponse response) throws IOException {
//		System.out.println("로그아웃 컨트롤러");
//		session.removeAttribute("adminv");
//		session.invalidate();
//		PrintWriter pw = response.getWriter();
//		pw.write("success");
//		pw.flush();
//		pw.close();
//	}
	/////////////////////////TOP 메뉴 선택하여 페이지 첫 진입(S)///////////////////////
	
	// 관리자페이지 진입
	@RequestMapping(value = "/admin")
	public String adminForm(HttpSession session, String model) {
		session.removeAttribute("adminModel");
		return "admin.adminMain";
	}
	
	@RequestMapping(value="/adminSalaryPage")
	public String firstSalary(MemberVO mvo, Model model, HttpServletRequest req, HttpSession session){
		session.setAttribute("adminModel", "salary");
		// 페이지 처리
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		// 사원 리스트
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		model.addAttribute("pdept", mvo.getMemdept());
		model.addAttribute("pname", mvo.getMemname());
		return "admin.payInfoList";
	}
	
	@RequestMapping(value="/adminEmployeePage")
	public String firstEmployee(MemberVO mvo, Model model, HttpServletRequest req, HttpSession session){
		session.setAttribute("adminModel", "employee");
		// 페이지 처리
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		// 사원 리스트
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		model.addAttribute("pdept", mvo.getMemdept());
		model.addAttribute("pname", mvo.getMemname());

		return "admin.memInfoList";
	}
	
	@RequestMapping(value="/adminSignFormPage")
	public String firstSignForm(SignFormVO sfvo, Model model, HttpServletRequest req, HttpSession session){

		session.setAttribute("adminModel", "signform");
		
		List<SignFormVO> sfvoList = adao.getSignFormList(sfvo);
		model.addAttribute("sfvoList", sfvoList);
		
		return "admin.signFormList";
	}
	
	@RequestMapping(value="/adminBoardPage")
	public String firstBoard(SignFormVO sfvo, Model model, HttpServletRequest req, HttpSession session){

		session.setAttribute("adminModel", "boardmgr");
		return "admin.addBoard";
	}
	
	
	
	/////////////////////////TOP 메뉴 선택하여 페이지 첫 진입(E)///////////////////////
	

	// / 모달에 mem정보
	@RequestMapping(value = "/admingetMemInfoForModal", method = RequestMethod.POST)
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
		
		// 직급,부서 변경 -> 하급자 목록
		List<MemberVO> jList = adao.getJuniors(vo.getMemnum());
		model.addAttribute("jList", jList);
		
		// 하급자들에게 지정해줄 상급자 목록
		List<MemberVO> jMgrList = adao.getMgrs(mvo);
		model.addAttribute("jMgrList", jMgrList);
		
		return "admin/modal";
	}

	// ////////////////////////사원 관리(S)///////////////////////////

	// 사원 진급 처리
	@RequestMapping(value = "/adminPromoteMem", method = RequestMethod.POST)
	public String adminUppromoteMem(MemberVO mvo) {
		service.changeJobSalary(mvo);
		// 업데이트 후 사원 개인정보 리스트 보여줌
		return "redirect:/adminMemList?page=1&memdept=0&memname=";
	}

	// 사원 부서 이동
	@RequestMapping(value = "/adminMoveDept", method = RequestMethod.POST)
	public String adminUpmoveDept(MemberVO mvo) {
		service.changeDeptMgr(mvo);
		// 업데이트 후 사원 개인정보 리스트 보여줌
		return "redirect:/adminMemList?page=1&memdept=0&memname=";
	}

	// 사원 퇴사 처리
	@RequestMapping(value = "/adminResignMem")
	public String adminUpresignMem(int memnum) {
		adao.resignMem(memnum);
		return "redirect:/adminMemList?page=1&memdept=0&memname=";
	}

	// 사원 개인 정보 리스트 가져오는 메서드
	@RequestMapping(value = "/adminMemList")
	public String getMemInfoList(MemberVO mvo, Model model, HttpServletRequest req, HttpSession session) {
		// 페이지 처리
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		// 사원 리스트
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		model.addAttribute("pdept", mvo.getMemdept());
		model.addAttribute("pname", mvo.getMemname());

		return "admin/memInfoList";

	}

	// 사원 추가 메뉴 진입
	@RequestMapping(value = "/adminaddMemberForm", method = RequestMethod.POST)
	public String addMemberForm() {
		return "admin/addMember";
	}

	// 관리자 - 새 사원 추가
	@RequestMapping(value = "/adminaddMember", method = RequestMethod.POST)
	public String adminUpaddMember(MemberVO mvo, PayVO payvo, Model model,
			HttpSession session) throws Exception {
		System.out.println("사원 추가버튼 클릭!!!" + mvo.getMemmgr());
		
		// 사원을 디비에 저장하고 부여받은 사번과 정보들로 사원에게 메일을 전송해 준다
		//실패 시 DB에 저장되었던 사원정보를 다시 삭제하고, 성공 시 pay테이블에 연봉 정보를 입력한다.
		service.addNewMember(mvo,payvo);
		
		return "admin/addMember";
	}

	// 부서선택하면 부서에 대한 팀장들 리스트가져옴
	@RequestMapping(value = "/admingetMemMgr", method = RequestMethod.POST)
	public String getMemMgr(int memdept, Model model) {
		List<MemberVO> memmgrlist = adao.getMemMgr(memdept);
		model.addAttribute("mgrList", memmgrlist);
		return "admin/getMgrListCallback";
	}
	
	// 직급, 부서 변경 시 변경할 상급자 리스트
	@RequestMapping(value="/admingetNewMgr",method=RequestMethod.POST)
	public void getNewMgr(MemberVO mvo,HttpServletResponse resp) throws IOException{
		mvo.setMemauth(mvo.getMemauth()-1);
		List<MemberVO> newmgrlist = adao.getMgrs(mvo);
		
		StringBuffer sb = new StringBuffer();
		sb.append("<option value='0'>상급자 선택</option>");

		for (MemberVO e : newmgrlist) {
			sb.append("<option value='").append(e.getMemnum()).append("'>")
					.append(e.getMemname()).append("</option>");
		}

		PrintWriter pw = resp.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
		
	}


	// ////////////////////////사원 관리(E)///////////////////////////

	// ////////////////////////급여 관리(S)///////////////////////////
	// 추가 급여 지급
	@RequestMapping(value = "/admingiveBonus", method = RequestMethod.POST)
	public String adminUpgiveBonus(CommissionVO comvo) {
		adao.giveBonus(comvo);
		return "redirect:/adminPayManagement?page=1";
	}

	// 월 급여 지급
	@RequestMapping(value = "/admingiveSalary", method = RequestMethod.POST)
	public String adminUpgiveSalary(PayHistoryVO phvo) {
		System.out.println("aa:" + phvo.getHisamount());
		System.out.println("bb : " + phvo.getHismem());
		adao.giveSalary(phvo);

		return "redirect:/adminPayManagement?page=1";
	}

	// 급여조회 폼
	@RequestMapping(value = "/adminPayInfoList", method = RequestMethod.POST)
	public String adminPayInfoList(MemberVO mvo, Model model, HttpServletRequest req) {

		// 페이지 처리
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		// 사원 리스트
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		model.addAttribute("pdept", mvo.getMemdept());
		model.addAttribute("pname", mvo.getMemname());
		return "admin/payInfoList";
	}

	// 급여지급 폼
	@RequestMapping(value = "/adminPayManagement")
	public String adminPayManagement(MemberVO mvo, Model model,HttpServletRequest req) {
		// 페이지 처리
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		// 사원 리스트
		List<MemberVO> memList = adao.getMemInfoList(mvo);
		model.addAttribute("list", memList);
		model.addAttribute("pdept", mvo.getMemdept());
		model.addAttribute("pname", mvo.getMemname());
		return "admin/payManagement";
	}

	// 사원의 급여 디테일
	@RequestMapping(value = "/adminPayInfoDetail", method = RequestMethod.POST)
	public String adminPayInfoDetail(MemberVO vo, String hisdate, Model model) {
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
		if (hisdate != null && hisdate != "") {
			payhistoryvo.setHisdate(hisdate);
		} else {
			payhistoryvo.setHisdate(null);
		}
		List<PayHistoryVO> phvo = adao.getPayHistory(payhistoryvo);
		model.addAttribute("phvoList", phvo);
		// 사원마다 급여 지급 받은 이력이 있는 년도 뽑아옴 ( select태그에 추가하기 위해)
		List<PayHistoryVO> months = adao.getMonths(vo.getMemnum());
		model.addAttribute("monthList", months);

		return "admin/payInfoDetail";
	}

	//달의 추가급여 디테일
	@RequestMapping(value = "/admingetPaymentDetail", method = RequestMethod.POST)
	public String getPaymentDetail(CommissionVO comvo, Model model) {
		// member pay 정보 가져옴
		PayVO payvo = adao.getPayInfo(comvo.getCommem());
		model.addAttribute("payvo", payvo);

		// commission 정보들 가져옴
		// 달에 해당하는 추가급들 다 가져옴
		List<CommissionVO> comvos = adao.getComInfo(comvo);
		model.addAttribute("comList", comvos);

		// commission 총 합계 계산
		int comsum = 0;
		for (CommissionVO e : comvos) {
			comsum += e.getComamount();
		}
		model.addAttribute("comSum", comsum);
		// 총 지급 된 급여!!!!
		int totalSal = comsum + payvo.getPmonthsalary();
		model.addAttribute("totalSalary", totalSal);

		return "admin/modal";
	}
	
	// 전체 사원 급여 지급
	@RequestMapping(value = "/admingiveAllMemSal", method = RequestMethod.POST)
	public String giveAllMemSal(){
		List<MemberVO> mvo = adao.getAllMemInfo();
		
		for(MemberVO mv : mvo){
			PayVO payvo =adao.getPayInfo(mv.getMemnum());
			CommissionVO comvo = new CommissionVO();
			comvo.setCommem(mv.getMemnum());
			int comsum = adao.getCommSum(comvo);
			// 지급받을 급여
			int monthtotal = payvo.getPmonthsalary()+comsum;
			System.out.println("지급 급여1!! = "+monthtotal);
			System.out.println("받는 사람 =="+mv.getMemnum());
			PayHistoryVO phvo = new PayHistoryVO();
			phvo.setHisamount(monthtotal);
			phvo.setHismem(mv.getMemnum());
			try{
				adao.giveSalary(phvo);
			}catch(Exception e){
				System.out.println(mv.getMemnum()+"는 이미 지급된 사원");
				continue;
			}
			
		}
		return "redirect:/adminPayManagement?page=1";
	}
	

	// ////////////////////////급여 관리(E)///////////////////////////

	// ////////////////////////게시판 관리(S)///////////////////////////

	// 게시판 추가 메뉴 진입
	@RequestMapping(value = "/adminaddBoardForm", method = RequestMethod.POST)
	public String addBoardForm(HttpSession session) {
		return "admin/addBoard";
	}

	// 게시판 추가
	@RequestMapping(value = "/adminaddBoard", method = RequestMethod.POST)
	public String adminUpaddBoard(BnameVO bnvo) {
		// 디비에 게시판 추가
		adao.addBoard(bnvo);
		return "admin/addBoard";
	}

	// 게시판 열람 페이지로 이동
	@RequestMapping(value = "/adminBoardListMain")
	public String boardListMain() {
		return "admin/deptBoardList";
	}

	// 해당 부서의 게시판 목록 가져오기
	@RequestMapping(value = "/admingetDeptBoards", method = RequestMethod.POST)
	public void getDeptBoards(int bdeptno, Model model, HttpServletResponse resp)
			throws IOException {
		List<BnameVO> bList = adao.getDeptBoards(bdeptno);
		StringBuffer sb = new StringBuffer();
		sb.append("<option value='0'>게시판</option>");

		for (BnameVO e : bList) {
			sb.append("<option value='").append(e.getBgnum()).append("'>")
					.append(e.getBname()).append("</option>");
		}

		PrintWriter pw = resp.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
		
	}

	// 선택한 게시판 열람
	@RequestMapping(value = "/admingetDeptBoardList", method = RequestMethod.POST)
	public String getDeptBoardList(int bgnum, int bdeptno, Model model) {
		String params = "page=1&bsearch=&div=&bgnum=" + bgnum+"&bdeptno="+bdeptno;
		return "redirect:/saboardList?" + params;
	}

	// 게시판 삭제 폼 이동
	@RequestMapping(value = "/adminDeleteBoardForm")
	public String deleteBoardForm() {
		return "admin/deleteBoard";
	}

	// 선택한 게시판 삭제
	@RequestMapping(value = "/admindeleteBoard", method = RequestMethod.POST)
	public String adminUpdeleteBoard(int bgnum) {
		adao.deleteBoard(bgnum);
		return "redirect:/adminDeleteBoardForm";
	}
	// ////////////////////////게시판 관리(E)///////////////////////////
	
	// ////////////////////////문서 양식 관리(S)///////////////////////////
	// 양식 추가 메뉴 선택
	@RequestMapping(value="/adminaddSignForm")
	public String addSignForm(){
		return "admin/addSignForm";
	}
	
	// 제작한 양식 추가
	@RequestMapping(value="/adminaddForm", method=RequestMethod.POST)
	public String adminUpaddForm(SignFormVO sfvo){
		
		adao.addSignForm(sfvo);
		return "redirect:/adminaddSignForm";
	}
	
	// 양식 목록 메뉴 선택
	@RequestMapping(value="/adminFormList")
	public String adminFormList(SignFormVO sfvo, Model model, HttpSession session){
		
		List<SignFormVO> sfvoList = adao.getSignFormList(sfvo);
		model.addAttribute("sfvoList", sfvoList);
		
		return "admin/signFormList";
	}
	
	// 양식 삭제
	@RequestMapping(value="/admindeleteSignForm", method=RequestMethod.POST)
	public String adminUpdeleteSignForm(SignFormVO sfvo){
		//삭제
		adao.deleteSignForm(sfvo);
		return "redirect:/adminFormList";
	}
	
	// ////////////////////////문서 양식 관리(E)///////////////////////////
	
	// ////////////////////////인증 부분(S)///////////////////////////
	//인증
	@RequestMapping(value="/adminauthentication", method=RequestMethod.POST)
	public String adminauthentication(MemberVO mvo, HttpSession session) throws Exception{
		MemberVO adminvo = (MemberVO) session.getAttribute("adminv");
		mvo.setMemnum(adminvo.getMemnum());
		System.out.println("memnum:"+mvo.getMemnum()+"mempwd:"+mvo.getMempwd());
		MemberVO adminv = adao.adminLogin(mvo.getMemnum());
		if(adminv==null){

			throw new Exception("비밀번호가 틀렸습니다.");
		}
		
		// 의미없는 뷰
		return "admin/adminMain";
	}
	
	// ////////////////////////인증 부분(E)///////////////////////////

	
	
}
