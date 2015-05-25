package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import conn.ConUtil;
import util.CloseUtil;
import dto.SnsVO;

public class SnsDao {
	private static SnsDao dao;

	public static synchronized SnsDao getDao() {
		if(dao==null){
			dao = new SnsDao();
		}
		return dao;
	}
	//sns 입력
	public void insertSns(HashMap<String,String> map){
		Connection con=null;
		PreparedStatement pstmt=null;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into sns(snum,scont,sdate,sdept,smem)");
		sql.append(" values(sns_seq.nextVal,?,sysdate,?,?)");
		try{
			con=ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("scont"));
			pstmt.setInt(2, Integer.parseInt(map.get("sdept")));
			pstmt.setInt(3, Integer.parseInt(map.get("smem")));
			pstmt.executeQuery();
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
	//sns 가져오기
	public ArrayList<SnsVO> getList(Map<String,Integer> map){
		ArrayList<SnsVO> snsList= null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sql = new StringBuffer();
		sql.append("select rownum srnum ,s.snum,s.scont,to_char(s.sdate,'MM')||'월'||to_char(s.sdate,'dd')||'일'||to_char(s.sdate,'hh:mm') sdate,s.sdept,s.smem");
		sql.append(" from (select * from sns where sdept=? order by 1 desc) s");
		sql.append(" where rownum between ? and ?");
		try {
			snsList=new ArrayList<>();
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, map.get("sdept"));
			pstmt.setInt(2, map.get("begin"));
			pstmt.setInt(3, map.get("end"));
			rs = pstmt.executeQuery();
			while(rs.next()){
				SnsVO v = new SnsVO();
				v.setSrnum(rs.getInt("srnum"));
				v.setSnum(rs.getInt("snum"));
				v.setScont(rs.getString("scont"));
				v.setSdate(rs.getString("sdate"));
				v.setSdept(rs.getInt("sdept"));
				v.setSmem(rs.getInt("smem"));
				snsList.add(v);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return snsList;
	}
	public int snsTotalCount(int sdept){
		int result= 0;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt from sns where sdept=?");
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, sdept);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result =rs.getInt("cnt");
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
	
}
