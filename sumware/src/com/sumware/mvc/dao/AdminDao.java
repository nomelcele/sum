package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;

@Repository
public class AdminDao {

	@Autowired
	private SqlSessionTemplate st;
	
	// 관리자 - 새 사원 추가
	public void addMember(MemberVO vo){
		st.insert("admin.addMember",vo);
	}
	
	// 새 사원에 대한 정보 가져옴
	public MemberVO getNewMemInfo(String memmail ){
		
		return st.selectOne("admin.getNewMemInfo",memmail);
		
	}
	
	// 사원 추가에서 선택한 부서에 따라 팀장 목록을 가져옴
	public List<MemberVO> getMemMgr(int memdept){
		return st.selectList("admin.getMemMgr",memdept);
	}
	
}
