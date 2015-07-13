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
import com.sumware.dto.PayVO;
import com.sumware.dto.SignatureVO;

public interface ServiceInter {
	//메일
	public void setDeleteAttrService(String[] mailnums, HashMap<String,String> map);
	public MailVO getDetailUpdate(int mailnum);
	
	//메신저
	public int insertCreateRoomService(ArrayList<MessengerVO> list, MessengerRoomVO rv, int mesendNum);
	public void closeRoomService(MessengerVO v);
	
	
	//관리자
	public void addNewMember(MemberVO vo, PayVO payvo) throws Exception ;
	public void changeJobSalary(MemberVO mvo);
	
	//전자결재 관리
	//상급자 리스트 불러오기
	public List<MemberVO> getMgrList(int memnum);
	//상급자 이름 불러오기
	public String[] getMgrNames(String[] memnum);
	//결재문서 등록하기
	public void insertSignService(SignatureVO sgvo,List<HashMap<String, String>> mgrList);
	//현재 결재자 업데이트
	public void setNowmemService(int snum);
}
