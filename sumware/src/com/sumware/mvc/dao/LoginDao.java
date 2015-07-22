package com.sumware.mvc.dao;

import java.sql.SQLException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;
@Repository
public class LoginDao {
	@Autowired
	private SqlSessionTemplate st;

	// 로그인 시 사용하는 메서드
	public MemberVO login(int memnum) throws SQLException{
		return st.selectOne("login.login", memnum);
	}
	
	public String ckFirstLogin(int memnum){
		String res="";
		res = st.selectOne("login.ckFirstLogin",memnum);
		if(!res.equals("1")){
			res=String.valueOf(memnum);
		}
		return res;
	}
	public String firstPwd(int memnum){
		return st.selectOne("login.firstPwd",memnum);
	}
	public void inLog(int memnum) {
		st.insert("login.inLog",memnum);
		
	}
	public void outLog(int memnum){
		st.update("login.outLog", memnum);
	}
	
	// 비밀번호 찾기
	public MemberVO findPW(MemberVO mvo){
		return st.selectOne("login.findPW", mvo);
	}
	
	// 비밀번호 변경
	public void changePW(MemberVO mvo){
		st.update("login.changePW", mvo);
	}
}
