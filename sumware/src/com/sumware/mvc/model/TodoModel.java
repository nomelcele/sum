package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
import com.sumware.dto.TodoVO;
import com.sumware.mvc.dao.CalendarDAO;
import com.sumware.mvc.dao.TodoDao;

@Controller
public class TodoModel{
	@Autowired
	private TodoDao tdao;
	@Autowired
	private CalendarDAO cdao;
	
	// todo 기본 페이지
	@RequestMapping(value="/todoForm", method=RequestMethod.POST)
	public String todoForm(Model model, int memdept){
		//int todept = Integer.parseInt(request.getParameter("memdept"));
		int todept = memdept;
		List<TodoVO> deptJobList= tdao.getDeptJob(todept);
		model.addAttribute("deptJobList", deptJobList);
		
		return "todo/todoMain";
	}
	
	// 메뉴바에서 todo메뉴 첫 진입 시
	@RequestMapping(value="/firsttodoForm", method=RequestMethod.POST)
	public String firsttodoForm(Model model, MemberVO mvo){
		
		List<MemberVO> list = tdao.getTomem(mvo.getMemnum());
		
		model.addAttribute("teamNameList", list);
		
		int todept = mvo.getMemdept();
		//부서 업무리스트 뽑아줌
		List<TodoVO> deptJobList = tdao.getDeptJob(todept);
		
		model.addAttribute("deptJobList", deptJobList);

		return "todo/todoMain";
		
	}
	
	// 업무추가 폼 
	@RequestMapping(value = "/addtodoForm", method=RequestMethod.POST)
	public String addtodoForm(){
		
		return "todo/addTodo";
	}
	
