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
			sql.append("insert into mesmaster values(?,sysdate,sysdate)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, key);			
			pstmt.executeUpdate();
			
			sql.setLength(0);
			
			// 참여자 정보 Table에 정보 저장
			sql.append("insert into mesentry values(?,?,?,sysdate,sysdate)");			
			pstmt= con.prepareStatement(sql.toString());			
			for(MessengerVO e : list){
				pstmt.setInt(1, key);
				pstmt.setInt(2, e.getMesmember());
				pstmt.setString(3, e.getOpenmemberyn());
				pstmt.executeUpdate();
			}
			
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
	
	public ArrayList<MessengerVO> getentList(){
		System.out.println("Messenger getentList 영역입니다.");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
		StringBuffer sql = new StringBuffer();
		sql.append("select masnum, mesmember, openmemberyn,entstdate,entendate from mesentry");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()){
				MessengerVO v = new MessengerVO();
				v.setMasnum(rs.getInt("masnum"));
				v.setMesmember(rs.getInt("mesmember"));
				v.setOpenmemberyn(rs.getString("openmemberyn"));
				v.setEntstdate(rs.getString("entstdate"));
				v.setEntendate(rs.getString("entendate"));
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
