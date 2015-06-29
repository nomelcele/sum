package com.sumware.mvc.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;

public interface ServiceInter {
	//메일
	public void setDeleteAttrService(String[] mailnums, Map<String, String> map);
	
	//메신저
	public int insertCreateRoomService(ArrayList<MessengerVO> list, MessengerRoomVO rv, int mesendNum);
	public void closeRoomService(MessengerVO v);
	
}
