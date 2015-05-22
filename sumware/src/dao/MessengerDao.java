package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.CloseUtil;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

import conn.ConUtil;
import dto.MemberVO;

public class MessengerDao {
	private static MessengerDao dao;

	public static MessengerDao getDao() {
		if(dao == null) dao = new MessengerDao();
		return dao;
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
			CloseUtil cl = null;
			try {
				if(con != null) cl.close(con);
				if(pstmt != null) cl.close(pstmt);
				if(rs != null)cl.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} return list;
	} 

}
