package com.sumware.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;
import com.sumware.mvc.dao.MessengerDao;
import com.sumware.mvc.service.ServiceInter;
import com.sumware.util.SearchMem;

@Controller
public class MessengerController{
	@Autowired
	private MessengerDao medao;
	
	@Autowired
	@Qualifier(value="messenger")
	private ServiceInter mesService;

	// 메신저 폼
	@RequestMapping(value = "/samessengerForm")
	public String messengerForm(HttpSession session, Model model) {
		String first = (String) session.getAttribute("first");
		if(first.equals("1")){
			return "safirstLoginForm";
		}else if(first.equals("0")){
			session.invalidate();
			return "home";
		}else{
			List<MemberVO> list = medao.getList();
			ArrayList<MemberVO> resList = new ArrayList<MemberVO>();
			
			MemberVO vo = (MemberVO) session.getAttribute("v");
			int userNum = vo.getMemnum();
			
			for(MemberVO v : list){
				if(userNum != v.getMemnum()){
//					System.out.println("memnum:"+v.getMemnum());
					resList.add(v);
				}
			}
			model.addAttribute("list", resList);
		}
		return "messenger/open/messenger";
	}

	// 초기 방을 만들 경우
	@RequestMapping(value = "/samessengerChat",method=RequestMethod.POST)
	public String messengerChat(String fromNum, String toNum, String entNum,
			HttpServletRequest req, Model model) {
		// 보낸 사람 사번 받아오기
		int mesendNum = Integer.parseInt(fromNum);
		// 받는 사람 사번 받아오기 (toNum)

		// 전체 참여
		String entryNum = entNum;
		String[] entryNum1 = entryNum.split(",");
		// 사용자 IP 주소 받아오기
		String reip = req.getRemoteAddr();
		ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
		int entNum1 = 0; // 참가자 사번 초기화
		String ckmem = "N";
		// 방table vo 생성, 사용자 ip 저장 목적
		MessengerRoomVO mrvo = new MessengerRoomVO();

		for (String e : entryNum1) {
			MessengerVO mevo = new MessengerVO();

			entNum1 = Integer.parseInt(e);
			if (entNum1 == mesendNum) { // 개설자인 경우
				ckmem = "Y";
				mevo.setMesmember(entNum1);
				mevo.setOpenmemberyn(ckmem);
				mevo.setMesreip(reip); // 개설자 ip
				mrvo.setMasreip(reip); // master vo에 ip주소 저장
			} else { // 참여자인 경우
				mevo.setMesmember(entNum1);
				mevo.setOpenmemberyn(ckmem);
			}
			list.add(mevo);

		}

		int keynum = mesService.insertCreateRoomService(list, mrvo, mesendNum);
//		System.out.println("keynum :" + keynum);

//		// 친구찾기 기능을 위해 List 객체를 가져옴
//		List<MemberVO> memList = medao.getList();
//		model.addAttribute("memList", memList);

		StringBuffer ipAdd = new StringBuffer();
		// "ws://192.168.7.234:80/sumware/msgSocket/";
		// ipAdd.append("192.168.7.234");
		ipAdd.append("ws://");
		ipAdd.append(reip);
		ipAdd.append(":80/sumware/samsgSocket/");
//		System.out.println("IP Adress : " + ipAdd);

		model.addAttribute("ipAdd", ipAdd.toString());

		String userName = SearchMem.getSmem().searchMember(
				Integer.parseInt(toNum));
		model.addAttribute("userNum", mesendNum); // 보낸 사람, 방장
		model.addAttribute("userName", userName);
		model.addAttribute("toNum", toNum); // 받는 사람
		model.addAttribute("key", keynum);

		return "messenger/open/msgChat";

	}
	
	
	@RequestMapping(value="/samsgReceieve",method=RequestMethod.POST)
	public String msgReceieve(HttpServletRequest request,Model model){
		String struserNum = request.getParameter("userNum2");
		System.out.println("msgReceive userNum : "+struserNum);
		String[] edate = request.getParameter("edata1").split("/");
		
//		 for(String e : edate){
//			 System.out.println("푸쉬를 통해 넘어온 param : "+e);
//		 }
		 // push를 통해 방번호, 송신자 ip, 참가자(수신자 사번) 순으로 전송하기에 split으로 각 data를 배열 형식으로 저장
		 int keyNum = Integer.parseInt(edate[0]);
		 String reip = edate[1];
		 int userNum = Integer.parseInt(edate[2]); // 받는 사람 userNum
		 int mesendNum = Integer.parseInt(edate[3]); // 보낸 사람 방장 mesendNum
		
//		 System.out.println("Model에서의 IP : "+reip);
		 MessengerVO v = new MessengerVO();
		 v.setMesnum(keyNum);
		 v.setMesmember(userNum);
		 v.setMesreip(reip);
		 // 요청자 사번을 받아올수 있음.
		 medao.joinRoom(v);
		
		 StringBuffer ipAdd = new StringBuffer();
		 ipAdd.append("ws://");
		 ipAdd.append(reip);
		 ipAdd.append(":80/sumware/samsgSocket/");
		
		 String userName = SearchMem.getSmem().searchMember(mesendNum);
		
//		 System.out.println("IP Adress : "+ipAdd);
		 // request.setAttribute("memList", memList);
		 model.addAttribute("userNum", userNum); // 참가자 사번, 받는 사람
		 model.addAttribute("key", keyNum);
		 model.addAttribute("userName", userName);
		 model.addAttribute("mesendNum", mesendNum); // 방장 사번 , 보낸 사람
		 model.addAttribute("ipAdd", ipAdd.toString());
		
		 // DB 정보 업데이트 : entryTable의 시작일을 수정해줘야함
		
		return "messenger/open/msgChat";
	}
	@RequestMapping(value="/sacloseChat",method=RequestMethod.POST)
	public String closeChat(MessengerVO mevo,HttpServletRequest request){
//		System.out.println("여기는 model의 closeRoom 입니다.============");
		
		 // msgChat영역에서 넘어온 파라미터 처리
		 // 상태 여부 확인 chState : room 과 mesMain으로 구분
		 int userNum = Integer.parseInt(request.getParameter("userNum"));
		 int roomkey = Integer.parseInt(request.getParameter("roomKey"));
//		 System.out.println("Closechat userNum : "+userNum);
//		 System.out.println("Closechat roomkey : "+roomkey);
		
		 mevo.setMesmember(userNum);
		 mevo.setMesnum(roomkey);
		 mesService.closeRoomService(mevo);
		
		 // 창을 닫기 때문에 url 주소는 없어도 무관함
		 return "redirect:samessengerForm";
	}
	// messenger main에서 넘어온 경우 요청 거부 시
	@RequestMapping(value="/sarefuseChat",method=RequestMethod.POST)
	public String refuserChat(MessengerVO mevo, HttpServletRequest request){
		 // messenger.jsp에서 넘어온 파라미터 처리
		 System.out.println("refuseChat 영역입니다.==========");
		 String mainstate = request.getParameter("stateMain");
		 String struserNum = request.getParameter("userNum2"); // 이상하게 null값이
		 // 출력 확인 필요
		 System.out.println("msgReceive userNum : " + struserNum);
		
		 String[] edate = request.getParameter("edata1").split("/");
		 for (String e : edate) {
		 System.out.println("대화 거절 시 푸쉬를 통해 넘어온 param : " + e);
		 }
		 // push를 통해 방번호, 송신자 ip, 참가자(수신자 사번) 순으로 전송하기에 split으로 각 data를 배열
		 // 형식으로 저장
		 int keyNum = Integer.parseInt(edate[0]);
		 String reip = edate[1];
		 int reciuserNum = Integer.parseInt(edate[2]);
		 int mesendNum = Integer.parseInt(edate[3]); // 채팅창 종료이기 때문에 해당 파라미터는 없어도 무관함
		
		 mevo.setMesmember(reciuserNum);
		 mevo.setMesnum(keyNum);
		 mevo.setResState(mainstate);
		 mesService.closeRoomService(mevo);
		
		 request.setAttribute("key", keyNum);
		 request.setAttribute("userNum", reciuserNum);
		 return "messenger/open/refuseChat";
	}
	//채팅방 푸쉬
	@RequestMapping(value="/samesCheck")
	public void mesCheck(HttpServletResponse response,HttpSession session) throws IOException{
//		System.out.println("서버 푸시 영역");	
		MemberVO mvo = (MemberVO)session.getAttribute("v");
		int userNum = mvo.getMemnum();
		
		// DB에서 userNum(받는 사람 사번)인 경우만 조회해서 list에 저장
		List<MessengerVO> list = medao.getentList(userNum);
		
		for(MessengerVO e : list){
			String mesendName = null;
			int memberNum = 0;
			String openyn = null;
			String stdate = "default";
			int mesendNum = 0;
			
			memberNum=e.getMesmember(); // 사용자가 userNum인 경우만 참가자 목록 조회

			openyn = e.getOpenmemberyn();
//			System.out.println("openyn : "+openyn);
//			System.out.println("memberNum : "+memberNum);		
//			System.out.println("userNum : "+userNum);

			stdate = e.getEntstdate();
			
			StringBuffer outs = new StringBuffer();
			outs.append("data:");
			if(memberNum == userNum && openyn.equals("N") && stdate == null ){ // 받는 사람 
				System.out.println("방번호는 : "+e.getMesnum());
				outs.append(e.getMesnum()); // 방번호
				outs.append("/");
				outs.append(e.getMesreip()); // 방장 ip
				outs.append("/");
				outs.append(e.getMesmember()); // 수신자 사번
				outs.append("/");
				outs.append(e.getMesendnum()); // 송신자 사번
				outs.append("/");
				mesendName = SearchMem.getSmem().searchMember(e.getMesendnum());
				outs.append(mesendName); // 송신자 이름
				outs.append("\n\n");
//				System.out.println("메세지 송신 시 전송될 파라미터 : "+outs);
			}
			response.setHeader("cache-control", "no-cache");
			response.setContentType("text/event-stream");
			PrintWriter pw = response.getWriter();
			pw.print(outs);
			pw.flush();
		}
	}
	
