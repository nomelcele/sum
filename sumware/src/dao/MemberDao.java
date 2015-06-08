package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLPermission;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import service.FactorySrevice;
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
		// �궗�썝�쓽 �씠由꾧낵 �궡遺� 硫붿씪 二쇱냼瑜� 媛��졇�삤�뒗 硫붿꽌�뱶
		// (suggest 湲곕뒫�쓣 �쐞�븳 xml �뙆�씪 留뚮뱶�뒗 �뜲 �궗�슜)
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
		
		SqlSession ss= FactorySrevice.getFactory().openSession(true);
		ss.update("mem.update",map);
				ss.close();
		//uSystem.out.println("xml �뙆�씪 �뾽�뜲�씠�듃");
		MakeXML.updateXML(); 
		// �궗�썝�쓽 �씠由�+�븘�씠�뵒媛� ���옣�맂 xml �뙆�씪
		// �쉶�썝�씠 異붽��맆 �븣留덈떎 �뾽�뜲�씠�듃
		
	}
	
	/// �쉶�썝 �젙蹂� �닔�젙
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
	
	// �떊�엯 �궗�썝 �뵒鍮꾩뿉 異붽�
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
		// ���옣�젙蹂대뱾 媛��졇�샂
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
	
	// �떊�엯�궗�썝 �젙蹂� 戮묒븘�샂
	public MemberVO getNewMemInfo(String memmail ){
		int result=0;
	   Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuilder sql = new StringBuilder();
		MemberVO v = new MemberVO();
		sql.append("select s.memnum,s.memname, d.dename, s.mempwd, m.memname mgrname, s.memmail from member s, dept d, member m where s.memmgr = m.memnum and s.memdept= d.denum and s.memmail=?");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1,memmail);
			rs=pstmt.executeQuery();
			while(rs.next()){
				v.setMemnum(rs.getInt(1));
				v.setMemname(rs.getString(2));
				v.setDename(rs.getString(3));
				v.setMempwd(rs.getString(4));
				v.setMgrname(rs.getString(5));
				v.setMemmail(rs.getString(6));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
			
		}
	return v;
	}
}
