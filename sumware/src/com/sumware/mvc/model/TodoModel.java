package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.CalendarVO;
import com.sumware.dto.MemberVO;
import com.sumware.dto.TodoJobVO;
import com.sumware.dto.TodoVO;
import com.sumware.mvc.dao.CalendarDAO;
import com.sumware.mvc.dao.TodoDao;

@Controller
public class TodoModel {
	@Autowired
	private TodoDao tdao;
	@Autowired
	private CalendarDAO cdao;

	// todo 기본 페이지 //ok
	@RequestMapping(value = "/todoForm", method = RequestMethod.POST)
	public String todoForm(Model model, HttpSession session) {
		MemberVO mvo =(MemberVO) session.getAttribute("v");
		int todept = mvo.getMemdept();
		List<TodoVO> deptJobList = tdao.getDeptJob(todept);
		model.addAttribute("deptJobList", deptJobList);

		return "todo/main/todo";
	}

	// addTodo 후에 todo 메인페이지로 돌아가는 작업 // ok
	@RequestMapping(value="afterAddTodo")
	public String afterAddTodo(Model model, HttpSession session){
		
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		
		int todept = mvo.getMemdept();
	
		// 부서 업무리스트 뽑아줌
		List<TodoVO> deptJobList = tdao.getDeptJob(todept);

		model.addAttribute("deptJobList", deptJobList);
		
		return "todo.todoMain";
	}
	
	
	// 메뉴바에서 todo메뉴 첫 진입 시 //ok
	@RequestMapping(value = "firsttodoForm", method = RequestMethod.POST)
	public String firsttodoForm(Model model, HttpSession session,HttpServletRequest req) {

		MemberVO mvo = (MemberVO) session.getAttribute("v");

		session.setAttribute("model", req.getParameter("model"));
		List<MemberVO> list = tdao.getTomem(mvo.getMemnum());
	
		//그 부서의 팀장들 정보
		session.setAttribute("teamNameList", list);

		int todept = mvo.getMemdept();
		// 부서 업무리스트 뽑아줌
		List<TodoVO> deptJobList = tdao.getDeptJob(todept);

		model.addAttribute("deptJobList", deptJobList);

		return "todo.todoMain";

	}

	// 업무추가 폼 //ok
	@RequestMapping(value = "addtodoForm", method = RequestMethod.POST)
	public String addtodoForm(MemberVO mvo,Model model) {
		
		System.out.println("memnum : "+mvo.getMemnum());
		List<MemberVO> list = tdao.getTomem(mvo.getMemnum());

		model.addAttribute("teamNameList", list);
		return "todo/main/addTodo";
	}
	
