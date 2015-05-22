package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import util.MyFileUp;
import util.MyMap;
import controller.ModelForward;
import dao.CalendarDAO;
import dao.TodoDao;
import dto.MemberVO;
import dto.TodoVO;

public class TodoModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		String submod = request.getParameter("submod");
		System.out.println("submod:"+submod);
		String url ="index.jsp";
		boolean method=false;
		
		if(submod.equals("todoForm")){
			url = "todo/Todo.jsp";
			method=false;	
		}else if(submod.equals("addtodoForm")){
			System.out.println("addtodoForm 들어왔어");
			
			
			int memnum = Integer.parseInt(request.getParameter("memnum"));
			System.out.println("memnum : "+memnum);
			ArrayList<MemberVO> list = TodoDao.getDao().getTomem(memnum);
			for(MemberVO vv: list){
				System.out.println("::::"+vv.getMemname());
			}
			request.setAttribute("teamNameList", list);
			url="todo/addTodo.jsp";
			method = true;		
		}else if(submod.equals("addTodo")){
			System.out.println("addTodo 들어왔어");
			url = "sumware?mod=todo&submod=todoForm";
			String fname = "tofile";
			try {
				//todo 테이블에 등록.
				HashMap<String,String> map = MyFileUp.getFup().fileUp(fname, request);
				TodoDao.getDao().addTodo(map);
				//캘린더에 등록
				map.put("start",map.get("tostdate"));
				map.put("end", map.get("toendate"));
				map.put("title", map.get("totitle"));
				map.put("cal", map.get("todept"));
				String sql = CalendarDAO.getDao().calSQL(2);
				CalendarDAO.getDao().calInsert(sql, map);
				
			} catch (ServletException e) {
				
				e.printStackTrace();
			}
			
			method = false;
			
		}else if(submod.equals("checkTodoList")){
			// 업무 관리 클릭시 보여줄 화면 , 업무 리스트
			int tomem = Integer.parseInt(request.getParameter("memnum"));
			ArrayList<TodoVO> clist = TodoDao.getDao().checkTodoList(tomem);
			request.setAttribute("todoList", clist);
			String childmod = request.getParameter("childmod");
			if(childmod!=null && childmod.equals("approveTodo")){
				// 리스트의 승인여부 n을 y로 바꿈!!!!
				int tonum= Integer.parseInt(request.getParameter("tonum"));
				String tocomm = request.getParameter("tocomm");
				TodoDao.getDao().confirmTodo(tonum,tocomm, "y");
			}else if(childmod!=null && childmod.equals("rejectTodo")){
				// 리스트의 승인여부 n을 x로 바꿈!!!!
				int tonum= Integer.parseInt(request.getParameter("tonum"));
				String tocomm = request.getParameter("tocomm");
				TodoDao.getDao().confirmTodo(tonum,tocomm, "x");
			}
			
			url = "sumware?mod=todo&submod=checkTodoListForm";
			method = true;
			
		}else if(submod.equals("checkTodoListForm")){
			url = "todo/checkTodoList.jsp";
			method = true;
		}else if(submod.equals("fWMana")){
			url="todo/fWMana.jsp";
			String memdept = request.getParameter("memdept");
			ArrayList<TodoVO> fwList=TodoDao.getDao().getFWMana();
			request.setAttribute("fwList", fwList);
			method=true;
		}
		
		return new ModelForward(url, method);
	}
	
	

}
