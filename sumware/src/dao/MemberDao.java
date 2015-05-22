package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.CloseUtil;
import conn.ConUtil;
import dto.MemberVO;

public class MemberDao {
	private static MemberDao dao;

	public synchronized static MemberDao getDao() {
		if(dao == null) dao = new MemberDao();
		return dao;
	}
	
	public ArrayList<String> getInmailList(){
		// db에서 아이디(사내메일주소) 읽어오는 부분(xml 파일 만들기 위해서)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> list = new ArrayList<String>();
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select meminmail from member");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				list.add(rs.getString("meminmail"));
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
