package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.CloseUtil;
import conn.ConUtil;
import dto.MailVO;

public class MailDao {
	private static MailDao dao;
	public static synchronized MailDao getDao(){
		if(dao == null) dao = new MailDao();
		return dao;
	}
	
	public boolean addMail(MailVO vo){
		// 전송한 메일을 db에 추가해주는 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into mail values(mail_seq.nextVal,?,?,?,?,?,sysdate)");
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, vo.getMailtitle());
			pstmt.setString(2, vo.getMailcont());
			pstmt.setString(3, vo.getMailfile());
			pstmt.setInt(4, vo.getMailmem());
			pstmt.setString(5, vo.getMailreceiver());
			pstmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
	
	public ArrayList<MailVO> getFromMailList(String userid){
		// 받은 메일 리스트를 불러오는 메서드
		// 현재 로그인되어 있는 사원이 받은 메일만 불러와야 한다.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MailVO> list = new ArrayList<MailVO>();
		System.out.println(userid);
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select mailmem,mailtitle,maildate from mail");
			sql.append(" where mailreceiver=? order by maildate desc");
			
			// 현재 로그인한 사원에게 온 메일만 검색
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MailVO v = new MailVO();
				v.setMailmem(rs.getInt("mailmem"));
				v.setMailtitle(rs.getString("mailtitle"));
				v.setMaildate(rs.getString("maildate"));
				list.add(v);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
		return list;
	}
	
	public ArrayList<MailVO> getToMailList(int usernum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MailVO> list = new ArrayList<MailVO>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select mailreceiver,mailtitle,maildate from mail");
			sql.append(" where mailmem=? order by maildate desc");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, usernum);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MailVO v = new MailVO();
				v.setMailreceiver(rs.getString("mailreceiver"));
				v.setMailtitle(rs.getString("mailtitle"));
				v.setMaildate(rs.getString("maildate"));
				list.add(v);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
		return list;
	}

}
