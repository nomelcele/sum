package com.sumware.mvc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MailVO;

@Repository
public class MailDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public void addMail(HashMap<String, String> map){
		st.insert("mail.addMail", map);
		
	}
	
	public List<MailVO> getFromMailList(HashMap<String, String> map){
		// 받은 메일 리스트를 불러오는 메서드
		// 현재 로그인되어 있는 사원이 받은 메일만 불러와야 한다.
		return st.selectList("mail.getFromMailList", map);
			
	}
	
	public List<MailVO> getToMailList(HashMap<String, String> map){
		// 보낸 메일 리스트를 불러오는 메서드
		return st.selectList("mail.getToMailList", map);
			
	}
	
	public List<MailVO> getMyMailList(HashMap<String, String> map){
		// 내게 쓴 메일 리스트를 불러오는 메서드
		return st.selectList("mail.getMyMailList", map);

	}
	
	public MailVO getMailDetail(int mailnum){
		// 메일 상세 보기 정보를 불러오는 메서드
		return st.selectOne("mail.getMailDetail", mailnum);

	}
	
	public void setMailRead(int mailnum){
		System.out.println("mailread 속성 업데이트");
		st.update("mail.setMailRead", mailnum);
	}
	
	public MailVO getDelAttrMailInfo(String num){
		return st.selectOne("mail.getDelAttrMailInfo", num); // 오류
	}
	
	public void setDelAttrFrom(HashMap<String,String> map){
		st.update("mail.setDelAttrFrom", map);
	}
	
	public void setDelAttrTo(HashMap<String,String> map){
		st.update("mail.setDelAttrTo", map);
	}
	
	public List<MailVO> getTrashList(HashMap<String, String> map){
		// 휴지통에서 보여줄 메일 리스트를 리턴하는 메서드
		return st.selectList("mail.getTrashList", map);
	

	}
	
	public int[] getListNum(HashMap<String, String> map){
		// 각 메일함에 있는 메일의 갯수를 얻기 위한 메서드
		MailVO mavo = st.selectOne("mail.getListNum",map);
		
//		System.out.println("받은 메일함 메일 갯수: "+mavo.getFromnum());
//		System.out.println("보낸 메일함 메일 갯수: "+mavo.getTonum());
		int[] numArr = new int[4];
		numArr[0] = mavo.getFromnum();
		numArr[1] = mavo.getTonum();
		numArr[2] = mavo.getMynum();
		numArr[3] = mavo.getTrashnum();
		
		return numArr;
	}
	
	
}
