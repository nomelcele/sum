package com.sumware.mvc.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;
import com.sumware.util.CloseUtil;

import conn.ConUtil;
@Transactional
@Service
public class MessengerServiceImple extends AbstractService{

	@Override
	public int insertCreateRoomService(List<MessengerVO> list,
			MessengerRoomVO rv, int mesendNum) {
		int key = 0;
		System.out.println(list.size());
			StringBuffer sql = new StringBuffer();
			// 방번호 얻기
			key=sql.append("select mesmaster_seq.nextval from dual");
			
			System.out.println("key : "+key);
			rv.setKey(key);
			// 얻은 방번호로 mastertable에 정보 저장, 방번호, 사용자 ip
			sql.append("insert into mesmaster values(?,sysdate,'9999/12/31',?)");
			
			// 참여자 정보 Table에 정보 저장
			
			String openCk= null; // 방장 여부 초기화			
			for(MessengerVO e : list){
				openCk = e.getOpenmemberyn();
				e.setMesendnum(mesendNum);
				e.setKey(key);
				System.out.println("방장여부 : "+openCk);
				if(openCk.equals("Y")){ // 방장인 경우 시작일만 지정
					
					// 방번호, 참여자 번호, 방장 여부, 사용자 ip 저장
					sql.append("insert into mesentry values(?,?,?,sysdate,'9999/12/31',?,?)");						
					
				}else{ 
					// 참여자인 경우 시작, 종료일은 null값을 db에 저장
					// master table에서 해당 방번호의 ip 주소를 얻어 옴
					// 방장은 1명
					String hostIp = null;
					hostIp=sql.append("select masreip from mesmaster where masnum=?");
					
					sql.append("insert into mesentry values(?,?,?,null,null,?,?)");
				}
			}
			
		return key;
	}

	@Override
	public void closeRoomService(MessengerVO v) {
		System.out.println("CloseRoom Service 영역입니다.");
		
		//주상이형 이부분은 다이나믹 쿼리로 해보는것이 나을듯해요.
		
		// 채팅창에서 넘어온 data : 종료일만 변경
		if(v.getResState().equals("room")){
			sql.append("update mesentry set entendate = sysdate where mesnum=? and mesmember=?");			
			System.out.println("room의 if문");
			
		// messenger main에서 넘어온 data, 시작과 종료일을 변경
		}else if(v.getResState().equals("mesMain")){
			sql.append("update mesentry set entstdate = sysdate, entendate = sysdate where mesnum=? and mesmember=?");
			System.out.println("mesMain의 if문");
			
		}else{
			System.out.println("이게 출력되면 망한거임!!");
		}
		
//			System.out.println("Dao의 방번호 : "+v.getMesnum());
//			System.out.println("Dao의 사용자 번호 : "+v.getMesmember());
			
			
			// 방 종료 설정을 진행
			ArrayList<MessengerRoomVO> rlist = new ArrayList<MessengerRoomVO>();
			MessengerRoomVO vr= sql.append("select DISTINCT mesnum from mesentry where entendate is null or entendate != '9999/12/31'");
			rlist.add(vr);
				
			System.out.println(rlist.size());			
		
			for(MessengerRoomVO e : rlist){
				sql.append("update mesmaster set masendate = sysdate where masnum = ?");
				
				pstmt.setInt(1, e.getMasnum());
				
//				System.out.println("master table 종료 된 방번호 : "+e.getMasnum());
				
				sql.append("update mesentry set entstdate = sysdate, entendate = sysdate where mesnum=?");
				pstmt.setInt(1, e.getMasnum());
//				System.out.println("mesentry에서 종료 된 방번호 : "+e.getMasnum());
			}
	}	
}
