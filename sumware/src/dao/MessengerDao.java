package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import util.CloseUtil;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

import conn.ConUtil;
import dto.MemberVO;
import dto.MessengerVO;

public class MessengerDao {
	private static MessengerDao dao;

	public static MessengerDao getDao() {
		if(dao == null) dao = new MessengerDao();
		return dao;
	}
	
	public int insertCreateRoom(ArrayList<MessengerVO> list){
		Connection con = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int key = 0;	
		
		System.out.println(list.size());
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			// 방번호 얻기
			sql.append("select mesmaster_seq.nextval from dual");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
			MessengerVO v = new MessengerVO();
			v.setMasnum(rs.getInt("nextval"));
			key = rs.getInt("NEXTVAL");			
			}
			System.out.println("key : "+key);
			
			// StrinBuffer 초기화
			sql.setLength(0);

			// 얻은 방번호로 mastertable에 정보 저장
			sql.append("insert into mesmaster values(?,sysdate,NULL)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, key) ;			
			pstmt.executeUpdate();
			
			sql.setLength(0);
			
			// 참여자 정보 Table에 정보 저장
			
			String openCk= null; // 참여자 사번 초기화
			
			
			for(MessengerVO e : list){
				openCk = e.getOpenmemberyn();
				System.out.println("방장여부 : "+openCk);
				if(openCk.equals("Y")){ // 방장인 경우 시작일만 지정
					sql.append("insert into mesentry values(?,?,?,sysdate,null)");						
					pstmt= con.prepareStatement(sql.toString());
					
					pstmt.setInt(1, key);
					pstmt.setInt(2, e.getMesmember());
					pstmt.setString(3, e.getOpenmemberyn());
					pstmt.executeUpdate();
					
				}else{ // 참여자인 경우 시작, 종료일은 null값을 db에 저장
					sql.append("insert into mesentry values(?,?,?,null,null)");
					pstmt= con.prepareStatement(sql.toString());
					
					pstmt.setInt(1, key);
					pstmt.setInt(2, e.getMesmember());
					pstmt.setString(3, e.getOpenmemberyn());
					pstmt.executeUpdate();
				}
				sql.setLength(0);
			}
			sql.setLength(0);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
				if(rs != null) CloseUtil.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return key;
		
	}
	
	public ArrayList<MessengerVO> getentList(int userNum){
		System.out.println("Messenger getentList 영역입니다.");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
		StringBuffer sql = new StringBuffer();
		// 참가자 사번, 시작일이 null인 사원만 리스트로 출력
		sql.append("select masnum, mesmember, openmemberyn, entstdate from mesentry where mesmember=? and openmemberyn='N' and entstdate is null");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MessengerVO v = new MessengerVO();
				v.setMasnum(rs.getInt("masnum"));
				v.setMesmember(rs.getInt("mesmember"));
				v.setOpenmemberyn(rs.getString("openmemberyn"));
				v.setEntstdate(rs.getString("entstdate"));
				System.out.println("시작일 : "+v.getEntstdate());
				list.add(v);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
				if(rs != null) CloseUtil.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}return list;
	}
	
	public void joinRoom(MessengerVO v){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append("update mesentry set entstdate = sysdate where masnum=? and mesmember=? and openmemberyn='N'");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setInt(1, v.getMasnum());
			
			pstmt.setInt(2, v.getMesmember());
			
			System.out.println("joinroom의 방번호 : "+v.getMasnum());
			System.out.println("joinRoom의 유저 번호 : "+v.getMesmember());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
	}
	
	
	public ArrayList<MemberVO> getList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		StringBuffer sql = new StringBuffer();
		sql.append("select m.memnum, m.memname, m.memaddr, m.memprofile, m.meminmail, d.dename from member m,");
		sql.append(" dept d where m.memdept=d.denum order by d.dename,m.memname");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberVO v = new MemberVO();
				v.setMemnum(rs.getInt("memnum"));
				v.setMemname(rs.getString("memname"));
				v.setMemaddr(rs.getString("memaddr"));
				v.setMemprofile(rs.getString("memprofile"));
				v.setMemmail(rs.getString("meminmail"));
				v.setDename(rs.getString("dename"));
				list.add(v);
				System.out.println("Dao 사원 이름 : "+v.getMemname());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
				if(rs != null) CloseUtil.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} return list;
	} 

}
