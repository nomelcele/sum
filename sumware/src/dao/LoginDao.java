package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.CloseUtil;
import conn.ConUtil;
import dto.MemberVO;

public class LoginDao {
	private static LoginDao dao;

	public synchronized static LoginDao getDao() {
		if (dao == null)
			dao = new LoginDao();
		return dao;
	}

	// 로그인 시 사용하는 메서드
	public MemberVO login(MemberVO v) throws SQLException{
		   MemberVO vo = new MemberVO();
		   StringBuffer sql = new StringBuffer();
		   Connection con = null;
		   PreparedStatement pstmt = null;
		   if(v.getMemnum() == 10000){
			   System.out.println("상급자 없음");
			   sql.append("select s.memnum, s.mempwd, s.memprofile, s.memname, s.memjob,s.memdept,s.memmgr , d.dename, nvl(s.memmgr,0) mgrname, s.memauth,s.meminmail ");
			   sql.append("from member s, dept d where s.memdept=d.denum and s.memnum = ? and s.mempwd =?");
			   con = ConUtil.getOds();
			
			   pstmt = con.prepareStatement(sql.toString());
		   }else{
			   System.out.println("상급자 있음");
			   sql.append("select s.memnum, s.mempwd, s.memprofile, s.memname, s.memjob,s.memdept,s.memmgr, d.dename, m.memname mgrname, s.memauth,s.meminmail ");
			   sql.append("from member s, member m, dept d where s.memmgr = m.memnum and s.memdept = d.denum and s.memnum = ? and s.mempwd =?");
			   // 부서 번호와 상급자 번호가 있어야 한다.
			   // 부서 번호: 900, 상급자 번호: 1 (default)
			   con = ConUtil.getOds();
			
			   pstmt = con.prepareStatement(sql.toString());
		   }


		   pstmt.setInt(1, v.getMemnum());
		   System.out.println("로그인한 사원 번호: "+v.getMemnum());
		   pstmt.setString(2, v.getMempwd());
		   System.out.println("로그인한 사원 비번: "+v.getMempwd());
		   ResultSet rs = pstmt.executeQuery();
		   
		   if(rs.next()){
			   vo.setMemnum(rs.getInt("memnum"));
			   vo.setMemprofile(rs.getString("memprofile"));
			   vo.setMemname(rs.getString("memname"));
			   vo.setMemjob(rs.getString("memjob"));
			   vo.setDename(rs.getString("dename"));
			   vo.setMgrname(rs.getString("mgrname"));
			   vo.setMemauth(rs.getInt("memauth"));
			   vo.setMeminmail(rs.getString("meminmail"));
			   vo.setMemdept(rs.getInt("memdept"));
			   vo.setMemmgr(rs.getInt("memmgr"));
			   vo.setMempwd(rs.getString("mempwd"));
		   }else{
			   return null;
		   }
		   CloseUtil.close(rs);
		   CloseUtil.close(pstmt);
		   CloseUtil.close(con);
		  return vo;
	}
	
	public String ckFirstLogin(int memnum){
		String res=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		StringBuffer sql = new StringBuffer();
		sql.append("select nvl(memprofile,'0') memprofile from member where memnum=?");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, memnum);
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
