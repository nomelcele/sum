package com.sumware.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;
import com.sumware.dto.SignFormVO;
import com.sumware.dto.SignStepVO;
import com.sumware.dto.SignatureVO;

@Repository
public class SignDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<SignatureVO> getSignList(Map<String,Integer> map){
		return st.selectList("sign.getSgList",map);
	}
	
	//등록된 폼 목록 불러오기
	public List<SignFormVO> getSfList(){
		return st.selectList("sign.getSfList");
	}
	//상급자 불러오기
	public MemberVO getMgr(int memnum){
		return st.selectOne("sign.getMgr", memnum);
	}
	//memnum 을 통해 이름 불러오기
	public String getMgrName(int memnum){
		return st.selectOne("sign.getMgrName", memnum);
	}
	//선택된 폼 불러오기
	public SignFormVO getSf(int sfnum){
		return st.selectOne("sign.getSf", sfnum);
	}
	//문서 작성하기
	//signature->방금 등록한 글넘버 얻기(필요하면 리팩토링)->signstep 등록
	public void writeSf(SignatureVO sgvo){
		st.insert("sign.writeSf", sgvo);
	}
	public int getMax(){
		return st.selectOne("sign.getMax");
	}
	public void writeSignStep(Map<String, String> map){
		st.insert("sign.writeSignStep", map);
	}
	//상세보기
	public SignatureVO signDetail(int snum){
		return st.selectOne("sign.signDetail", snum);
	}
	public List<SignStepVO> getSignStep(int stepsnum){
		return st.selectList("sign.getSignStep", stepsnum);
	}
	//결제하기
	public void updateSignStep(Map<String,String> map){
		st.update("sign.updateSignStep", map);
	}
	public int getNowmem(int stepsnum){
		return st.selectOne("sign.getNowmem", stepsnum);
	}
	public void setNowmem(Map<String,Integer> map){
		st.update("sign.setNowmem", map);
	}
	//반려하기
	public void signReturn(Map<String,String> map){
		st.update("sign.signReturn",map);
	}
	
	
}
