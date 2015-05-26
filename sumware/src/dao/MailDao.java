package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import util.CloseUtil;
import conn.ConUtil;
import dto.MailVO;

public class MailDao {
	private static MailDao dao;
	public static synchronized MailDao getDao(){
		if(dao == null) dao = new MailDao();
		return dao;
	}
	
	public boolean addMail(HashMap<String, String> map){
		// 전송한 메일을 db에 추가해주는 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into mail values(mail_seq.nextVal,?,?,?,?,");
			sql.append("(select meminmail from member where memname=?),sysdate,1,1)");
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, map.get("mailtitle")); 
			pstmt.setString(2, map.get("mailcont"));
			pstmt.setString(3, map.get("attach"));
			pstmt.setInt(4, Integer.parseInt(map.get("mailmem")));
			pstmt.setString(5, map.get("toMem"));
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
			sql.append("select ma.mailnum, me.memname, ma.mailtitle, ma.maildate from member me, mail ma");
			sql.append(" where me.memnum=ma.mailmem and ma.mailreceiver=? and ma.mailrdelete=1");
			sql.append(" order by ma.maildate desc");
			
			// 현재 로그인한 사원에게 온 메일만 검색
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			System.out.println("현재 로그인한 사원 아이디: "+userid);
			System.out.println("받은 메일 읽을 거 있니?"+rs.next());
			
			while(rs.next()){
				MailVO v = new MailVO();
				v.setMailnum(rs.getInt("mailnum"));
				System.out.println("메일 번호: "+v.getMailnum());
				v.setMailsname(rs.getString("memname"));
				System.out.println("보낸 사람: "+v.getMailsname());
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
		// 보낸 메일 리스트를 불러오는 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MailVO> list = new ArrayList<MailVO>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			
			sql.append("select ma.mailnum, me.memname, ma.mailtitle, ma.maildate from member me, mail ma"); 
			sql.append(" where me.meminmail=ma.mailreceiver and ma.mailmem=? order by ma.maildate desc");
		
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, usernum);
			rs = pstmt.executeQuery();
			System.out.println("보낸 메일 읽을 거 있니?"+rs.next());
			
			while(rs.next()){
				MailVO v = new MailVO();
				v.setMailnum(rs.getInt("mailnum"));
				v.setMailrname(rs.getString("memname"));
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
	
	public ArrayList<MailVO> getMyMailList(int usernum, String userid){
		// 내게 쓴 메일 리스트를 불러오는 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MailVO> list = new ArrayList<MailVO>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select mailtitle,maildate from mail");
			sql.append(" where mailnum=? and mailreceiver=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, usernum);
			pstmt.setString(2, userid);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MailVO v = new MailVO();
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
	
	public MailVO getMailDetail(int mailnum){
		// 메일 상세 보기 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MailVO v = new MailVO();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select ma.mailtitle, me1.memname name1, me2.memname name2, ma.maildate, ma.mailcont, ma.mailfile");
			sql.append(" from mail ma, member me1, member me2");
			sql.append(" where me1.memnum=ma.mailmem and me2.meminmail=ma.mailreceiver and ma.mailnum=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, mailnum);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				v.setMailtitle(rs.getString("mailtitle"));
				v.setMailsname(rs.getString("name1"));
				v.setMailrname(rs.getString("name2"));
				v.setMaildate(rs.getString("maildate"));
				v.setMailcont(rs.getString("mailcont"));
				v.setMailfile(rs.getString("mailfile"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
		return v;
	}
	
	public void updateTrash(String[] mailnums, int usernum, String userid){
		// 휴지통에서 보여줄 메일 리스트
		// 받은 메일함이나 보낸 메일함에서 체크박스로 선택 후 삭제된 메일들은 휴지통에서 보여진다.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			int mailmem = 0;
			String mailreceiver = "";
			
			for(String e:mailnums){
				sql.append("select mailmem,mailreceiver from mail where mailnum=?");
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, Integer.parseInt(e)); // 검색할 메일의 번호
				rs = pstmt.executeQuery();
				
				if(rs.next()){ 
					mailmem = rs.getInt("mailmem");
					mailreceiver = rs.getString("mailreceiver");
					
					if(mailmem == usernum){ // 로그인한 사원이 보낸 메일일 경우
						sql.setLength(0); // 스트링버퍼 비우기
						sql.append("update mail set mailsdelete=2 where mailnum=?");
					}
					
					if(mailreceiver.equals(userid)){ // 로그인한 사원이 받은 메일일 경우
						sql.setLength(0); // 스트링버퍼 비우기
						sql.append("update mail set mailrdelete=2 where mailnum=?");
					}
					
					CloseUtil.close(rs);
					CloseUtil.close(pstmt);
					pstmt = con.prepareStatement(sql.toString());
					pstmt.setInt(1, Integer.parseInt(e));
					pstmt.executeUpdate();		
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
	}
	
	public ArrayList<MailVO> getTrashList(int usernum, String userid){
		// 휴지통에서 보여줄 메일 리스트를 리턴하는 메서드
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MailVO> list = new ArrayList<MailVO>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select ma.mailnum, me1.memname mailsname, me2.memname mailrname, ma.mailtitle, ma.maildate");
			sql.append(" from member me1, member me2, mail ma");
			sql.append(" where (me1.memnum=ma.mailmem and me2.meminmail=ma.mailreceiver) and");
			sql.append(" ((ma.mailmem=? and ma.mailsdelete=2) or (ma.mailreceiver=? and ma.mailrdelete=2))");
			sql.append(" order by ma.maildate desc");
 
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, usernum);
			pstmt.setString(2, userid);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MailVO v = new MailVO();
				v.setMailnum(rs.getInt("mailnum"));
				v.setMailsname(rs.getString("mailsname"));
				v.setMailrname(rs.getString("mailrname"));
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
