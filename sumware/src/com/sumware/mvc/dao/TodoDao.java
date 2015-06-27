package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;
import com.sumware.dto.TodoJobVO;
import com.sumware.dto.TodoVO;


@Repository
public class TodoDao {
	@Autowired
	private SqlSessionTemplate st;

	
	// 업무추가창 팝업 시 콤보박스에 보여줄 팀장목록.
	public List<MemberVO> getTomem(int memmgr){
		return st.selectList("todo.getTomems", memmgr);

	}
	
	// 부장의 업무 추가 
	public void addTodo(TodoVO tvo){
		st.insert("todo.addTodo", tvo);
		
	}
	
	// 업무관리창 팝업 시 업무 리스트.
		public List<TodoVO> checkTodoList(int tomem){
			return st.selectList("todo.checkTodoList", tomem);

		}
		

		// 승인했을 시 n을 y나 z로 바꿔주는 메서드
		public void confirmTodo(TodoVO tvo, String toconfirm){
			if(toconfirm.equals("y")){
				st.update("todo.confirmTodoY", tvo);
			}else if(toconfirm.equals("z")){
				st.update("todo.confirmTodoZ", tvo);
			}
			
		}

		// 부서의 업무리스트 가져오기?
		public List<TodoVO> getFWMana(int tomem) {
			return st.selectList("todo.getDeptTodoList", tomem);
		}


		public List<TodoVO> todoUpdate(TodoVO tvo) {
			st.update("todo.todoUpdate", tvo);
			return st.selectList("todo.getDeptTodoList", tvo.getTomem());
//			
//			ArrayList<TodoVO> list = null;
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			sql.append("update todo set toconfirm=?, tomem=?,tocomm=? where tonum=?");
//			try{
//				con=ConUtil.getOds();
//				pstmt=con.prepareStatement(sql.toString());
//				pstmt.setString(1, map.get("toconfirm"));
//				pstmt.setInt(2, Integer.parseInt(map.get("tomem")));
//				pstmt.setString(3, map.get("tocomm"));
//				pstmt.setInt(4, Integer.parseInt(map.get("tonum")));
//				pstmt.executeUpdate();
//				System.out.println("업데이트완료");
//				//업데이트를 한후에 다시 todo리스트를 다시 받아서 보냄.
//				list = getFWMana(Integer.parseInt(map.get("memnum")));
//			}catch(SQLException e){
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
//			return list;
		}
		
