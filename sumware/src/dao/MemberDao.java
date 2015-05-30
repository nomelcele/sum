package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import util.CloseUtil;
import util.MakeXML;
import util.MyMap;
import conn.ConUtil;
import dto.MemberVO;

public class MemberDao {
	private static MemberDao dao;

	public synchronized static MemberDao getDao() {
		if(dao == null) dao = new MemberDao();
		return dao;
	}
	
	public ArrayList<MemberVO> getNameMailList(){
		// 사원의 이름과 내부 메일 주소를 가져오는 메서드
		// (suggest 기능을 위한 xml 파일 만드는 데 사용)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select memname,meminmail from member");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVO v = new MemberVO();
				v.setMemname(rs.getString("memname"));
				v.setMeminmail(rs.getString("meminmail"));
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
	public int ckid(String meminmail ){
		int result=0;
	   Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuilder sql = new StringBuilder();
		sql.append("select COUNT(*) cnt from member where meminmail=?");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1,meminmail);
			rs=pstmt.executeQuery();
			if(rs.next()){
				result=rs.getInt("cnt");
				System.out.println("result:"+result);
			
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
			
		}
		return result;
	}
	
	public void update(HashMap<String,String> map){
		Connection con=null;
		PreparedStatement pstmt=null;	
		try {
			con=ConUtil.getOds();
			StringBuffer sql=new StringBuffer();
			sql.append("update member set memaddr=?,mempwd=?, memprofile=?,meminmail=? where memnum=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("address"));
			pstmt.setString(2, map.get("mempwd2"));
			pstmt.setString(3, map.get("memimg"));
			pstmt.setString(4, map.get("meminmail"));
            pstmt.setInt(5, Integer.parseInt(map.get("memnum")));
			pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
			
		}
		
		System.out.println("xml 파일 업데이트");
		MakeXML.updateXML(); 
		// 사원의 이름+아이디가 저장된 xml 파일
		// 회원이 추가될 때마다 업데이트
		
	}
	
	/// 회원 정보 수정
	public void modify(HashMap<String,String> map){
		Connection con=null;
		PreparedStatement pstmt=null;	
		try {
			con=ConUtil.getOds();
			StringBuffer sql=new StringBuffer();
			sql.append("update member set memaddr=?,mempwd=?, memprofile=? where memnum=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("address"));
			pstmt.setString(2, map.get("mempwd2"));
			pstmt.setString(3, map.get("memimg"));
            pstmt.setInt(4, Integer.parseInt(map.get("memnum")));
			pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
			
		}	
	}
	
	// 신입 사원 디비에 추가
	public void addMember(HashMap<String,String> map){
		Connection con = null;
		PreparedStatement pstmt=null;	
		try {
			con=ConUtil.getOds();
			StringBuffer sql=new StringBuffer();
			sql.append("insert into member values(member_seq.nextVal, ?, null, ?, null, ?, ?, ?, null,?,?  )");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("newname"));
			pstmt.setString(2, map.get("newpwd"));
			pstmt.setString(3, map.get("newjob"));
			pstmt.setInt(4, Integer.parseInt(map.get("newauth")));
			pstmt.setString(5, map.get("newmail"));
			pstmt.setInt(6,  Integer.parseInt(map.get("newmgr")));
			pstmt.setInt(7,  Integer.parseInt(map.get("newdept")));
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
	}
	
	public ArrayList<MemberVO> getMemMgr(int memdept){
		// 팀장정보들 가져옴
		System.out.println("memdept : "+memdept);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select memnum, memname from member where memauth=4 and memdept=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memdept);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVO v = new MemberVO();
				v.setMemnum(Integer.parseInt(rs.getString("memnum")));
				v.setMemname(rs.getString("memname"));
				System.out.println("----------------------");
				System.out.println("memnum : "+rs.getString("memnum"));
				System.out.println("memname : "+rs.getString("memname"));
				System.out.println("----------------------");
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
