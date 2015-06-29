package com.sumware.mvc.service;

import java.util.ArrayList;
import java.util.Map;

import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;

public class AbstractService implements ServiceInter{
	//상속받아서 필요한것만 오버라이드 해서 쓰시오~!
	@Override
	public void setDeleteAttrService(String[] mailnums,
			Map<String, String> map) {
	}

	@Override
	public int insertCreateRoomService(ArrayList<MessengerVO> list,
			MessengerRoomVO rv, int mesendNum) {
		return 0;
	}

	@Override
	public void closeRoomService(MessengerVO v) {
	}

}