		public List<TodoVO> getDeptList(MemberVO mvo){
			
			return st.selectList("todo.getDeptList", mvo);
//			
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			ResultSet rs = null;
//			ArrayList<TodoVO> list = new ArrayList<>();	
//			
//			try {
//				sql.append("select tonum, to_char(tostdate,'yyyy-mm-dd') tostdate, to_char(toendate,'yyyy-mm-dd') toendate, totitle, tocont, tofile, todept, tomem, toconfirm, tocomm ");
//				sql.append("from todo where todept=?");
//				con = ConUtil.getOds();
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, Integer.parseInt(map.get("memdept")));
//				
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()){
//					TodoVO v = new TodoVO();
//					v.setTonum(rs.getInt("tonum"));
//					v.setTostdate(rs.getString("tostdate"));
//					v.setToendate(rs.getString("toendate"));
//					v.setTotitle(rs.getString("totitle"));
//					v.setTocont(rs.getString("tocont"));
//					v.setTofile(rs.getString("tofile"));
//					v.setTodept(rs.getInt("todept"));
//					v.setTomem(rs.getInt("tomem"));
//					v.setToconfirm(rs.getString("toconfirm"));
//					v.setTocomm(rs.getString("tocomm"));
//					list.add(v);
//				}
//				
//			} catch (SQLException e) {
//				
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(rs);
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
//			return list;

		}
		
		
		// 팀장이 승인한 업무들 쭉나열
		public List<TodoVO> getTeamTodoList(MemberVO mvo){
			return st.selectList("todo.getTeamTodoList", mvo);
			
			
			
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			ResultSet rs = null;
//			ArrayList<TodoVO> list = new ArrayList<>();	
//			
//			try {
//				sql.append("select t.tonum, to_char(t.tostdate,'yyyy-mm-dd') tostdate, to_char(t.toendate,'yyyy-mm-dd') toendate, t.totitle, t.tocont, t.tofile, t.todept, t.tomem, t.toconfirm, t.tocomm, m.memname ");
//				sql.append("from todo t, member m where t.tomem = m.memnum and t.tomem=? and t.toconfirm='y' order by 1 desc");
//				con = ConUtil.getOds();
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, Integer.parseInt(map.get("memnum")));
//				System.out.println("memnummm::"+map.get("memnum"));
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()){
//					System.out.println("검색값있음");
//					TodoVO v = new TodoVO();
//					v.setTonum(rs.getInt("tonum"));
//					v.setTostdate(rs.getString("tostdate"));
//					v.setToendate(rs.getString("toendate"));
//					v.setTotitle(rs.getString("totitle"));
//					v.setTocont(rs.getString("tocont"));
//					v.setTofile(rs.getString("tofile"));
//					v.setTodept(rs.getInt("todept"));
//					v.setTomem(rs.getInt("tomem"));
//					v.setToconfirm(rs.getString("toconfirm"));
//					v.setTocomm(rs.getString("tocomm"));
//					v.setMemname(rs.getString("memname"));
//					list.add(v);
//				}
//				
//			} catch (SQLException e) {
//				
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(rs);
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
//			return list;

		}
		
		// 사원들에게 업무지정
		public void insertMemJob(TodoJobVO tjvo){
			st.insert("todo.insertMemJob", tjvo);
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			
//			try {
//				sql.append("insert into todojob values(todojob_seq.nextVal,?,?,?)");
//				con = ConUtil.getOds();
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, Integer.parseInt(map.get("jobtonum")));
//				pstmt.setInt(2, Integer.parseInt(map.get("jobmemnum")));
//				pstmt.setString(3, map.get("jobcont"));
//				
//				pstmt.executeUpdate();
//				
//			} catch (SQLException e) {
//				
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
			
		}
		
		// 업무별 사원들의 담당업무 뽑아옴
		public List<TodoJobVO> getMembersJob(int jobtonum){
			return st.selectList("todo.getMembersJob", jobtonum);
			
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			ResultSet rs = null;
//			ArrayList<TodoJobVO> list = new ArrayList<>();	
//			
//			try {
//				sql.append("select j.jobnum, m.memname, m.memprofile, j.jobcont from todojob j, member m where m.memnum = j.jobmemnum and j.jobtonum=? order by 1 desc");
//				con = ConUtil.getOds();
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, jobtonum);
//				
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()){
//					TodoJobVO v = new TodoJobVO();
//					v.setMemname(rs.getString("memname"));
//					v.setMemprofile(rs.getString("memprofile"));
//					v.setJobcont(rs.getString("jobcont"));	
//					list.add(v);
//				}
//				
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(rs);
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
//			return list;
		}
		
		
		// 부서의 업무 리스트 뽑아옴
		public List<TodoVO> getDeptJob(int todept){
			return st.selectList("todo.getDeptJob", todept);
			
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			ResultSet rs = null;
//			ArrayList<TodoVO> list = new ArrayList<>();	
//			
//			try {
//				sql.append("select t.tonum, to_char(t.tostdate,'yyyy-mm-dd') tostdate, to_char(t.toendate,'yyyy-mm-dd') toendate, t.totitle, t.tocont, t.tofile, t.todept, t.tomem, t.toconfirm, t.tocomm,m.memname ");
//				sql.append("from todo t, member m where t.tomem = m.memnum and t.todept=? and t.toconfirm='y' order by 1 desc");
//				con = ConUtil.getOds();
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, todept);
//				
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()){
//					TodoVO v = new TodoVO();	
//					v.setTonum(rs.getInt("tonum"));
//					v.setTostdate(rs.getString("tostdate"));
//					v.setToendate(rs.getString("toendate"));
//					v.setTotitle(rs.getString("totitle"));
//					v.setTocont(rs.getString("tocont"));
//					v.setTofile(rs.getString("tofile"));
//					v.setTodept(rs.getInt("todept"));
//					v.setTomem(rs.getInt("tomem"));
//					v.setToconfirm(rs.getString("toconfirm"));
//					v.setTocomm(rs.getString("tocomm"));
//					v.setMemname(rs.getString("memname"));
//					list.add(v);
//			
//				}
//				
//			} catch (SQLException e) {
//				
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(rs);
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
//			return list;
		}
		
		
		public List<TodoVO> getTeamJob(int memmgr){
			
			return st.selectList("todo.getTeamJob", memmgr);
			
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			StringBuffer sql = new StringBuffer();
//			ResultSet rs = null;
//			ArrayList<TodoVO> list = new ArrayList<>();	
//			
//			try {
//				sql.append("select t.tonum, to_char(t.tostdate,'yyyy-mm-dd') tostdate, to_char(t.toendate,'yyyy-mm-dd') toendate, t.totitle, t.tocont, t.tofile, t.todept, t.tomem, t.toconfirm, t.tocomm,m.memname ");
//				sql.append("from todo t, member m where t.tomem = m.memnum and t.toconfirm='y' and (m.memnum = ? or m.memmgr = ?) order by 1 desc");
//				con = ConUtil.getOds();
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, memmgr);
//				pstmt.setInt(2, memmgr);
//				
//				rs = pstmt.executeQuery();
//				
//				while(rs.next()){
//					TodoVO v = new TodoVO();	
//					v.setTonum(rs.getInt("tonum"));
//					v.setTostdate(rs.getString("tostdate"));
//					v.setToendate(rs.getString("toendate"));
//					v.setTotitle(rs.getString("totitle"));
//					v.setTocont(rs.getString("tocont"));
//					v.setTofile(rs.getString("tofile"));
//					v.setTodept(rs.getInt("todept"));
//					v.setTomem(rs.getInt("tomem"));
//					v.setToconfirm(rs.getString("toconfirm"));
//					v.setTocomm(rs.getString("tocomm"));
//					v.setMemname(rs.getString("memname"));
//					list.add(v);
//			
//				}
//				
//			} catch (SQLException e) {
//				
//				e.printStackTrace();
//			}finally{
//				CloseUtil.close(rs);
//				CloseUtil.close(pstmt);
//				CloseUtil.close(con);
//			}
//			return list;

		}
		

}
