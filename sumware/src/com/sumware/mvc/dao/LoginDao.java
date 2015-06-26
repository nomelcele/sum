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
	
	public String ckFirstLogin(int memnum,String mempwd){
		String res="0";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		StringBuffer sql = new StringBuffer();
		sql.append("select nvl(memprofile,'1') memprofile from member where memnum=? and mempwd=?");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memnum);
			pstmt.setString(2, mempwd);
			rs=pstmt.executeQuery();
			if(rs.next()){
				res=rs.getString("memprofile");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return res;
	}
	public void inLog(int memnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into login(lonum,locheck,lostdate,lomem) values(login_seq.nextVal,'t',sysdate,?)");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memnum);
			pstmt.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
	}
	public void outLog(int memnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append("update login set locheck='f',loendate=sysdate where lomem=?");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memnum);
			pstmt.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
}
