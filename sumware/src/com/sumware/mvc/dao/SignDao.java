package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;
import com.sumware.dto.SignFormVO;
import com.sumware.dto.SignatureVO;

@Repository
public class SignDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public List<SignatureVO> getSignList(SignatureVO sgvo){
		return st.selectList("sign.getSgList",sgvo);
	}
	
	//등록된 폼 목록 불러오기
	public List<SignFormVO> getSfList(){
		return st.selectList("sign.getSfList");
	}
	//상급자 불러오기
	public MemberVO getMgr(int memnum){
		return st.selectOne("sign.getMgr", memnum);
	}
	//선택된 폼 불러오기
	public SignFormVO getSf(int sfnum){
		return st.selectOne("sign.getSf", sfnum);
	}
	
	
}
