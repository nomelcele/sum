package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

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
	public boolean calInsert(String sql,HashMap<String, String> map){
		System.out.println("cal insert start");
		boolean result = false;
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try{
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, timeFomat(map.get("start")));
			pstmt.setString(2, timeFomat(map.get("end")));
			pstmt.setString(3, map.get("title"));
			pstmt.setInt(4, Integer.parseInt(map.get("cal")));
			
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
	
	//나중에 사원의 부서명과 사원번호를 가지고 해당 일정만 가져와야함.
	//이걸 기준으로 부서일정만 가져오는것 개인일정만 가져오는것.
	public ArrayList<CalendarVO> getCalList(String sql,int cal){
		ArrayList<CalendarVO> calList = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try{
			calList = new ArrayList<CalendarVO>();
			con = ConUtil.getOds();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cal);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CalendarVO v = new CalendarVO();
				v.setCalnum(rs.getInt("calnum"));
				v.setCalstart(rs.getString("calstart"));
				v.setCalend(rs.getString("calend"));
				v.setCalcont(rs.getString("calcont"));
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
	public boolean calDel(int num){
		boolean result=false;
		Connection con=null;
		PreparedStatement pstmt=null;
		StringBuilder sql = new StringBuilder();
		sql.append("delete from calendar where calnum=?");
		try{
			con = ConUtil.getOds();
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			result=true;
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			CloseUtil.close(con);
			CloseUtil.close(pstmt);
		}
		return result;
	}
	public String makeJson(ArrayList<CalendarVO> list){
		StringBuilder json = new StringBuilder();
		int size=list.size();
		//json.append("[");
		for(int i = 0; i<size; i++){
			CalendarVO v = list.get(i);
			json.append("{title:'").append(v.getCalcont()).append("',");
			json.append("start:'").append(v.getCalstart()).append("',");
			json.append("end:'").append(v.getCalend()).append("',");
			json.append("_id:'").append(v.getCalnum()).append("'}");
			if(!(i ==size-1)){
				json.append(",");
			}
		}
		//json.append("]");
		System.out.println("json:"+json.toString());
		return json.toString();
	}
	private String timeFomat(String time){
		String result=null;
		result = time.replaceAll("T", "");
		System.out.println("timeFomat: "+result);
		return result;
	}
	public String calSQL(int n){
		StringBuffer sql = new StringBuffer();
		if(n==0){ //부서일정
			sql.append("select calnum,to_char(calstart,'yyyy-MM-DD')||'T'||to_char(calstart,'HH:mm:ss') calstart,")
				.append("nvl(to_char(calend,'yyyy-MM-DD')||'T'||to_char(calend,'HH:mm:ss'),'0') calend,")
				.append("calcont from calendar where caldept=?");
		}else if(n==1){ //사원일정
			sql.append("select calnum,to_char(calstart,'yyyy-MM-DD')||'T'||to_char(calstart,'HH:mm:ss') calstart,")
			.append("nvl(to_char(calend,'yyyy-MM-DD')||'T'||to_char(calend,'HH:mm:ss'),'0') calend,")
			.append("calcont from calendar where calmem=?");
		}else if(n==2){
			sql.append("insert into calendar(calnum,calstart,calend,calcont,caldept)");
			sql.append(" values(calendar_seq.nextVal,");
			sql.append("to_date(?,'yyyy-MM-dd-HH:mi:ss'),to_date(?,'yyyy-MM-dd-HH:mi:ss'),?,?)");
		}else if(n==3){
			sql.append("insert into calendar(calnum,calstart,calend,calcont,calmem)");
			sql.append(" values(calendar_seq.nextVal,");
			sql.append("to_date(?,'yyyy-MM-dd-HH:mi:ss'),to_date(?,'yyyy-MM-dd-HH:mi:ss'),?,?)");
		}
		return sql.toString();
	}
}
	
