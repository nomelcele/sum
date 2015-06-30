package com.sumware.mvc.model;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
	
	// *******************
	// 왼쪽 메뉴에서 각 메일함에 있는 메일의 갯수를 보여주기 위한 메서드 호출
	// => AOP 처리
	
	// 메일 작성 form 이동
	@RequestMapping(value="/mailWriteForm")
	public String mailWriteForm(@ModelAttribute("mailreceiver")String mailreceiver,
			@ModelAttribute("mailtitle")String mailtitle){
		System.out.println("Mail Controller: mailWriteForm");
		return "mail/mailWrite";
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
		
		mav.setViewName("mail/mailSend"); // 메일 전송 완료 화면
		return mav;
	}
	
	// suggest(mailSug)
	@RequestMapping(value="/mailSug")
	public ModelAndView mailSug(String key){
		System.out.println("Mail Controller: mailSug");
		ModelAndView mav = new ModelAndView();
		// request.setCharacterEncoding("UTF-8");
		
		String[] suggests = Suggest.getSuggest().getSuggest(key);
		mav.addObject("sugArr", suggests);
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
		mav.addObject("sug", su.toString());
		mav.setViewName("mail/mailSuggest");
		
		return mav;
	}
	
	// 받은 메일함 이동
	@RequestMapping(value="/mailFromList")
	public ModelAndView mailFromList(@RequestParam Map<String,String> map,
			HttpServletRequest request){
		System.out.println("Mail Controller: mailFromList");
		ModelAndView mav = new ModelAndView();
		// 받은 메일함에 있는 메일 갯수 얻어오기
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
		mav.setViewName("mail/mailList");
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
		mav.setViewName("mail/mailList");
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
		mav.setViewName("mail/mailList");
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
		mav.setViewName("mail/mailList");
		return mav;
		
	}
	
	// 메일 상세 보기
	@RequestMapping(value="/mailDetail")
	public ModelAndView mailDetail(@RequestParam("mailnum")int mailnum){
		System.out.println("Mail Controller: mailDetail");
		ModelAndView mav = new ModelAndView();
		
		// 상세 사항을 볼 메일의 번호(mailnum)를 통해 select
		// 메일의 정보를 가져옴
		MailVO detail = mdao.getMailDetail(mailnum);
		mav.addObject("detail", detail);
		mav.setViewName("mail/mailDetail");
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
		switch(tofrom){
			default: // 받은 메일함
				return "redirect:/mailFromList?page=1";
			case 2: // 보낸 메일함
				return "redirect:/mailToList?page=1";
			case 3: // 내게 쓴 메일함
				return "redirect:/mailMyList?page=1";
			case 4: // 휴지통
				return "redirect:/mailTrashcan?page=1";
		}
		
	}
	
	/* 
	// ---------------------------------------------
	// ---------------------------------------------
	// ---------------------------------------------
	// 6/30 작업 중
	// aop 작업해야 됨
	// ---------------------------------------------
	// ---------------------------------------------
	// ---------------------------------------------
	
	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String submod = request.getParameter("submod");
		String url = "";
		boolean method = true; // forward
		
		HashMap<String,String> map = MyMap.getMaps().getMapList(request);
		
//	    if(submod != null && submod.equals("mailWriteForm")){
//			String toMem = map.get("toMem");
//			String mailtitle = map.get("mailtitle");
//			
//			if(toMem != null){
//				System.out.println("toMem: "+toMem);
//				request.setAttribute("toMem", toMem);
//				request.setAttribute("mailtitle", mailtitle);
//			}
//			
//			url = "mail/mailWrite.jsp";
//			method = true;
			
		if(submod != null && submod.equals("mailWrite")){
			System.out.println("현재 submod: mailWrite");
			request.setCharacterEncoding("UTF-8");
			try {
				HashMap<String, String> fmap = MyFileUp.getFup().fileUp("attach", request);
				
				boolean res = MailDao.getDao().addMail(fmap); // db에 메일 정보 넣기
				System.out.println(res);
				
				if(res){
					url = "mail/mailSend.jsp"; // 메일 전송 완료 페이지
					method = true;
				}
			} catch (ServletException e) {
				e.printStackTrace();
			}
			
//		} else if(submod != null && submod.equals("mailFromList")){
//			// 받은 메일함
//			System.out.println("현재 submod: mailFromList");
//			
//			// 받은 메일함에 있는 메일의 수
//			int totalCount = MailDao.getDao().getListNum(map)[0];
//			System.out.println("받은 메일함 메일 갯수: "+totalCount);
//			Map<String, Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//			
//			System.out.println("로그인한 사원 번호: "+map.get("usernum"));
//			System.out.println("로그인한 사원 아이디: "+map.get("userid"));
//			
//			ArrayList<MailVO> fromlist = MailDao.getDao().getFromMailList(map, pmap);
//			
//			request.setAttribute("list", fromlist);
//			request.setAttribute("tofrom", 1);
//			
//			url = "mail/mailList.jsp";
//			method = true;
//		} else if(submod != null && submod.equals("mailToList")){
//			System.out.println("현재 submod: mailToList");
//			// 보낸 메일함
//			// 현재 로그인한 사원의 사원 번호
//			
//			// 보낸 메일함에 있는 메일의 수
//			int totalCount = MailDao.getDao().getListNum(map)[1];
//			Map<String, Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//						
//			ArrayList<MailVO> tolist = MailDao.getDao().getToMailList(map,pmap);
//			
//			request.setAttribute("list", tolist);
//			request.setAttribute("tofrom", 2);
//			
//			url = "mail/mailList.jsp";
//			method = true;
		} else if(submod != null && submod.equals("mailSug")){
			// 메일 쓰기 받는 사람에서 suggest 기능
			request.setCharacterEncoding("UTF-8");
			String key = request.getParameter("key");
			
			String[] suggests = Suggest.getSuggest().getSuggest(key);
			request.setAttribute("sugArr", suggests);
		
			System.out.println("key: "+key);
			System.out.println("배열: "+suggests[0]);
			
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
			request.setAttribute("sug", su.toString());

			url = "mail/mailSuggest.jsp";
			method = true;
//		} else if(submod != null && submod.equals("mailDetail")){
//			// 메일 상세 보기
//			// 메일 번호
//			System.out.println("현재 submod: mailDetail");
//			int mailnum = Integer.parseInt(request.getParameter("mailnum"));
//			
//			MailVO detail = MailDao.getDao().getMailDetail(mailnum);
//			
//			request.setAttribute("detail", detail);
//			
//			url = "mail/mailDetail.jsp";
//			method = true;
			
//		} else if(submod != null && submod.equals("mailMyList")){
//			System.out.println("현재 submod: mailMyList");
//			// 내게 쓴 메일함
//			
//			// 내게 쓴 메일함에 있는 메일의 수
//			int totalCount = MailDao.getDao().getListNum(map)[2];
//			Map<String, Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//			
//			ArrayList<MailVO> mylist = MailDao.getDao().getMyMailList(map, pmap);
//			
//			request.setAttribute("list", mylist);
//			request.setAttribute("tofrom", 3);
//			
//			url = "mail/mailList.jsp";
//			method = true;
//			
//		} else if(submod != null && submod.equals("mailTrashcan")){
//			System.out.println("현재 submod: mailTrashList");
//			// 메뉴에서 휴지통을 클릭했을 때
//
//			
//			// 휴지통에 있는 메일의 수
//			int totalCount = MailDao.getDao().getListNum(map)[3];
//			Map<String, Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//			
//			// 휴지통에서 보여줄 메일 리스트
//			ArrayList<MailVO> trashlist = MailDao.getDao().getTrashList(map,pmap);
//			request.setAttribute("list", trashlist);
//			request.setAttribute("tofrom", 4);
//			
//			url = "mail/mailList.jsp";
//			method = true;
//		}  else if(submod != null && submod.equals("mailSetDel")){
//			// 메일 테이블의 delete 속성 설정
//			System.out.println("현재 submod: mailSetDel");
//
//			
//			// 체크박스로 선택된 메일의 번호들 얻어오기
//			String[] mailnums = request.getParameterValues("chk");
//			mailnums[0]=mailnums[0].substring(mailnums[0].indexOf("=")+1);
//			for(String e:mailnums){
//				System.out.println("선택된 메일 번호: "+e);
//			}
//			
//			int tofrom = Integer.parseInt(map.get("tofrom"));
//			System.out.println("mailSetDel=="+tofrom);
//			
//			
//			MailDao.getDao().setDeleteAttr(mailnums, map);
//			// 받은 사람과 보낸 사람이 모두 영구 삭제한 메일을 db에서 삭제하기 위한 메서드
//			// MailDao.getDao().delMailFromDB(); 
//			ArrayList<MailVO> list = new ArrayList<MailVO>();
//			
//			int totalCount=0;
//			Map<String, Integer> pmap = null;
//			
//			switch(tofrom){
//				case 1: // 받은 메일함
//					System.out.println("받은메일함 갈꺼야");
//					totalCount = MailDao.getDao().getListNum(map)[0];
//					pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//					list = MailDao.getDao().getFromMailList(map, pmap);
//					break;
//				case 2: // 보낸 메일함
//					System.out.println("보낸메일함 고고");
//					totalCount = MailDao.getDao().getListNum(map)[1];
//					pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//					list = MailDao.getDao().getToMailList(map, pmap);
//					break;
//				case 3: // 내게 쓴 메일함
//					System.out.println("내게쓴메일함 고고");
//					totalCount = MailDao.getDao().getListNum(map)[2];
//					pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//					list = MailDao.getDao().getMyMailList(map, pmap);
//					break;
//				case 4: // 휴지통
//					System.out.println("휴지통 고고");
//					totalCount = MailDao.getDao().getListNum(map)[3];
//					pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
//					list = MailDao.getDao().getTrashList(map, pmap);
//					break;
//			}
//			
//		    request.setAttribute("list", list);
//			request.setAttribute("tofrom", tofrom);
//			
//			url = "mail/mailList.jsp";
//			method = true;
		}
	    
	    // 왼쪽 메뉴에서 각 메일함에 있는 메일의 갯수를 보여주기 위한 메서드 호출
		// ********************
		// ********************
		// ********************
		// ********** AOP 처리
		// ********************
		// ********************
		// ********************
	 	int[] numArr = MailDao.getDao().getListNum(map);
	 	for(int e:numArr){
	 		System.out.println("메일 갯수: "+e);
	 	}
	 	request.setAttribute("numArr", numArr);
		
		return new ModelForward(url, method);
	} 
	 */
	
}