	@RequestMapping(value="/samesCountMsg")
	public void mesCountMsg(HttpServletResponse response,HttpSession session) throws IOException{
//		System.out.println("Main Push 영역");
		
		MemberVO v = (MemberVO)session.getAttribute("v");
		int userNum = v.getMemnum();
		int countNum = medao.countRoomNum(userNum);
		StringBuffer outs = new StringBuffer();
		outs.append("data:");
		outs.append("(");
		outs.append(countNum);
		outs.append(")");
		outs.append("\n\n");
//		System.out.println("Count Num 메세지 송신 시 전송될 파라미터 : "+outs);
		
		response.setHeader("cache-control", "no-cache");
		response.setContentType("text/event-stream");
		PrintWriter pw = response.getWriter();
		pw.print(outs);
		pw.flush();
	}
	@RequestMapping(value="/samesListLoad")
	public void mesListLoad(HttpServletResponse response,HttpSession session) throws IOException{
//		System.out.println("사용자 List 출력, listLoad.jsp");
		// 현재 사용자 정보를 가져옴
		MemberVO v = (MemberVO)session.getAttribute("v");
		int userNum = v.getMemnum();
		
		// DB에서 검색한 사원 정보를  list에 저장
		List<MemberVO> list = medao.getList();
//		System.out.println("listLoad Array size : "+list.size());
		ArrayList<MemberVO> resList = new ArrayList<MemberVO>();
		for(MemberVO mvo : list){
			if(userNum != mvo.getMemnum()){
//				System.out.println("list:"+mvo.getMemnum());
				resList.add(mvo);
			}
		}
		StringBuffer outs = new StringBuffer();
		outs.append("data:");
//		System.out.println("userNum : "+userNum);
		for(MemberVO e : resList){
			outs.append("<tr>");
			outs.append("<td>");		
			outs.append("<img src='resources/profileImg/");
			outs.append(e.getMemprofile());
			outs.append("' alt='' class='img-circle' style='width: 50px; height: 50px;'>");
			outs.append("<a href='javascript:mesgoUrl(");
			outs.append(e.getMemnum());
			outs.append(")' class='primary-font'>");
			outs.append("<strong class='primary-font'>");
			outs.append(e.getMemname());
			outs.append("</strong>");
			outs.append("<strong class='primary-font'>");
			outs.append(e.getMemnum());
			outs.append("</strong>");
			outs.append("<strong class='primary-font'>");
			outs.append(e.getDename());
			outs.append("</strong>");		
			outs.append("</a>");
			outs.append("</td>");
			outs.append("</tr>");
		}
		outs.append("\n\n");
//		System.out.println("전송될 파라미터 : "+outs);
		
		response.setHeader("cache-control", "no-cache");
		response.setContentType("text/event-stream");
		PrintWriter pw = response.getWriter();
		pw.print(outs);
		pw.flush();
	}
	
