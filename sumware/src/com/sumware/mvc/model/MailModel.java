package com.sumware.mvc.model;

import java.io.File;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.MailVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.MailDao;
import com.sumware.mvc.service.ServiceInter;
import com.sumware.util.MyPage;
import com.sumware.util.Suggest;

@Controller
public class MailModel{
	@Autowired
	private MailDao mdao;
	@Autowired
	@Qualifier(value="mail")
	private ServiceInter service;

	// 메일 작성 form 이동
	@RequestMapping(value="/mailWriteForm",method=RequestMethod.POST)
	public String mailWriteForm(@ModelAttribute("mailreceiver")String mailreceiver,
			@ModelAttribute("mailtitle")String mailtitle,
			@ModelAttribute("orimail")String oriMail){
		System.out.println("Mail Controller: mailWriteForm");
		return "mail.mailWrite";
	}
	
	// 메일 작성
	@RequestMapping(value="/mailWrite",method=RequestMethod.POST)
	public ModelAndView mailWrite(@RequestParam("mailfile")MultipartFile mailfile,
			@RequestParam Map<String, String> map,HttpServletRequest request){
		// request.setCharacterEncoding("UTF-8");
		System.out.println("Mail Controller: mailWrite");
		ModelAndView mav = new ModelAndView();
		
		// 첨부 파일 업로드 작업
		HttpSession session = request.getSession();
		String r_path = session.getServletContext().getRealPath("/");
		String oriFn = mailfile.getOriginalFilename();
		StringBuffer path = new StringBuffer();
		path.append(r_path).append("\\upload\\").append(oriFn);
		System.out.println("File Upload Path: "+path.toString());
		
		File file = new File(path.toString());
		try {
			mailfile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		// 메일 정보 db에 추가
		map.put("mailfile", oriFn); // 첨부파일 이름
		map.put("mailmem", map.get("usernum")); // 발신자 사원 번호
		String mailreceiver = map.get("mailreceiver"); // 수신자 아이디
		int startidx = mailreceiver.indexOf("<")+1;
		int endidx = mailreceiver.indexOf("@");
		map.put("mailreceiver", mailreceiver.substring(startidx, endidx));
		System.out.println("첨부파일 이름: "+oriFn);
		System.out.println("발신자: "+map.get("usernum"));
		System.out.println("수신자: "+mailreceiver.substring(startidx, endidx));
		mdao.addMail(map);
		
		mav.setViewName("mail.mailSend"); // 메일 전송 완료 화면
		return mav;
	}
	
	// suggest(mailSug)
	@RequestMapping(value="/mailSug")
	public void mailSug(String key,HttpServletResponse response) throws IOException{
		System.out.println("Mail Controller: mailSug");
		// request.setCharacterEncoding("UTF-8");
		
		String[] suggests = Suggest.getSuggest().getSuggest(key);
		System.out.println("Key: "+key);
		for(String e:suggests){
			System.out.println("배열: "+e);
		}
		
		StringBuilder su = new StringBuilder();
		su.append("[");
		if(suggests != null){
			for(int i=0; i<suggests.length; i++){
				su.append("\"");
				su.append(suggests[i]);
				su.append("\"");
				if(!(i == suggests.length-1)){
					su.append(",");
				}
			}
		}
		su.append("]");
		
		PrintWriter pw = response.getWriter();
		pw.write(su.toString());
		pw.flush();
		pw.close();
		
	}
	
	// 받은 메일함 이동
	@RequestMapping(value="/mailFromList")
	public ModelAndView mailFromList(@RequestParam Map<String,String> map,
			HttpServletRequest request){
		System.out.println("Mail Controller: mailFromList");
		ModelAndView mav = new ModelAndView();
		// 받은 메일함에 있는 메일 갯수 얻어오기
		// 
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		System.out.println("userid::"+mvo.getMeminmail());
		System.out.println("usernum::"+mvo.getMemnum());
		map.put("userid", mvo.getMeminmail());
		map.put("usernum", String.valueOf(mvo.getMemnum()));
		
		int totalCount = mdao.getListNum(map)[0];
		System.out.println("받은 메일함 메일 갯수: "+totalCount);
		
		// 페이지 정보를 가져오기 위한 map
		Map<String,Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//		HashMap<String, String> map = new HashMap<String, String>();
//		map.put("usernum",usernum.toString()); // 로그인한 사용자의 사원 번호
//		map.put("userid", userid); // 로그인한 사용자의 아이디

		map.put("begin", pmap.get("begin").toString()); // 시작할 페이지
		map.put("end", pmap.get("end").toString()); // 마지막 페이지
		
		// 받은 메일함에 들어갈 메일 리스트 가져오기
		List<MailVO> fromlist = mdao.getFromMailList(map);
		mav.addObject("list", fromlist);
		mav.addObject("tofrom", 1);
		mav.setViewName("mail.mailList");
		request.getSession().setAttribute("model", "mail");
		return mav;
		
	}
	
	// 보낸 메일함 이동
	@RequestMapping(value="/mailToList")
	public ModelAndView mailToList(@RequestParam Map<String,String> map,
			HttpServletRequest request){
		System.out.println("Mail Controller: mailToList");
		ModelAndView mav = new ModelAndView();
		// 보낸 메일함에 있는 메일 갯수 얻어오기
		int totalCount = mdao.getListNum(map)[1];
		System.out.println("보낸 메일함 메일 갯수: "+totalCount);
		
		// 페이지 정보를 가져오기 위한 map
		Map<String,Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
		map.put("begin", pmap.get("begin").toString()); // 시작할 페이지
		map.put("end", pmap.get("end").toString()); // 마지막 페이지
		
		// 보낸 메일함에 들어갈 메일 리스트 가져오기
		List<MailVO> tolist = mdao.getToMailList(map);
		mav.addObject("list", tolist);
		mav.addObject("tofrom", 2);
		mav.setViewName("mail.mailList");
		return mav;
		
	}
	
	// 내게 쓴 메일함 이동
	@RequestMapping(value="/mailMyList")
	public ModelAndView mailMyList(@RequestParam Map<String,String> map,
			HttpServletRequest request){
		System.out.println("Mail Controller: mailMyList");
		ModelAndView mav = new ModelAndView();
		// 내게 쓴 메일함에 있는 메일 갯수 얻어오기
		int totalCount = mdao.getListNum(map)[2];
		System.out.println("내게 쓴 메일함 메일 갯수: "+totalCount);
		
		// 페이지 정보를 가져오기 위한 map
		Map<String,Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
		map.put("begin", pmap.get("begin").toString()); // 시작할 페이지
		map.put("end", pmap.get("end").toString()); // 마지막 페이지
		
		// 내게 쓴 메일함에 들어갈 메일 리스트 가져오기
		List<MailVO> mylist = mdao.getMyMailList(map);
		mav.addObject("list", mylist);
		mav.addObject("tofrom", 3);
		mav.setViewName("mail.mailList");
		return mav;
		
	}
	
	// 휴지통 이동
	@RequestMapping(value="/mailTrashcan")
	public ModelAndView mailTrashcan(@RequestParam Map<String,String> map,
			HttpServletRequest request){
		System.out.println("Mail Controller: mailTrashcan");
		ModelAndView mav = new ModelAndView();
		// 휴지통에 있는 메일 갯수 얻어오기
		int totalCount = mdao.getListNum(map)[3];
		System.out.println("휴지통 메일 갯수: "+totalCount);
		
		// 페이지 정보를 가져오기 위한 map
		Map<String,Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
		map.put("begin", pmap.get("begin").toString()); // 시작할 페이지
		map.put("end", pmap.get("end").toString()); // 마지막 페이지
		
		// 휴지통에 들어갈 메일 리스트 가져오기
		List<MailVO> trashlist = mdao.getTrashList(map);
		mav.addObject("list", trashlist);
		mav.addObject("tofrom", 4);
		mav.setViewName("mail.mailList");
		return mav;
		
	}
	
	// 메일 상세 보기
	@RequestMapping(value="/mailDetail",method=RequestMethod.POST)
	public ModelAndView mailDetail(@RequestParam("mailnum")int mailnum){
		System.out.println("Mail Controller: mailDetail");
		ModelAndView mav = new ModelAndView();
		
		MailVO detail = service.getDetailUpdate(mailnum);
		// 상세 사항을 볼 메일의 번호(mailnum)를 통해 select
		// 메일의 정보를 가져옴
		mav.addObject("detail", detail);
		mav.setViewName("mail.mailDetail");
		return mav;
		
	}
	
	// 메일 테이블의 delete 속성 설정
	@RequestMapping(value="/mailSetDel",method=RequestMethod.POST)
	public String mailSetDel(@RequestParam("chk")String[] mailnums,
			@RequestParam Map<String,String> map){
		System.out.println("Mail Controller: mailSetDel");
		for(String e:mailnums){
			// 체크된 메일의 번호들
			System.out.println("선택된 메일 번호: "+e);
		}
		
		service.setDeleteAttrService(mailnums, map);
		
		int tofrom = Integer.parseInt(map.get("tofrom"));
		String params = "usernum="+map.get("usernum")+"&userid="+map.get("userid")+"&page=1";
		switch(tofrom){
			default: // 받은 메일함
				return "redirect:/mailFromList?"+params;
			case 2: // 보낸 메일함
				return "redirect:/mailToList?"+params;
			case 3: // 내게 쓴 메일함
				return "redirect:/mailMyList?"+params;
			case 4: // 휴지통
				return "redirect:/mailTrashcan?"+params;
		}
		
	}
	
}
