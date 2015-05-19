package model;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ModelForward;
import dao.CalendarDAO;
import dto.CalendarVO;

public class CalendarModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String url="";
		//false: redirect true:forward
		boolean method=false;
		//submod의 값으로 확인
		String submod = request.getParameter("submod");
		System.out.println("cal submod:"+submod);
		if(submod!=null&&submod=="calList"){
			url="calendar/sumware?mode=calendar";
			//리스트를 불러와서 json형식으로 바꿈
			String json = CalendarDAO.getDao().makeJson();
			request.setAttribute("calJson", json);
			method=true;
		}else if(submod!=null&&submod=="calInsert"){
			url="calendar/sumware?mode=calendar&submod=calList";
			String title = URLDecoder.decode(request.getParameter("title"),"UTF-8");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			int caldiv=Integer.parseInt(request.getParameter("caldiv"));
			System.out.println("title:"+title);
			System.out.println("start:"+start);
			System.out.println("end:"+end);
			System.out.println("caldiv:"+caldiv);
			CalendarVO v = new CalendarVO();
			v.setCalcont(title);
			v.setCalstart(start);
			v.setCalend(end);
			v.setCaldiv(caldiv);
			//부서 번호와 멤버번호는 세션을 통해서 얻은 값을 입력받는다
			// 현재 임시로 데이터를 넣었다.
			v.setCaldept(10);
			v.setCalmem(10001);
			//-----------------------
			CalendarDAO.getDao().insertCal(v);
		}
		return new ModelForward(url, method);
	}

}
