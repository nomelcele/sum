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
import dto.CommVO;
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
		sql.append("select rownum srnum,m.memname,m.memprofile ,s.snum,s.scont,to_char(s.sdate,'MM')||'월'||to_char(s.sdate,'dd')||'일'||to_char(s.sdate,'hh:mm') sdate,s.sdept,s.smem");
		sql.append(" from (select * from sns s where s.sdept=? order by 1 desc) s,member m");
		sql.append(" where m.memnum=s.smem and rownum between ? and ?");
		try {
			snsList=new ArrayList<>();
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			System.out.println("~~~~~~~~~"+map.get("sdept"));
			System.out.println("~~~~~~~~~"+map.get("begin"));
			System.out.println("~~~~~~~~~"+map.get("end"));
			pstmt.setInt(1, map.get("sdept"));
			pstmt.setInt(2, map.get("begin"));
			pstmt.setInt(3, map.get("end"));
			rs = pstmt.executeQuery();
			while(rs.next()){
				SnsVO v = new SnsVO();
				v.setSrnum(rs.getInt("srnum"));
				v.setSmemname(rs.getString("memname"));
				v.setSmemprofile(rs.getString("memprofile"));
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
	public int snsCommTotalCount(int commsns){
		int result= 0;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt from comm where commsns=?");
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, commsns);
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
	public ArrayList<CommVO> getCommList(Map<String,Integer> map){
		ArrayList<CommVO> commSnsList= null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sql = new StringBuffer();
		sql.append("select c.conum,c.commsns,m.memname coname,comem,m.memprofile coimg,c.cocont,to_char(c.codate,'MM')||'월'||to_char(c.codate,'dd')||'일'||to_char(c.codate,'hh:mm') codate");
		sql.append(" from (select * from comm c where commsns=? order by 1 desc) c,member m");
		sql.append(" where m.memnum=c.comem and rownum between ? and ?");
		try {
			commSnsList=new ArrayList<>();
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			System.out.println("~~~~~~~~~"+map.get("commsns"));
			System.out.println("~~~~~~~~~"+map.get("begin"));
			System.out.println("~~~~~~~~~"+map.get("end"));
			pstmt.setInt(1, map.get("commsns"));
			pstmt.setInt(2, map.get("begin"));
			pstmt.setInt(3, map.get("end"));
			rs = pstmt.executeQuery();
			while(rs.next()){
				CommVO v = new CommVO();
				v.setConum(rs.getInt("conum"));
				v.setCommsns(rs.getInt("commsns"));
				v.setConame(rs.getString("coname"));
				v.setComem(rs.getInt("comem"));
				v.setCoimg(rs.getString("coimg"));
				v.setCocont(rs.getString("cocont"));
				v.setCodate(rs.getString("codate"));
				
				commSnsList.add(v);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return commSnsList;
	}
	public void inssertSnsComm(HashMap<String,String> map){
		Connection con=null;
		PreparedStatement pstmt=null;
		StringBuffer sql =new StringBuffer();
		sql.append("insert into comm(conum,cocont,codate,comem,commsns)");
		sql.append(" values(comm_seq.nextVal,?,sysdate,?,?)");
		try{
			con=ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("cocont"));
			pstmt.setInt(2, Integer.parseInt(map.get("comem")));
			pstmt.setInt(3, Integer.parseInt(map.get("commsns")));
			pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
}
