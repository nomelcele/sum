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
			   sql.append("select s.memnum, s.memprofile, s.memname, s.memjob,s.memdept,s.memmgr , d.dename, nvl(s.memmgr,0) mgrname, s.memauth,s.meminmail ");
			   sql.append("from member s, dept d where s.memdept=d.denum and s.memnum = ? and s.mempwd =?");
			   con = ConUtil.getOds();
			
			   pstmt = con.prepareStatement(sql.toString());
		   }else{
			   System.out.println("상급자 있음");
			   sql.append("select s.memnum, s.memprofile, s.memname, s.memjob,s.memdept,s.memmgr, d.dename, m.memname mgrname, s.memauth,s.meminmail ");
			   sql.append("from member s, member m, dept d where s.memmgr = m.memnum and s.memdept = d.denum and s.memnum = ? and s.mempwd =?");
			   con = ConUtil.getOds();
			
			   pstmt = con.prepareStatement(sql.toString());
		   }


		   pstmt.setInt(1, v.getMemnum());
		   pstmt.setString(2, v.getMempwd());
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
		   }else{
			   return null;
		   }
		   CloseUtil.close(rs);
		   CloseUtil.close(pstmt);
		   CloseUtil.close(con);
		  return vo;
	}
}