	// @Override
	// public ModelForward exe(HttpServletRequest request,
	// HttpServletResponse response) throws IOException {
	// String submod = request.getParameter("submod");
	// System.out.println("submod : "+submod);
	// String url = "login.jsp";
	// boolean method = true;
	//
	// if(submod != null && submod.equals("messengerForm")){
	//
	// url = "messenger/messenger.jsp";
	// method = true;
	//
	// // int userNum = Integer.parseInt(request.getParameter("userNum"));
	// // ArrayList<MemberVO> list = MessengerDao.getDao().getList(userNum);
	// // request.setAttribute("list", list);
	//
	// System.out.println("MessengerModel 영역입니다.");
	//
	// // 초기 방을 만들 경우
	// }else if(submod != null && submod.equals("messengerChat")){
	// // 보낸 사람 사번 받아오기
	// int mesendNum = Integer.parseInt(request.getParameter("fromNum"));
	// // 받는 사람 사번 받아오기
	// int toNum = Integer.parseInt(request.getParameter("toNum"));
	// // 전체 참여자 사번 받아오기
	// String entryNum = request.getParameter("entNum");
	// String[] entryNum1 = entryNum.split(",")
	// // 사용자 IP 주소 받아오기
	// String reip = request.getRemoteAddr();
	// System.out.println("ip : "+reip);
	//
	//
	//
	// ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
	// int entNum = 0; // 참가자 사번 초기화
	// String ckmem = "N";
	// // 방table vo 생성, 사용자 ip 저장 목적
	// MessengerRoomVO rv = new MessengerRoomVO();
	//
	// for(String e : entryNum1){
	// MessengerVO v = new MessengerVO();
	//
	// entNum = Integer.parseInt(e);
	// if(entNum==mesendNum){ // 개설자인 경우
	// ckmem = "Y";
	// v.setMesmember(entNum);
	// v.setOpenmemberyn(ckmem);
	// v.setMesreip(reip); // 개설자 ip
	// rv.setMasreip(reip); // master vo에 ip주소 저장
	//
	// }else{ // 참여자인 경우
	// v.setMesmember(entNum);
	// v.setOpenmemberyn(ckmem);
	// }
	// list.add(v);
	// System.out.println(e);
	// }
	// System.out.println(list.size());
	//
	// int keynum = MessengerDao.getDao().insertCreateRoom(list, rv, mesendNum);
	// System.out.println("keynum : "+keynum);
	// ///////////////////////////////////////////
	// // 친구찾기 기능을 위해 List 객체를 가져옴
	// // ArrayList<MemberVO> memList = MessengerDao.getDao().getList();
	// // request.setAttribute("memList", memList);
	//
	//
	//
	// StringBuffer ipAdd = new StringBuffer();
	// // "ws://192.168.7.234:80/sumware/msgSocket/";
	// // ipAdd.append("192.168.7.234");
	// ipAdd.append("ws://");
	// ipAdd.append(reip);
	// ipAdd.append(":80/sumware/msgSocket/");
	// System.out.println("IP Adress : "+ipAdd);
	//
	// request.setAttribute("ipAdd", ipAdd.toString());
	//
	// String userName = SearchMem.getSmem().searchMember(toNum);
	// request.setAttribute("userNum", mesendNum); // 보낸 사람, 방장
	// request.setAttribute("userName", userName);
	// request.setAttribute("toNum", toNum); // 받는 사람
	// request.setAttribute("key", keynum);
	// url = "messenger/msgChat.jsp";
	// method = true;
	//
	//
	// // 참가자 join 경우
	// }else if(submod != null && submod.equals("msgReceieve")){
	//
	// //=========================================================
	// // 이상하게 null이 나옴, 확인 필요
	// String struserNum = request.getParameter("userNum2");
	// System.out.println("msgReceive userNum : "+struserNum);
	//
	//
//	 String[] edate = request.getParameter("edata1").split("/");
//	
//	 for(String e : edate){
//	 System.out.println("푸쉬를 통해 넘어온 param : "+e);
//	 }
//	 // push를 통해 방번호, 송신자 ip, 참가자(수신자 사번) 순으로 전송하기에 split으로 각 data를 배열 형식으로 저장
//	 int keyNum = Integer.parseInt(edate[0]);
//	 String reip = edate[1];
//	 int userNum = Integer.parseInt(edate[2]); // 받는 사람 userNum
//	 int mesendNum = Integer.parseInt(edate[3]); // 보낸 사람 방장 mesendNum
//	
//	 System.out.println("Model에서의 IP : "+reip);
//	 MessengerVO v = new MessengerVO();
//	 v.setMesnum(keyNum);
//	 v.setMesmember(userNum);
//	 v.setMesreip(reip);
//	 // 요청자 사번을 받아올수 있음.
//	 MessengerDao.getDao().joinRoom(v);
//	
//	 // ArrayList<MemberVO> memList = MessengerDao.getDao().getList();
//	
//	 StringBuffer ipAdd = new StringBuffer();
//	 ipAdd.append("ws://");
//	 ipAdd.append(reip);
//	 ipAdd.append(":80/sumware/msgSocket/");
//	
//	 String userName = SearchMem.getSmem().searchMember(mesendNum);
//	
//	 System.out.println("IP Adress : "+ipAdd);
//	 // request.setAttribute("memList", memList);
//	 request.setAttribute("userNum", userNum); // 참가자 사번, 받는 사람
//	 request.setAttribute("key", keyNum);
//	 request.setAttribute("userName", userName);
//	 request.setAttribute("mesendNum", mesendNum); // 방장 사번 , 보낸 사람
//	 request.setAttribute("ipAdd", ipAdd.toString());
//	
//	 // DB 정보 업데이트 : entryTable의 시작일을 수정해줘야함
//	
	// url = "messenger/msgChat.jsp";
	// method = true;
	//
	// // 참가자가 채팅방에서 나간 경우(창이 종료됨)
	// // 방번호와 참여자 사번을 가지고 DB의 종료일자를 수정
	// }else if(submod != null && submod.equals("closeChat")){
//	 System.out.println("여기는 model의 closeRoom 입니다.============");
//	
//	 // msgChat영역에서 넘어온 파라미터 처리
//	 // 상태 여부 확인 chState : room 과 mesMain으로 구분
//	 int userNum = Integer.parseInt(request.getParameter("userNum"));
//	 int roomkey = Integer.parseInt(request.getParameter("roomKey"));
//	 String roomstate = request.getParameter("resState");
//	 System.out.println("Closechat userNum : "+userNum);
//	 System.out.println("Closechat roomkey : "+roomkey);
//	 System.out.println("Closechat roomstate : "+roomstate);
//	
//	 MessengerVO v = new MessengerVO();
//	 v.setMesmember(userNum);
//	 v.setMesnum(roomkey);
//	 MessengerDao.getDao().closeRoom(v, roomstate);
//	
//	 // 창을 닫기 때문에 url 주소는 없어도 무관함
//	 url = "sumware?model=messenger&submod=messengerForm";
	// method = true;
	//
	// // messenger main에서 넘어온 경우 요청 거부 시
	// }else if(submod != null && submod.equals("refuseChat")){
//	 // messenger.jsp에서 넘어온 파라미터 처리
//	 System.out.println("refuseChat 영역입니다.==========");
//	 String mainstate = request.getParameter("stateMain");
//	 String struserNum = request.getParameter("userNum2"); // 이상하게 null값이
//	 // 출력 확인 필요
//	 System.out.println("msgReceive userNum : " + struserNum);
//	
//	 String[] edate = request.getParameter("edata1").split("/");
//	 for (String e : edate) {
//	 System.out.println("대화 거절 시 푸쉬를 통해 넘어온 param : " + e);
//	 }
//	 // push를 통해 방번호, 송신자 ip, 참가자(수신자 사번) 순으로 전송하기에 split으로 각 data를 배열
//	 // 형식으로 저장
//	 int keyNum = Integer.parseInt(edate[0]);
//	 String reip = edate[1];
//	 int reciuserNum = Integer.parseInt(edate[2]);
//	 int mesendNum = Integer.parseInt(edate[3]); // 채팅창 종료이기 때문에 해당 파라미터는 없어도
//	 무관함
//	
//	 MessengerVO v = new MessengerVO();
//	 v.setMesmember(reciuserNum);
//	 v.setMesnum(keyNum);
//	 MessengerDao.getDao().closeRoom(v, mainstate);
//	
//	 request.setAttribute("key", keyNum);
//	 request.setAttribute("userNum", reciuserNum);
//	 url = "messenger/refuseChat.jsp";
	// // url="sumware?model=messenger&submod=messengerForm";
	// method=true;
	// }
	//
	//
	//
	//
	// return new ModelForward(url, method);
	// }

}