	// 업무 추가 (파일 업로드)
	@RequestMapping(value = "/addTodo", method=RequestMethod.POST)
	public ModelAndView addTodo(@RequestParam("tofile") MultipartFile tofile, TodoVO tvo, HttpSession session){

		ModelAndView mav = new ModelAndView("redirect:/firsttodoForm");
		
		StringBuffer path = new StringBuffer();
		path.append(session.getServletContext().getRealPath("/")).append("/upload/").append(tofile.getOriginalFilename());
		
		File f = new File(path.toString());
		try {
			tofile.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		tvo.setTofile(tofile.getOriginalFilename());

		tdao.addTodo(tvo);
		return mav;
	}
	
	// 업무관리 클릭 시 보여줄 화면, 업무 리스트
	@RequestMapping(value="/checkTodoList", method=RequestMethod.POST)
	public String checkTodoList(int memnum,Model model){
		//int tomem = Integer.parseInt(request.getParameter("memnum"));
		//ArrayList<TodoVO> clist = TodoDao.getDao().checkTodoList(tomem);
		//request.setAttribute("todoList", clist);
		int tomem = memnum;
		List<TodoVO> clist = tdao.checkTodoList(tomem);
		model.addAttribute("todoList", clist);
		return "todo/checkTodoList";
	}
	
	// 팀장의 업무 승인!!!! y로 바꿔줌!! 캘린더에도 등록!!!!
	@RequestMapping(value="/approveTodo", method=RequestMethod.POST)
	public String approveTodo(TodoVO tvo){
		tdao.confirmTodo(tvo, "y");
//		map.put("start",map.get("tostdate"));
//		map.put("end", map.get("toendate"));
//		map.put("title", map.get("totitle"));
//		map.put("cal", map.get("todept"));
		CalendarVO cvo = new CalendarVO();
		cvo.setCalstart(tvo.getTostdate());
		cvo.setCalend(tvo.getToendate());
		cvo.setCalcont(tvo.getTotitle());
		cvo.setCaldept(tvo.getTodept());
		cvo.setCal("0");
		cdao.calInsert(cvo);
		return "todo/checkTodoList";
	}
	

	
//		}else if(submod.equals("checkTodoList")){
//			// 업무 관리 클릭시 보여줄 화면 , 업무 리스트
//
//			String childmod = request.getParameter("childmod");
//			if(childmod!=null && childmod.equals("approveTodo")){
//				System.out.println("approveTodo 들어옴!!");
//				// 리스트의 승인여부 n을 y로 바꿈!!!!
//				HashMap<String,String> map = MyMap.getMaps().getMapList(request);
////				TodoDao.getDao().confirmTodo(map, "y");
//				//캘린더에 등록
//				map.put("start",map.get("tostdate"));
//				map.put("end", map.get("toendate"));
//				map.put("title", map.get("totitle"));
//				map.put("cal", map.get("todept"));
//				String sql = CalendarDAO.getDao().calSQL(2);
//				CalendarDAO.getDao().calInsert(sql, map);
//				
//			}else if(childmod!=null && childmod.equals("rejectTodo")){
//				// 리스트의 승인여부 n을 z로 바꿈!!!!
//				System.out.println("rejectTodo 들어옴!!");
//				HashMap<String,String> map = MyMap.getMaps().getMapList(request);
//				//TodoDao.getDao().confirmTodo(map, "z");
//			}
//			
//			url = "sumware?model=todo&submod=checkTodoListForm";
//			method = true;
//			
//		}else if(submod.equals("checkTodoListForm")){
//			int tomem = Integer.parseInt(request.getParameter("memnum"));
//			//ArrayList<TodoVO> clist = TodoDao.getDao().checkTodoList(tomem);
//			//request.setAttribute("todoList", clist);
//			
//			url = "todo/checkTodoList.jsp";
//			method = true;
//		}else if(submod.equals("fWMana")){
//			System.out.println("fWMana 들어옴");
//			int memnum = Integer.parseInt(request.getParameter("memnum"));
//			System.out.println("memnum:"+memnum);
//
//			//ArrayList<TodoVO> fwList=TodoDao.getDao().getFWMana(memnum);
////			request.setAttribute("fwList", fwList);
//			url="todo/fWMana.jsp";
//			method=true;
//		}else if(submod.equals("toUpFk")){
//			System.out.print("toUpFk 들어옴");
//			
//			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
//			//ArrayList<TodoVO> list = TodoDao.getDao().todoUpdate(map);
//			System.out.println("dao로 todoupdate");
//			
//			//request.removeAttribute("fwList");
////			request.setAttribute("fwList", list);
//			
//			url="todo/fWMana.jsp";
//			method=true;
//		}else if(submod.equals("giveJobForm")){
//			System.out.println("giveJobForm들어옴");
//			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
//			System.out.println("request받아옴");
//			//ArrayList<TodoVO> todoList = TodoDao.getDao().getTeamTodoList(map);
//			System.out.println("todolist받아옴");
//			int memmgr = Integer.parseInt(map.get("memnum"));
//			//ArrayList<MemberVO> teamMemberList = TodoDao.getDao().getTomem(memmgr);
//			System.out.println("teammembers받아옴");
////			request.setAttribute("teamTodoList", todoList);
////			request.setAttribute("teamMemberList", teamMemberList);
//
//			url = "todo/giveJob.jsp";
//			method = true;
//			
//		}else if(submod.equals("insertMemJob")){
//			
//			System.out.print("insertMemJob 들어옴");
//			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
//			//TodoDao.getDao().insertMemJob(map);
//			
//			url = "sumware?model=todo&submod=showMembersJob";
//			method = true;
//			
//		}else if(submod.equals("showMembersJob")){
//			System.out.println("showMembersJob들어옴");
//			int jobtonum = Integer.parseInt(request.getParameter("jobtonum"));
//			System.out.println("jobtonum : "+jobtonum);
//			//ArrayList<TodoJobVO> membersjoblist = TodoDao.getDao().getMembersJob(jobtonum);
//			// todoJobVO확인
//			//for(TodoJobVO v : membersjoblist){
////				System.out.println("memname : " + v.getMemname());
////				System.out.println("memprofile : " + v.getMemprofile());
////				System.out.println("jobcont : " + v.getJobcont());
////			}
//
//			//request.setAttribute("membersjoblist", membersjoblist);
//			url = "todo/membersJob.jsp";
//			method = true;
//			
//		}else if(submod.equals("showmemlist")){
//			// 부서업무부분, 팀업무부분에서 자세히보기 하면 정보들이 나옴
//			System.out.println("showmemlist들어옴");
//			int jobtonum = Integer.parseInt(request.getParameter("jobtonum"));
//			System.out.println("jobtonum : "+jobtonum);
//			//ArrayList<TodoJobVO> list = TodoDao.getDao().getMembersJob(jobtonum);
//			//request.setAttribute("memberjoblist", list);
//			url = "todo/jobDetail.jsp";
//			method = true;
//			
//		}else if(submod.equals("teamTodoForm")){
//			// 팀별 업무 리스트 뽑아오기
//			System.out.println("teamTodoForm들어옴");
//			int memmgr = Integer.parseInt(request.getParameter("memmgr"));
//			System.out.println("memmgr : "+ memmgr);
//			//ArrayList<TodoVO> list = TodoDao.getDao().getTeamJob(memmgr);
//			//request.setAttribute("teamJobList", list);
//			
//			url = "todo/teamTodoForm.jsp";
//			method = true;
//			
//		}else if(submod.equals("successJob")){
//			// 팀장의 업무 성공 처리
//			HashMap<String,String> map = MyMap.getMaps().getMapList(request);
//			//TodoDao.getDao().confirmTodo(map, "o");
//			
//			url = "sumware?model=todo&submod=teamTodoForm";
//			method = true;
//			
//		}
//		
//		return new ModelForward(url, method);
//	}
}
