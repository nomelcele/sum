package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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

	// todo 기본 페이지
	@RequestMapping(value = "/todoForm", method = RequestMethod.POST)
	public String todoForm(Model model, int memdept) {
		int todept = memdept;
		List<TodoVO> deptJobList = tdao.getDeptJob(todept);
		model.addAttribute("deptJobList", deptJobList);

		return "todo/main/todo";
	}

	// 메뉴바에서 todo메뉴 첫 진입 시
	@RequestMapping(value = "firsttodoForm", method = RequestMethod.POST)
	public String firsttodoForm(Model model, HttpSession session,HttpServletRequest req) {
		System.out.println("메뉴에서 todo 누름");
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		System.out.println("세션 가져왓니? : "+mvo.getMemnum());
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

	// 업무추가 폼
	@RequestMapping(value = "addtodoForm", method = RequestMethod.POST)
	public String addtodoForm(MemberVO mvo,Model model) {
		
		System.out.println("memnum : "+mvo.getMemnum());
		List<MemberVO> list = tdao.getTomem(mvo.getMemnum());

		model.addAttribute("teamNameList", list);
		return "todo/main/addTodo";
	}
	
	///////////////////////////////////////////////////////////////////////////////

	// 업무 추가 (파일 업로드)
	@RequestMapping(value = "addTodo", method = RequestMethod.POST)
	public ModelAndView addTodo(@RequestParam("tofile") MultipartFile tofile,
			TodoVO tvo, HttpSession session) {
		System.out.println("업무추가 모델 매핑!!");
		
		ModelAndView mav = new ModelAndView("redirect:/firsttodoForm");

		StringBuffer path = new StringBuffer();
		path.append(session.getServletContext().getRealPath("/"))
				.append("/upload/").append(tofile.getOriginalFilename());

		File f = new File(path.toString());
		try {
			tofile.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

		tvo.setTofile(tofile.getOriginalFilename());
		
		System.out.println("파일업로드");
		tdao.addTodo(tvo);
		
		return mav;
	}

	// 업무관리 클릭 시 보여줄 화면, 업무 리스트
	@RequestMapping(value = "/checkTodoList", method = RequestMethod.POST)
	public String checkTodoList(int memnum, Model model) {
		// int tomem = Integer.parseInt(request.getParameter("memnum"));
		// ArrayList<TodoVO> clist = TodoDao.getDao().checkTodoList(tomem);
		// request.setAttribute("todoList", clist);
		int tomem = memnum;
		List<TodoVO> clist = tdao.checkTodoList(tomem);
		model.addAttribute("todoList", clist);
		return "todo/main/checkTodoList";
	}

	// 팀장의 업무 승인!!!! y로 바꿔줌!! 캘린더에도 등록!!!!
	@RequestMapping(value = "/approveTodo", method = RequestMethod.POST)
	public String approveTodo(TodoVO tvo) {
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
		cvo.setCal("0");
		cdao.calInsert(cvo);
		return "todo/main/checkTodoList";
	}

	// 팀장의 업무 거절!!!
	@RequestMapping(value = "/rejectTodo", method = RequestMethod.POST)
	public String rejectTodo(TodoVO tvo) {
		// 리스트의 승인여부 n을 z로 바꿈!!!!

		tdao.confirmTodo(tvo, "z");
		return "todo/main/checkTodoList";
	}

	@RequestMapping(value = "/fWMana", method = RequestMethod.POST)
	public String fWMana(MemberVO mvo, Model model) {
		List<TodoVO> fwList = tdao.getFWMana(mvo.getMemnum());
		model.addAttribute("fwList", fwList);

		return "todo/main/fWMana";
	}

	@RequestMapping(value = "/toUpFk", method = RequestMethod.POST)
	public String toUpFk(TodoVO tvo, Model model) {
		List<TodoVO> list = tdao.todoUpdate(tvo);
		// //request.removeAttribute("fwList");
		model.addAttribute("fwList", list);
		return "todo/main/fWMana";
	}

	// 업무 부여 폼
	@RequestMapping(value = "/giveJobForm", method = RequestMethod.POST)
	public String giveJobForm(MemberVO mvo, Model model) {
		List<TodoVO> todoList = tdao.getTeamTodoList(mvo);
		int memmgr = mvo.getMemnum();
		List<MemberVO> teamMemberList = tdao.getTomem(memmgr);

		model.addAttribute("teamTodoList", todoList);
		model.addAttribute("teamMemberList", teamMemberList);

		return "todo/main/giveJob";

	}

	// 업무 부여
	@RequestMapping(value = "/insertMemJob", method = RequestMethod.POST)
	public String insertMemJob(TodoJobVO tjvo) {
		tdao.insertMemJob(tjvo);
		return "redirect:/showMembersJob";
	}

	// 업무 보여줌?
	@RequestMapping(value = "/showMembersJob", method = RequestMethod.GET)
	public String showMembersJob(TodoJobVO tjvo, Model model) {
		List<TodoJobVO> membersjoblist = tdao.getMembersJob(tjvo.getJobtonum());
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

	// 팀 업무 폼?
	@RequestMapping(value = "/teamTodoForm", method = RequestMethod.POST)
	public String teamTodoForm(MemberVO mvo, Model model) {
		List<TodoVO> list = tdao.getTeamJob(mvo.getMemmgr());
		model.addAttribute("teamJobList", list);
		return "todo/main/teamTodoForm";
	}

	// 업무 완료 처리
	@RequestMapping(value = "/successJob", method = RequestMethod.POST)
	public String successJob(Model model, TodoVO tvo) {
		tdao.confirmTodo(tvo, "o");
		return "redirect:/teamTodoForm";
	}

}
