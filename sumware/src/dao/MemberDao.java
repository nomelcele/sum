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
}
