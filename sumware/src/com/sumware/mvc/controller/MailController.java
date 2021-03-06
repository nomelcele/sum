package com.sumware.mvc.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.MailVO;
import com.sumware.dto.MemberVO;
import com.sumware.dto.ValidMailVO;
import com.sumware.mvc.dao.MailDao;
import com.sumware.mvc.service.ServiceInter;
import com.sumware.util.MyPage;
import com.sumware.util.Suggest;

@Controller
public class MailController{
	@Autowired
	private MailDao mdao;
	@Autowired
	@Qualifier(value="mail")
	private ServiceInter service;
	
	// Before Advice 적용

	// 메일 작성 form 이동
	@RequestMapping(value="/samailWriteForm",method=RequestMethod.POST)
	public String mailWriteForm(
			Model model,
			@ModelAttribute("mailreceiver")String mailreceiver,
			@ModelAttribute("mailtitle")String mailtitle,
			@ModelAttribute("orimail")String oriMail){
		System.out.println("Mail Controller: mailWriteForm");
		// 답장 클릭했을 경우: 원래 메일 제목, 원래 메일 내용 표시
		// 제목: RE: 원래 메일 제목
		// 메일 내용: -- orginal message --
		ValidMailVO vmavo = new ValidMailVO();
		// 메일 제목, 메일 받을 사람 부분에 유효성 검사 할 수 있도록
		model.addAttribute("writeForm", vmavo);
		return "mail.mailWrite";
	}
	
