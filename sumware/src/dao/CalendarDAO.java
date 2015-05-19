package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.ConUtil;
import util.CloseUtil;
import dto.CalendarVO;

public class CalendarDAO {
	private static CalendarDAO dao;

	public static synchronized CalendarDAO getDao() {
		if(dao==null){
			dao = new CalendarDAO();
		}
		return dao;
	}
	public boolean insertCal(CalendarVO v){
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into calendar values(calendar_seq.nextVal,?,?,?,?,?,?)");
		try{
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, v.getCalstart());
			pstmt.setString(2, v.getCalend());
			pstmt.setString(3, v.getCalcont());
			pstmt.setInt(4, v.getCaldiv());//켈린더 분류
			pstmt.setInt(5, v.getCaldept());
			pstmt.setInt(6, v.getCalmem());
			
			pstmt.executeUpdate();
			result = true;
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(con);
			CloseUtil.close(pstmt);
		}
		return result;
	}
	private ArrayList<CalendarVO> getCalList(){
		ArrayList<CalendarVO> calList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select to_char(calstart,'yyyy-MM-DD') calstart,")
			.append("nvl(to_char(calend,'yyyy-MM-DD'),'0') calend,")
			.append("calcont,caldiv from calendar");
		try{
			calList = new ArrayList<CalendarVO>();
			con = ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()){
				CalendarVO v = new CalendarVO();
				v.setCalstart(rs.getString("calstart"));
				v.setCalend(rs.getString("calend"));
				v.setCalcont(rs.getString("calcont"));
				v.setCaldiv(rs.getInt("caldiv"));
				calList.add(v);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		System.out.println("list:"+calList);
		return calList;
	}
	public String makeJson(){
		ArrayList<CalendarVO> list = getCalList();
		
		StringBuilder json = new StringBuilder();
		int size=list.size();
		json.append("[");
		for(int i = 0; i<size; i++){
			CalendarVO v = list.get(i);
			json.append("{title:'").append(v.getCalcont()).append("',");
			json.append("start:'").append(v.getCalstart()).append("',");
			json.append("end:'").append(v.getCalend()).append("'}");
			if(!(i ==size-1)){
				json.append(",");
			}
		}
		json.append("]");
		System.out.println("json:"+json.toString());
		return json.toString();
	}
	
}
	
