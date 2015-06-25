package model;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.CalendarVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.CalendarDAO;


@Controller
public class CalendarModel{
	
	@Autowired
	CalendarDAO dao;
	
	@RequestMapping(value="calList")
	public String getCalList(CalendarVO cavo,Model model,HttpSession session){
		MemberVO vo = new MemberVO();
		vo = (MemberVO) session.getAttribute("v");
		
		cavo.setCaldept(vo.getMemdept());
		cavo.setCalmem(vo.getMemnum());
		
		if(cavo.getCal()==null||cavo.getCal().equals("0")){
			//리스트를 불러와서 json형식으로 바꿈
			List<CalendarVO> list =dao.getCalList(cavo);
			
			String json = dao.makeJson(list);
	
			model.addAttribute("calJson", json);
			model.addAttribute("cal", "부서");
		}else{
			//리스트를 불러와서 json형식으로 바꿈
			List<CalendarVO> list = dao.getCalList(cavo);
			String json = dao.makeJson(list);
	
			model.addAttribute("calJson", json);
			model.addAttribute("cal", "사원");
		}
		return "calendar/calTest.jsp";
	}
	@RequestMapping(value="calInsert",method=RequestMethod.POST)
	public String calInsert(String title,CalendarVO cavo,Model model,HttpSession session) throws UnsupportedEncodingException{
		cavo.setCalcont(URLDecoder.decode(title,"UTF-8"));
		//		String end=map.get("end");
		//		if(end.length()<11){
		//			end=end.replaceAll("-", "");
		//			end=String.valueOf((Integer.parseInt(end)-1));
		//			map.put("end", end);
		//			
		//		}
		MemberVO vo = (MemberVO) session.getAttribute("v");
		//url 저장.
		String res="";
		//해당하지 않는 값을 0으로 세팅해준다.
		//같은키로 값을 세팅. 둘이 동시에 값이 들어가는 경우가 없으므로.
		if(cavo.getSelCal().equals("부서")){
			
			cavo.setCal(String.valueOf(vo.getMemdept()));
			
			res = "redirect:calList&calmem=0&caldept="+vo.getMemdept();
		}else{
			
			cavo.setCal(String.valueOf(vo.getMemnum()));
			
			res = "redirect:calList&caldept=0&calmem="+vo.getMemnum();
		}
		//-----------------------
		dao.calInsert(cavo);
		return res;
	}
	@RequestMapping(value="calDelete",method=RequestMethod.POST)
	public String calDel(CalendarVO cavo,Model model,HttpSession session){
		String res="";
		MemberVO vo = (MemberVO) session.getAttribute("v");
		dao.calDel(cavo.getCalnum());
		
		if(cavo.getSelCal().equals("부서")){
			res="redirect:calList&calmem=0&caldept="+vo.getMemdept();
		}else{
			res="redirect:calList&caldept=0&calmem="+vo.getMemnum();
		}
		return res;
	}

}
