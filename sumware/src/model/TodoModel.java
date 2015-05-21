package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import util.MyFileUp;
import util.MyMap;
import controller.ModelForward;
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
			method = true;
			
		}else if(submod.equals("addTodoForm")){
			int memmgr = Integer.parseInt(request.getParameter("memmgr"));
			
			System.out.println("memmgr : "+memmgr);
			ArrayList<MemberVO> list = TodoDao.getDao().getTomem(memmgr);
			request.setAttribute("teamNameList", list);
			url = "todo/addTodo.jsp";
			method = true;
		}else if(submod.equals("addTodo")){
			System.out.println("addTodo 들어왔어");
			String fname = request.getParameter("tofile");
			try {
				HashMap<String,String> map = MyFileUp.getFup().fileUp(fname, request);
			} catch (ServletException e) {
				
				e.printStackTrace();
			}
			url = "sumware?mod=todo&submod=todoForm";
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
		}
		
		return new ModelForward(url, method);
	}
	
	

}
