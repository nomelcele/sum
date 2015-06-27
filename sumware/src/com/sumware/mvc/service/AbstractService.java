package com.sumware.mvc.service;

import java.util.HashMap;
import java.util.List;

import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;

public class AbstractService implements ServiceInter{
	//상속받아서 필요한것만 오버라이드 해서 쓰시오~!
	@Override
	public void setDeleteAttrService(String[] mailnums,
			HashMap<String, String> map) {
	}

	@Override
	public int insertCreateRoomService(List<MessengerVO> list,
			MessengerRoomVO rv, int mesendNum) {
		return 0;
	}

	@Override
	public void closeRoomService(MessengerVO v) {
	}

	@Override
	public List<MessengerVO> messengerChatService() {
		return null;
	}

}
