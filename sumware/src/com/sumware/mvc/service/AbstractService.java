package com.sumware.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sumware.dto.MailVO;
import com.sumware.dto.MemberVO;
import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;
import com.sumware.dto.PayVO;
import com.sumware.dto.SignatureVO;

public class AbstractService implements ServiceInter{
	//상속받아서 필요한것만 오버라이드 해서 쓰시오~!
	@Override
	public void setDeleteAttrService(String[] mailnums,
			HashMap<String, String> map) {
	}

	@Override
	public int insertCreateRoomService(ArrayList<MessengerVO> list,
			MessengerRoomVO rv, int mesendNum) {
		return 0;
	}

	@Override
	public void closeRoomService(MessengerVO v) {
	}


	@Override
	public void addNewMember(MemberVO vo, PayVO payvo) throws Exception {
	}

	@Override
	public MailVO getDetailUpdate(int mailnum) {
		return null;
	}

	@Override
	public List<MemberVO> getMgrList(int memnum) {
		return null;
	}

	@Override
	public String[] getMgrNames(String[] memnum) {
		return null;
	}

	@Override
	public void insertSignService(SignatureVO sgvo,
			List<HashMap<String, String>> mgrList) {
		
	}

	@Override
	public void setNowmemService(int snum) {
	}
	@Override
	public void changeJobSalary(MemberVO mvo,int[] juniors) {
		
	}

	@Override
	public String confNotify(int confmem) {
		return null;
	}

	@Override
	public void changeDeptMgr(MemberVO mvo,int[] juniors) {
	}
	
	

}
