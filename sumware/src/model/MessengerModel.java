package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ModelForward;
import dao.MessengerDao;
import dto.MemberVO;
import dto.MessengerRoomVO;
import dto.MessengerVO;

public class MessengerModel implements ModelInter{
	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String submod = request.getParameter("submod");
		System.out.println("submod : "+submod);
		String url = "login.jsp";
		boolean method = true;
		
		if(submod != null && submod.equals("messengerForm")){
			url = "messenger/messenger.jsp";
			method = true;
			
			// 여기에서 로그인 된 회원만 출력할 수 있도록 쿼리문 수정
			ArrayList<MemberVO> list = MessengerDao.getDao().getList();
			request.setAttribute("list", list);
			System.out.println("MessengerModel 영역입니다.");
			
			// 초기 방을 만들 경우
		}else if(submod != null && submod.equals("messengerChat")){
			// 보낸 사람 사번 받아오기
			int fromNum = Integer.parseInt(request.getParameter("fromNum"));
			// 받는 사람 사번 받아오기
			int toNum = Integer.parseInt(request.getParameter("toNum"));
			// 전체 참여자 사번 받아오기
			String entryNum = request.getParameter("entNum");			
			String[] entryNum1 = entryNum.split(",");
			// 사용자 IP 주소 받아오기
			String reip = request.getRemoteAddr();
			System.out.println("ip : "+reip);
			
			

			ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
			int entNum = 0; // 참가자 사번 초기화
			String ckmem = "N";
			// 방table vo 생성, 사용자 ip 저장 목적
			MessengerRoomVO rv = new MessengerRoomVO();
			
			for(String e : entryNum1){
				MessengerVO v = new MessengerVO();
				
				entNum = Integer.parseInt(e);
				if(entNum==fromNum){ // 개설자인 경우
					ckmem = "Y";
					v.setMesmember(entNum);
					v.setOpenmemberyn(ckmem);
					v.setMesreip(reip); // 개설자 ip
					rv.setMasreip(reip); // master vo에 ip주소 저장
					
				}else{ // 참여자인 경우
					v.setMesmember(entNum);
					v.setOpenmemberyn(ckmem);
				}
				list.add(v);
				System.out.println(e);
			}
			System.out.println(list.size());
			
			int keynum = MessengerDao.getDao().insertCreateRoom(list, rv);
			System.out.println("keynum : "+keynum);
			
			// 친구찾기 기능을 위해 List 객체를 가져옴
			ArrayList<MemberVO> memList = MessengerDao.getDao().getList();			
			request.setAttribute("memList", memList);
			
			
			
			StringBuffer ipAdd = new StringBuffer();
//			"ws://192.168.7.234:80/sumware/msgSocket/";
//			ipAdd.append("192.168.7.234");
			ipAdd.append("ws://");
			ipAdd.append(reip);
			ipAdd.append(":80/sumware/msgSocket/");
			System.out.println("IP Adress : "+ipAdd);
			
			request.setAttribute("ipAdd", ipAdd.toString());
			request.setAttribute("userNum", fromNum); // 보낸 사람, 방장
			request.setAttribute("toNum", toNum); // 받는 사람
			request.setAttribute("key", keynum);
			url = "messenger/msgChat.jsp";
			method = true;
			
			
			// 참가자 join 경우 
		}else if(submod != null && submod.equals("msgReceieve")){
			
			//=========================================================
			// 이상하게 null이 나옴, 확인 필요
			String struserNum = request.getParameter("userNum2");
			System.out.println("msgReceive userNum : "+struserNum);
			
			
			String[] edate = request.getParameter("edata1").split("/");
			
			for(String e : edate){
				System.out.println("푸쉬를 통해 넘어온 param : "+e);
			}
			// push를 통해 방번호, 송신자 ip, 참가자(수신자 사번) 순으로 전송하기에 split으로 각 data를 배열 형식으로 저장
			int keyNum = Integer.parseInt(edate[0]); 
			String reip = edate[1];
			int userNum = Integer.parseInt(edate[2]);
			
			System.out.println("Model에서의 IP : "+reip);
			MessengerVO v = new MessengerVO();
			v.setMesnum(keyNum);
			v.setMesmember(userNum);
			v.setMesreip(reip);
			// 요청자 사번을 받아올수 있음.
			MessengerDao.getDao().joinRoom(v);
			
			ArrayList<MemberVO> memList = MessengerDao.getDao().getList();
			
			StringBuffer ipAdd = new StringBuffer();
			ipAdd.append("ws://");
			ipAdd.append(reip);
			ipAdd.append(":80/sumware/msgSocket/");
			
			
			System.out.println("IP Adress : "+ipAdd);
			request.setAttribute("memList", memList);
			request.setAttribute("userNum", userNum);
			request.setAttribute("key", keyNum);
			request.setAttribute("ipAdd", ipAdd.toString());
			
			// DB 정보 업데이트 : entryTable의 시작일을 수정해줘야함
			
			url = "messenger/msgChat.jsp";
			method = true;
			
			// 참가자가 방을 나간 경우, 방번호와 참여자 사번을 가지고 DB의 종료일자를 수정
		}else if(submod != null && submod.equals("closeChat")){
			System.out.println("여기는 model의 closeRoom 입니다.============");
			
			// msgChat영역에서 넘어온 파라미터 처리
			// 상태 여부 확인 chState : room 과 mesMain으로 구분
			int userNum = Integer.parseInt(request.getParameter("userNum"));
			int roomkey = Integer.parseInt(request.getParameter("roomKey"));			
			String roomstate = request.getParameter("resState");
			System.out.println("Closechat userNum : "+userNum);
			System.out.println("Closechat roomkey : "+roomkey);
			System.out.println("Closechat roomstate : "+roomstate);
			
			MessengerVO v = new MessengerVO();
			v.setMesmember(userNum);
			v.setMesnum(roomkey);
			MessengerDao.getDao().closeRoom(v, roomstate);
				
			
			// messenger Main에서 넘어온 경우
			
			url = "";
			method = true;
			
		// messenger main에서 넘어온 경우 요청 거부 시
		}else if(submod != null && submod.equals("refuseChat")){
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
			
			MessengerVO v = new MessengerVO();
			v.setMesmember(reciuserNum);
			v.setMesnum(keyNum);
			MessengerDao.getDao().closeRoom(v, mainstate);	
			url="sumware?model=messenger&submod=messengerForm";
			method=true;
		}
		
		
		
		
		return new ModelForward(url, method);
	}

}
