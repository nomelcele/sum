package com.sumware.mvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;
import com.sumware.mvc.dao.MessengerDao;

import conn.ConUtil;
@Transactional
@Service
@Qualifier(value="messenger")
public class MessengerServiceImple extends AbstractService{
	@Autowired
	private MessengerDao mdao;
	
	@Override
	public int insertCreateRoomService(List<MessengerVO> list,
		MessengerRoomVO mrvo, int mesendNum) {
		int key = 0;
		System.out.println(list.size());
			
			StringBuffer sql = new StringBuffer();
			// 방번호 얻기
			key= mdao.getNewRoomNum();
			
			System.out.println("key : "+key);
			mrvo.setKey(key);
			// 얻은 방번호로 mastertable에 정보 저장, 방번호, 사용자 ip
			mdao.insertRoomInfo(mrvo);
			
			// 참여자 정보 Table에 정보 저장
			
			String openCk= null; // 방장 여부 초기화			
			for(MessengerVO e : list){
				openCk = e.getOpenmemberyn();
				e.setMesendnum(mesendNum);
				e.setKey(key);
				System.out.println("방장여부 : "+openCk);
				if(openCk.equals("Y")){ // 방장인 경우 시작일만 지정
					
					// 방번호, 참여자 번호, 방장 여부, 사용자 ip 저장
					mdao.insertRoomForTeamMgr(e);				
					
				}else{ 
					// 참여자인 경우 시작, 종료일은 null값을 db에 저장
					// master table에서 해당 방번호의 ip 주소를 얻어 옴
					// 방장은 1명

					e.setHostip(mdao.getHostIp(e));
					
					mdao.insertRoomForMem(e);
				}
			}
			
		return key;
	}
	
	

	@Override
	public void closeRoomService(MessengerVO mevo) {
		System.out.println("CloseRoom Service 영역입니다.");
		
		// 채팅창에서 넘어온 data : 종료일만 변경
		mdao.updateRoomDate(mevo);

			// 방 종료 설정을 진행
			List<MessengerRoomVO> rlist = mdao.getMesNums();
			
				
			System.out.println(rlist.size());			
		
			for(MessengerRoomVO e : rlist){
				mdao.upMemMaster(e);
				
				mdao.upMesEntry(e);
			}
	}	
}