	// 메일 작성
	@RequestMapping(value="/samailWrite",method=RequestMethod.POST)
	public ModelAndView mailWrite(@Valid @ModelAttribute("writeForm") ValidMailVO vmavo,BindingResult result ,@RequestParam HashMap<String, String> map,
			@RequestParam("mailfile")MultipartFile mailfile,HttpSession session){
		// 메일 작성 form에서 전송 버튼을 클릭하면 이 메서드에서 요청을 처리한다.
		// vmavo에는 form에서 입력했던 받는 사람과 제목의 데이터가 들어간다.
		// @Valid 어노테이션이 붙어 있기 때문에, vmavo는 유효성 검사의 대상이 된다.
		ModelAndView mav = new ModelAndView();
		if(result.hasErrors()){
			// 유효성 검사에서 에러가 발생할 경우
			// 메일을 전송하지 않고 다시 작성 form으로 돌아가서 에러 메시지를 보여준다.
			System.out.println("에러다");
			mav.setViewName("mail.mailWrite");
		}else{
			// 첨부 파일 업로드 작업
			String r_path = session.getServletContext().getRealPath("/");
			String oriFn = mailfile.getOriginalFilename();
			StringBuffer path = new StringBuffer();
			// 파일이 업로드될 경로
			path.append(r_path).append("upload\\").append(oriFn);
			System.out.println("File Upload Path: "+path.toString());
			
			// 새로운 파일 객체 생성
			File file = new File(path.toString());
			if(!file.exists()){
				file.mkdirs();
			}
			
			try {
				// mailFile의 내용 복사
				mailfile.transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			// 메일 정보 db에 추가
			MemberVO mvo = (MemberVO) session.getAttribute("v");
			// 로그인한 회원 정보
			int usernum = mvo.getMemnum();
			String userid = mvo.getMeminmail();
			
			map.put("mailfile",oriFn); // 첨부파일 이름
			map.put("mailmem", String.valueOf(usernum)); // 발신자 사원 번호
			
			String mailreceiver = map.get("mailreceiver"); // 수신자 아이디
			int startidx = mailreceiver.indexOf("<")+1;
			int endidx = mailreceiver.indexOf("@");
			map.put("mailreceiver",mailreceiver.substring(startidx, endidx));
//			System.out.println("첨부파일 이름: "+oriFn);
//			System.out.println("발신자: "+map.get("mailmem"));
//			System.out.println("수신자: "+map.get("mailreceiver"));
			mdao.addMail(map);
			
			mav.setViewName("mail.mailSend"); // 메일 전송 완료 화면
		}
		return mav;
	}
	
	// suggest(mailSug)
	@RequestMapping(value="/samailSug")
	public void mailSug(String key,HttpServletResponse response) throws IOException{
//		System.out.println("Mail Controller: mailSug");
		// 5) 필요한 데이터 검색 후 배열 형태로 해당 데이터를 리턴해주는 메서드 호출
		String[] suggests = Suggest.getSuggest().getSuggest(key);
		
//		System.out.println("Key: "+key);
		for(String e:suggests){
			System.out.println("배열: "+e);
		}
		
		// 8) 배열에 있는 데이터들을 읽고, JSON 문법에 맞게 StringBuffer에 append
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
		
		// 9) 요청한 쪽으로 전달해줄 데이터를 스트림에 써준다.
		PrintWriter pw = response.getWriter();
		pw.write(su.toString());
		pw.flush();
		pw.close();
		
	}
	
	// 받은 메일함 이동
	@RequestMapping(value="/samailFromList")
	public ModelAndView mailFromList(HttpServletRequest request,HttpSession session){
//		System.out.println("Mail Controller: mailFromList");
		
		ModelAndView mav = new ModelAndView();
		// 메뉴에서 메일을 클릭했을 때 처음 진입하는 페이지가 받은 메일함
		String first = (String) session.getAttribute("first");
		if(first.equals("1")){
			// 가입 후 회원 정보 입력을 하지 않은 경우, 회원 정보 입력 폼으로 이동
			mav.setViewName("safirstLoginForm");
		}else if(first.equals("0")){
			// 퇴사한 사원의 경우 메일 서비스를 이용할 수 없음
			session.invalidate();
			mav.setViewName("home");
		}else{
			MemberVO mvo = (MemberVO) session.getAttribute("v");
//			System.out.println("userid::"+mvo.getMeminmail());
//			System.out.println("usernum::"+mvo.getMemnum());
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", mvo.getMeminmail());
			map.put("usernum", String.valueOf(mvo.getMemnum()));
			
			// 받은 메일함에 있는 메일 갯수 얻어오기
			int totalCount = mdao.getListNum(map)[0];
			System.out.println("받은 메일함 메일 갯수: "+totalCount);
			
			// 페이지 정보를 가져오기 위한 map
			// 한 페이지당 항목 15개, 5페이지씩 표시
			Map<String,Integer> pmap = MyPage.getMp().pageProcess(request, 15, 5, 0, totalCount, 0);
			map.put("begin", pmap.get("begin").toString()); // 시작할 페이지
			map.put("end", pmap.get("end").toString()); // 마지막 페이지
			
			// 받은 메일함에 들어갈 메일 리스트 가져오기
			List<MailVO> fromlist = mdao.getFromMailList(map);
			mav.addObject("list", fromlist);
			// tofrom: 현재 페이지가 어떤 메일함인지, 메일함의 유형 표시
			// 받은 메일함/보낸 메일함/.. 모두 한 JSP를 활용해서 view 페이지를 표시하기 때문에
			// 메일함의 유형을 알고 있어야 view 페이지에서 페이지 전환을 할 때 적절한 요청을 보낼 수 있음
			mav.addObject("tofrom", 1);
			mav.setViewName("mail.mailList");
			session.setAttribute("model", "mail");
		}
		return mav;
		
	}
	
	// 보낸 메일함 이동
	@RequestMapping(value="/samailToList")
	public ModelAndView mailToList(HttpServletRequest request,HttpSession session){
//		System.out.println("Mail Controller: mailToList");
		ModelAndView mav = new ModelAndView();
		
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", mvo.getMeminmail());
		map.put("usernum", String.valueOf(mvo.getMemnum()));
		
		// 보낸 메일함에 있는 메일 갯수 얻어오기
		int totalCount = mdao.getListNum(map)[1];
//		System.out.println("보낸 메일함 메일 갯수: "+totalCount);
		
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
	@RequestMapping(value="/samailMyList")
	public ModelAndView mailMyList(HttpServletRequest request,HttpSession session){
//		System.out.println("Mail Controller: mailMyList");
		ModelAndView mav = new ModelAndView();
		
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", mvo.getMeminmail());
		map.put("usernum", String.valueOf(mvo.getMemnum()));
		
		// 내게 쓴 메일함에 있는 메일 갯수 얻어오기
		int totalCount = mdao.getListNum(map)[2];
//		System.out.println("내게 쓴 메일함 메일 갯수: "+totalCount);
		
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
	@RequestMapping(value="/samailTrashcan")
	public ModelAndView mailTrashcan(HttpServletRequest request,HttpSession session){
//		System.out.println("Mail Controller: mailTrashcan");
		ModelAndView mav = new ModelAndView();
		
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", mvo.getMeminmail());
		map.put("usernum", String.valueOf(mvo.getMemnum()));
		
		// 휴지통에 있는 메일 갯수 얻어오기
		int totalCount = mdao.getListNum(map)[3];
//		System.out.println("휴지통 메일 갯수: "+totalCount);
		
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
	@RequestMapping(value="/samailDetail",method=RequestMethod.POST)
	public ModelAndView mailDetail(@RequestParam("mailnum")int mailnum){
//		System.out.println("Mail Controller: mailDetail");
		ModelAndView mav = new ModelAndView();
		
		MailVO detail = service.getDetailUpdate(mailnum);
		// 상세 사항을 볼 메일의 번호(mailnum)를 통해 select
		// 메일의 정보를 가져옴
		mav.addObject("detail", detail);
		mav.setViewName("mail.mailDetail");
		return mav;
		
	}
	
	// 메일 테이블의 delete 속성 설정
	@RequestMapping(value="/samailSetDel",method=RequestMethod.POST)
	public String mailSetDel(@RequestParam("chk")String[] mailnums,
			@RequestParam HashMap<String,String> map,HttpSession session){
//		System.out.println("Mail Controller: mailSetDel");
//		for(String e:mailnums){
//			// 체크된 메일의 번호들
//			System.out.println("선택된 메일 번호: "+e);
//		}
		
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		map.put("usernum", String.valueOf(mvo.getMemnum()));
		map.put("userid", mvo.getMeminmail());
		
		// 트랜잭션 처리
		service.setDeleteAttrService(mailnums, map);
		
		int tofrom = Integer.parseInt(map.get("tofrom"));
//		String params = "usernum="+map.get("usernum")+"&userid="+map.get("userid")+"&page=1";
		switch(tofrom){
			default: // 받은 메일함
				return "redirect:/samailFromList?page=1";
			case 2: // 보낸 메일함
				return "redirect:/samailToList?page=1";
			case 3: // 내게 쓴 메일함
				return "redirect:/samailMyList?page=1";
			case 4: // 휴지통
				return "redirect:/samailTrashcan?page=1";
		}
		
	}
	
}
