package com.sumware.mvc.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.BnameVO;
import com.sumware.dto.MemberVO;

@Repository
public class AdminDao {

	@Autowired
	private SqlSessionTemplate st;
	
	// 관리자 로그인
	public MemberVO adminLogin(MemberVO mvo){
		return st.selectOne("admin.adminLogin", mvo);
	}

	// 관리자 - 새 사원 추가
	public void addMember(MemberVO vo){
		st.insert("admin.addMember",vo);
	}
	
	// 새 사원에 대한 정보 가져옴
	public MemberVO getNewMemInfo(MemberVO mvo){
		
		return st.selectOne("admin.getNewMemInfo",mvo);
		
	}
	
	// 사원 추가에서 선택한 부서에 따라 팀장 목록을 가져옴
	public List<MemberVO> getMemMgr(int memdept){
		return st.selectList("admin.getMemMgr",memdept);
	}
	
	// 이메일 발송 실패 시 디비에 저장했던 내용 다시삭제
	public void cancelAddMem(int memnum){
		st.delete("admin.cancelAddMem", memnum);
	}
	
	// 게시판 추가 하는 메서드
	public void addBoard(BnameVO bnvo){
		st.insert("admin.addBoard",bnvo);
	}
	
}
