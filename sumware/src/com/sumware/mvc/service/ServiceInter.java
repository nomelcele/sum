package com.sumware.mvc.service;

import java.util.HashMap;
import java.util.List;

import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;

public interface ServiceInter {
	//메일
	public void setDeleteAttrService(String[] mailnums, HashMap<String, String> map);
	
	//메신저
	public int insertCreateRoomService(List<MessengerVO> list, MessengerRoomVO rv, int mesendNum);
	public void closeRoomService(MessengerVO v);
	//메신저 초기방생성
	public List<MessengerVO> messengerChatService();
	
}
