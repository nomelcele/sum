package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.stereotype.Controller;

import com.sumware.dto.MemberVO;
import com.sumware.dto.TodoJobVO;
import com.sumware.dto.TodoVO;
import com.sumware.mvc.controller.ModelForward;
import com.sumware.mvc.dao.CalendarDAO;
import com.sumware.mvc.dao.TodoDao;
import com.sumware.util.MyFileUp;
import com.sumware.util.MyMap;

@Controller
public class TodoModel{

	
	
	
	
//	
//	@Override
//	public ModelForward exe(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		
//		String submod = request.getParameter("submod");
//		System.out.println("submod:"+submod);
//		String url ="todo/todoMain.jsp";
//		boolean method=false;
//		
//		if(submod.equals("todoForm")){
//			System.out.println("submod todoForm들어옴");
//		
//			int todept = Integer.parseInt(request.getParameter("memdept"));
//			System.out.println("memdept : "+todept);
//			
//			
//			//부서업무 리스트 뽑아줌
//			
////			ArrayList<TodoVO> deptJobList = TodoDao.getDao().getDeptJob(todept);
////			request.setAttribute("deptJobList", deptJobList);
//			
//			url = "todo/Todo.jsp";
//			method=true;	
//		}else if(submod.equals("firsttodoForm")){
//			int memnum = Integer.parseInt(request.getParameter("memnum"));
//			int todept = Integer.parseInt(request.getParameter("memdept"));
//			System.out.println("memdept : "+todept);
//			System.out.println("memnum : "+memnum);
////			ArrayList<MemberVO> list = TodoDao.getDao().getTomem(memnum);
//
//			HttpSession session = request.getSession();
////			session.setAttribute("teamNameList", list);
//			
//			//부서업무 리스트 뽑아줌
//			
////			ArrayList<TodoVO> deptJobList = TodoDao.getDao().getDeptJob(todept);
////			request.setAttribute("deptJobList", deptJobList);
//			
//			url = "todo/todoMain.jsp";
//			method=true;	
//			
//			
//		}else if(submod.equals("addtodoForm")){
//			System.out.println("addtodoForm 들어왔어");
//			
//			url="todo/addTodo.jsp";
//			method = true;		
//		}else if(submod.equals("addTodo")){
//			System.out.println("addTodo 들어왔어");
//			
//			String fname = "tofile";
//			try {
//				//todo 테이블에 등록.
//				HashMap<String,String> map = MyFileUp.getFup().fileUp(fname, request);
//				//TodoDao.getDao().addTodo(map);
//				
//				
//			} catch (ServletException e) {
//				
//				e.printStackTrace();
//			}
//			
//			url = "sumware?model=todo&submod=firsttodoForm";
//			method = true;
//			
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
