package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import util.CloseUtil;
import conn.ConUtil;
import dto.MemberVO;
import dto.TodoVO;

public class TodoDao {
	private static TodoDao dao;

	public synchronized static TodoDao getDao() {
		if(dao == null) dao = new TodoDao();
		return dao;
	}
	
	
	// 업무추가창 팝업 시 콤보박스에 보여줄 팀장목록.
	public ArrayList<MemberVO> getTomem(int memmgr){
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;
		ArrayList<MemberVO> list = new ArrayList<>();	
		
		try {
			sql.append("select memname, memnum from member where memmgr=?");
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memmgr);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVO v = new MemberVO();
				v.setMemname(rs.getString("memname"));
				v.setMemnum(rs.getInt("memnum"));
				list.add(v);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return list;

	}
	
	
	public void addTodo(HashMap<String,String> map){
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		try {
			sql.append("insert into todo values(todo_seq.nextVal,?,?,?,?,?,?,?,?,?)");
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("tostdate"));
			pstmt.setString(2, map.get("toendate"));
			pstmt.setString(3, map.get("totile"));
			pstmt.setString(4, map.get("tocont"));
			pstmt.setString(5, map.get("tofile"));
			pstmt.setInt(6, Integer.parseInt(map.get("todept")));
			pstmt.setInt(7, Integer.parseInt(map.get("tomem")));
			pstmt.setString(8, map.get("toconfirm"));
			pstmt.setString(9, map.get("tocomm"));
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		
	}
	
	// 업무관리창 팝업 시 업무 리스트.
		public ArrayList<TodoVO> checkTodoList(int tomem){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			ResultSet rs = null;
			ArrayList<TodoVO> list = new ArrayList<>();	
			
			try {
				sql.append("select tonum, to_char(tostdate,'yyyy-mm-dd') tostdate, to_char(toendate,'yyyy-mm-dd') toendate, totitle, tocont, tofile, todept, tomem, toconfirm, tocomm ");
				sql.append("from todo where toconfirm = 'n' and tomem=?");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, tomem);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					TodoVO v = new TodoVO();
					v.setTonum(rs.getInt("tonum"));
					v.setTostdate(rs.getString("tostdate"));
					v.setToendate(rs.getString("toendate"));
					v.setTotitle(rs.getString("totitle"));
					v.setTocont(rs.getString("tocont"));
					v.setTofile(rs.getString("tofile"));
					v.setTodept(rs.getInt("todept"));
					v.setTomem(rs.getInt("tomem"));
					v.setToconfirm(rs.getString("toconfirm"));
					v.setTocomm(rs.getString("tocomm"));
					list.add(v);
				}
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}finally{
				CloseUtil.close(rs);
				CloseUtil.close(pstmt);
				CloseUtil.close(con);
			}
			return list;

		}
		
		
		
		// 승인했을 시 n을 y나 x로 바꿔주는 메서드
		public void confirmTodo(int tonum,String tocomm, String toconfirm){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			
			try {
				sql.append("update todo set toconfirm=?, tocomm=? where tonum=?");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, toconfirm);
				pstmt.setString(2, tocomm);
				pstmt.setInt(3, tonum);
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}finally{
				CloseUtil.close(pstmt);
				CloseUtil.close(con);
			}
			
		}


		public ArrayList<TodoVO> getFWMana(int tomem) {
			ArrayList<TodoVO> list=null;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			StringBuilder sql = new StringBuilder();
			sql.append("select rownum tonum,tostdate,toendate,totitle,tocont,tomem,tocomm,toconfirm")
			.append(" from (select * from todo where todept=(select memdept from member where memnum=?) order by 1 desc)");
			try{
				list=new ArrayList<TodoVO>();
				con=ConUtil.getOds();
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, tomem);
				rs=pstmt.executeQuery();
				while(rs.next()){
					TodoVO v = new TodoVO();
					v.setTonum(rs.getInt("tonum"));
					v.setTostdate(rs.getString("tostdate"));
					v.setToendate(rs.getString("tostdate"));
					v.setTotitle(rs.getString("totitle"));
					v.setTocont(rs.getString("tocont"));
					v.setTomem(rs.getInt("tomem"));
					v.setTocomm(rs.getString("tocomm"));
					v.setToconfirm(rs.getString("toconfirm"));
					list.add(v);
				}
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				CloseUtil.close(rs);
				CloseUtil.close(pstmt);
				CloseUtil.close(con);
			}
			return list;
		}

}
