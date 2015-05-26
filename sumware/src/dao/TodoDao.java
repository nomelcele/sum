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
import dto.TodoJobVO;
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
			sql.append("select memname, memnum, memprofile, memjob, memauth, memmail, meminmail, memdept from member where memmgr=?");
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, memmgr);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVO v = new MemberVO();
				v.setMemname(rs.getString("memname"));
				v.setMemnum(rs.getInt("memnum"));
				v.setMemprofile(rs.getString("memprofile"));
				v.setMemjob(rs.getString("memjob"));
				v.setMemauth(Integer.parseInt(rs.getString("memauth")));
				v.setMemmail(rs.getString("memmail"));
				v.setMeminmail(rs.getString("meminmail"));
				v.setMemdept(Integer.parseInt(rs.getString("memdept")));
				
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
	
	// 부장의 업무 추가 
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
			pstmt.setString(3, map.get("totitle"));
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
				sql.append("from todo where toconfirm = 'n' and tomem=? order by 1 desc");
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
		

		// 승인했을 시 n을 y나 z로 바꿔주는 메서드
		public void confirmTodo(HashMap<String,String> map, String toconfirm){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			
			try {
				sql.append("update todo set toconfirm=?, tocomm=? where tonum=?");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, toconfirm);
				pstmt.setString(2, map.get("tocomm"));
				pstmt.setInt(3, Integer.parseInt(map.get("tonum")));
				
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
			sql.append("select rownum torownum, tonum,to_char(tostdate,'yyyy-MM-dd') tostdate,")
			.append("to_char(toendate,'yyyy-MM-dd') toendate,nvl(totitle,'제목없음') totitle,tocont,tomem,tocomm,toconfirm ")
			.append(" from (select * from todo where todept=(select memdept from member where memnum=?) order by toconfirm desc, 1 desc)");
			try{
				list=new ArrayList<TodoVO>();
				con=ConUtil.getOds();
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, tomem);
				rs=pstmt.executeQuery();
				while(rs.next()){
					TodoVO v = new TodoVO();
					v.setTorownum(rs.getInt("torownum"));
					v.setTonum(rs.getInt("tonum"));
					v.setTostdate(rs.getString("tostdate"));
					v.setToendate(rs.getString("toendate"));
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


		public ArrayList<TodoVO> todoUpdate(HashMap<String, String> map) {
			ArrayList<TodoVO> list = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			sql.append("update todo set toconfirm=?, tomem=?,tocomm=? where tonum=?");
			try{
				con=ConUtil.getOds();
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, map.get("toconfirm"));
				pstmt.setString(2, map.get("tomem"));
				pstmt.setString(3, map.get("tocomm"));
				pstmt.setInt(4, Integer.parseInt(map.get("tonum")));
				pstmt.executeUpdate();
				//업데이트를 한후에 다시 todo리스트를 다시 받아서 보냄.
				list = getFWMana(Integer.parseInt(map.get("memnum")));
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				CloseUtil.close(pstmt);
				CloseUtil.close(con);
			}
			return list;
		}
		
		public ArrayList<TodoVO> getDeptList(HashMap<String, String> map){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			ResultSet rs = null;
			ArrayList<TodoVO> list = new ArrayList<>();	
			
			try {
				sql.append("select tonum, to_char(tostdate,'yyyy-mm-dd') tostdate, to_char(toendate,'yyyy-mm-dd') toendate, totitle, tocont, tofile, todept, tomem, toconfirm, tocomm ");
				sql.append("from todo where todept=?");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, Integer.parseInt(map.get("memdept")));
				
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
		
		// 팀장이 승인한 업무들 쭉나열
		public ArrayList<TodoVO> getTeamTodoList(HashMap<String, String> map){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			ResultSet rs = null;
			ArrayList<TodoVO> list = new ArrayList<>();	
			
			try {
				sql.append("select t.tonum, to_char(t.tostdate,'yyyy-mm-dd') tostdate, to_char(t.toendate,'yyyy-mm-dd') t.toendate, t.totitle, t.tocont, t.tofile, t.todept, t.tomem, t.toconfirm, t.tocomm, m.memname ");
				sql.append("from todo t, member m where t.tomem = m.memnum and tomem=? and toconfirm='y' order by 1 desc");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, Integer.parseInt(map.get("memnum")));
				
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
					v.setMemname(rs.getString("memname"));
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
		
		// 사원들에게 업무지정
		public void insertMemJob(HashMap<String,String> map){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			
			try {
				sql.append("insert into todojob values(todojob_seq.nextVal,?,?,?)");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, Integer.parseInt(map.get("jobtonum")));
				pstmt.setInt(2, Integer.parseInt(map.get("jobmemnum")));
				pstmt.setString(3, map.get("jobcont"));
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				
				e.printStackTrace();
			}finally{
				CloseUtil.close(pstmt);
				CloseUtil.close(con);
			}
			
		}
		
		// 업무별 사원들의 담당업무 뽑아옴
		public ArrayList<TodoJobVO> getMembersJob(int jobtonum){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			ResultSet rs = null;
			ArrayList<TodoJobVO> list = new ArrayList<>();	
			
			try {
				sql.append("select j.jobnum, m.memname, m.memprofile, j.jobcont from todojob j, member m where m.memnum = j.jobmemnum and jobtonum=? order by 1 desc");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, jobtonum);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					TodoJobVO v = new TodoJobVO();
					v.setMemname(rs.getString("memname"));
					v.setMemprofile(rs.getString("memprofile"));
					v.setJobcont(rs.getString("jobcont"));	
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
		
		
		// 부서의 업무 리스트 뽑아옴
		public ArrayList<TodoVO> getDeptJob(int todept){
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuffer sql = new StringBuffer();
			ResultSet rs = null;
			ArrayList<TodoVO> list = new ArrayList<>();	
			
			try {
				sql.append("select t.tonum, to_char(t.tostdate,'yyyy-mm-dd') tostdate, to_char(t.toendate,'yyyy-mm-dd') toendate, t.totitle, t.tocont, t.tofile, t.todept, t.tomem, t.toconfirm, t.tocomm,m.memname ");
				sql.append("from todo t, member m where t.tomem = m.memnum and todept=? and toconfirm='y' order by 1 desc");
				con = ConUtil.getOds();
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, todept);
				
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
					v.setMemname(rs.getString("memname"));
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
		

}
