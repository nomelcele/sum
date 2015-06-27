package com.sumware.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;
import com.sumware.util.CloseUtil;

import conn.ConUtil;
@Repository
public class LoginDao {
	@Autowired
	private SqlSessionTemplate st;

	// 로그인 시 사용하는 메서드
	public MemberVO login(MemberVO mvo) throws SQLException{
		return st.selectOne("login.login", mvo);
	}
	
	public String ckFirstLogin(MemberVO mvo){
		return st.selectOne("login.ckFirstLogin",mvo);
	}
	public void inLog(int memnum) {
		st.insert("login.inLog",memnum);
		
	}
	public void outLog(int memnum){
		st.update("login.outLog", memnum);
	}
}