	// 업무 추가 (파일 업로드)  //ok
	@RequestMapping(value = "addTodo", method = RequestMethod.POST)
	public ModelAndView addTodo(TodoVO tvo,
		 HttpSession session) {
		
		ModelAndView mav = new ModelAndView("redirect:/afterAddTodo");
		System.out.println(session.getServletContext().getRealPath("/"));
		StringBuffer path = new StringBuffer();
		path.append(session.getServletContext().getRealPath("/"))
				.append("/upload/").append(tvo.getMfile().getOriginalFilename());

		File f = new File(path.toString());
		try {
			tvo.getMfile().transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		tvo.setTofile(tvo.getMfile().getOriginalFilename());
		tvo.setToconfirm("n");
		
		tdao.addTodo(tvo);
		
		return mav;
	}

	// 업무관리 클릭 시 보여줄 화면, 업무 리스트  //ok
	@RequestMapping(value = "/checkTodoList", method = RequestMethod.POST)
	public String checkTodoList(HttpSession session, Model model) {

		MemberVO mvo = (MemberVO)session.getAttribute("v");
		int tomem = mvo.getMemnum();
		List<TodoVO> clist = tdao.checkTodoList(tomem);
		
		model.addAttribute("todoList", clist);
		return "todo/main/checkTodoList";
	}

	// 팀장의 업무 승인!!!! y로 바꿔줌!! 캘린더에도 등록!!!!
	@RequestMapping(value = "/approveTodo", method = RequestMethod.POST)
	public String approveTodo(Model model,HttpSession session, TodoVO tvo) {
		// 리스트의 승인여부 n을 y로 바꿈!!!!
		tdao.confirmTodo(tvo, "y");
		// map.put("start",map.get("tostdate"));
		// map.put("end", map.get("toendate"));
		// map.put("title", map.get("totitle"));
		// map.put("cal", map.get("todept"));
		CalendarVO cvo = new CalendarVO();
		cvo.setCalstart(tvo.getTostdate());
		cvo.setCalend(tvo.getToendate());
		cvo.setCalcont(tvo.getTotitle());
		cvo.setCaldept(tvo.getTodept());
		cvo.setSelCal("부서");
		cvo.setCal("0");
		cdao.calInsert(cvo);

		
		//팀장의 업무관리 할 것들 가져옴
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		int tomem = mvo.getMemnum();
		List<TodoVO> clist = tdao.checkTodoList(tomem);
		
		model.addAttribute("todoList", clist);
		
		return "todo/main/checkTodoList";
	}

	// 팀장의 업무 거절!!!  //ok
	@RequestMapping(value = "/rejectTodo", method = RequestMethod.POST)
	public String rejectTodo(TodoVO tvo, Model model, HttpSession session) {
		// 리스트의 승인여부 n을 z로 바꿈!!!!

		tdao.confirmTodo(tvo, "z");
		
		//팀장의 업무관리 할 것들 가져옴
				MemberVO mvo = (MemberVO) session.getAttribute("v");
				int tomem = mvo.getMemnum();
				List<TodoVO> clist = tdao.checkTodoList(tomem);
				
				model.addAttribute("todoList", clist);
		
		return "todo/main/checkTodoList";
	}

	
	// 부장의 업무관리(부여한 업무들의 상태를 봄)  //ok
	@RequestMapping(value = "/fWMana", method = RequestMethod.POST)
	public String fWMana(MemberVO mvo, Model model) {
		List<TodoVO> fwList = tdao.getFWMana(mvo.getMemnum());
		model.addAttribute("fwList", fwList);

		return "todo/main/fWMana";
	}

	// 팀장이 거절한 업무를 부장이 팀장에게 다시부여
	@RequestMapping(value = "/toUpFk", method = RequestMethod.POST)
	public String toUpFk(TodoVO tvo, Model model) {
		List<TodoVO> list = tdao.todoUpdate(tvo);
		model.addAttribute("fwList", list);
		return "todo/main/fWMana";
	}

	// 팀장의 업무 부여 폼 //ok
	@RequestMapping(value = "/giveJobForm", method = RequestMethod.POST)
	public String giveJobForm(MemberVO mvo, Model model) {
		List<TodoVO> todoList = tdao.getTeamTodoList(mvo);
		int memmgr = mvo.getMemnum();
		List<MemberVO> teamMemberList = tdao.getTomem(memmgr);

		model.addAttribute("teamTodoList", todoList);
		model.addAttribute("teamMemberList", teamMemberList);

		return "todo/main/giveJob";

	}

	// 팀장 업무부여 - 사원에게 업무 부여 //ok
	@RequestMapping(value = "/insertMemJob", method = RequestMethod.POST)
	public String insertMemJob(TodoJobVO tjvo,Model model) {

		// 사원에게 업무 부여
		tdao.insertMemJob(tjvo);
		
		List<TodoJobVO> membersjoblist = tdao.getMembersJob(tjvo.getJobtonum());
		model.addAttribute("membersjoblist", membersjoblist);

		return "todo/main/membersJob";
	}

	// 팀장 업무 부여 - 사원들의 업무 보여줌 //ok
	@RequestMapping(value = "/showMembersJob", method = RequestMethod.POST)
	public String showMembersJob(int jobtonum, Model model) {
		List<TodoJobVO> membersjoblist = tdao.getMembersJob(jobtonum);
		model.addAttribute("membersjoblist", membersjoblist);
		return "todo/main/membersJob";
	}

	// 멤버리스트?
	@RequestMapping(value = "/showmemlist", method = RequestMethod.POST)
	public String showmemlist(TodoJobVO tjvo, Model model) {
		List<TodoJobVO> list = tdao.getMembersJob(tjvo.getJobtonum());
		model.addAttribute("memberjoblist", list);
		return "todo/main/jobDetail";
	}

	// 팀 업무 폼 //ok
	@RequestMapping(value = "/teamTodoForm", method = RequestMethod.POST)
	public String teamTodoForm(HttpSession session, Model model) {
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		List<TodoVO> list = tdao.getTeamJob(mvo.getMemmgr());
		model.addAttribute("teamJobList", list);
		
		return "todo/main/teamTodoForm";
	}

	// 업무 완료 처리  // ok
	@RequestMapping(value = "/successJob", method = RequestMethod.POST)
	public String successJob(Model model, TodoVO tvo, HttpSession session) {
		System.out.println("업무 완료 처리 들어옴");
		tdao.confirmTodo(tvo, "o");
		
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		List<TodoVO> list = tdao.getTeamJob(mvo.getMemmgr());
		model.addAttribute("teamJobList", list);
		
		return "todo/main/teamTodoForm";
	}

}
