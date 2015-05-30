package model;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.MyMap;
import controller.ModelForward;
import dao.CalendarDAO;
import dto.CalendarVO;
import dto.MemberVO;

public class CalendarModel implements ModelInter{
	MemberVO vo=null;
	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String url="";
		//false: redirect true:forward
		boolean method=false;
		//submod의 값으로 확인
		String submod = request.getParameter("submod");
		System.out.println("cal submod:"+submod);

		if(submod!=null&&submod.equals("calList")){
			System.out.println("calList들어옴");
			url="calendar/calTest.jsp";
			
			HttpSession session = request.getSession();
			vo = (MemberVO) session.getAttribute("v");
			
			int caldept = vo.getMemdept();
			System.out.println("cal caldept:"+caldept);
			int calmem = vo.getMemnum();
			System.out.println("cal calmem:"+calmem);
			
			String cal = request.getParameter("cal");
			if(cal==null||cal.equals("0")){
				//리스트를 불러와서 json형식으로 바꿈
				String sql = CalendarDAO.getDao().calSQL(0);
				ArrayList<CalendarVO> list = CalendarDAO.getDao().getCalList(sql, caldept);
				String json = CalendarDAO.getDao().makeJson(list);
		
				request.setAttribute("calJson", json);
				request.setAttribute("cal", "부서");
			}else{
				//리스트를 불러와서 json형식으로 바꿈
				String sql = CalendarDAO.getDao().calSQL(1);
				ArrayList<CalendarVO> list = CalendarDAO.getDao().getCalList(sql, calmem);
				String json = CalendarDAO.getDao().makeJson(list);
		
				request.setAttribute("calJson", json);
				request.setAttribute("cal", "사원");
			}
			method=true;
		}else if(submod!=null&&submod.equals("calInsert")){
			String sql=null;
			String selCal=request.getParameter("selCal");
			System.out.println("selCal:"+selCal);
			
			String title = URLDecoder.decode(request.getParameter("title"),"UTF-8");
			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
			map.put("title", title);
			HttpSession session = request.getSession();
			vo = (MemberVO) session.getAttribute("v");
			
			//해당하지 않는 값을 0으로 세팅해준다.
			//같은키로 값을 세팅. 둘이 동시에 값이 들어가는 경우가 없으므로.
			if(selCal.equals("부서")){
				url="sumware?model=calendar&submod=calList&calmem=0&caldept="+vo.getMemdept();
				map.put("cal", String.valueOf(vo.getMemdept()));
				sql = CalendarDAO.getDao().calSQL(2);
			}else{
				url="sumware?model=calendar&submod=calList&caldept=0&calmem="+vo.getMemnum();
				map.put("cal", String.valueOf(vo.getMemnum()));
				sql = CalendarDAO.getDao().calSQL(3);
			}
			//-----------------------
			CalendarDAO.getDao().calInsert(sql,map);
			
			method=false;
		}else if(submod!=null&&submod.equals("calDelete")){
			System.out.println("caldelete 들어옴");
			
			String selCal=request.getParameter("selCal");
			System.out.println("selCal:"+selCal);
			
			HttpSession session = request.getSession();
			vo = (MemberVO) session.getAttribute("v");
			
			int num= Integer.parseInt(request.getParameter("calnum"));
			
			CalendarDAO.getDao().calDel(num);
			if(selCal.equals("부서")){
				url="sumware?model=calendar&submod=calList&calmem=0&caldept="+vo.getMemdept();
			}else{
				url="sumware?model=calendar&submod=calList&caldept=0&calmem="+vo.getMemnum();
			}
			method=false;
		}
		System.out.println("calendar url:"+url+" method:"+method);
		return new ModelForward(url, method);
	}

}
