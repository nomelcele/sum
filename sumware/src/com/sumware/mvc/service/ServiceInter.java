package com.sumware.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sumware.dto.MailVO;
import com.sumware.dto.MemberVO;
import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;

public interface ServiceInter {
	//메일
	public void setDeleteAttrService(String[] mailnums, HashMap<String,String> map);
	public MailVO getDetailUpdate(int mailnum);
	
	//메신저
	public int insertCreateRoomService(ArrayList<MessengerVO> list, MessengerRoomVO rv, int mesendNum);
	public void closeRoomService(MessengerVO v);
	
	
	//관리자
	public MemberVO addNewMember(MemberVO vo);
	
	//전자결재 관리
	public List<MemberVO> getMgrList(int memnum);
}
