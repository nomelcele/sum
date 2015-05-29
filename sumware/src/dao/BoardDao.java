package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import util.CloseUtil;
import conn.ConUtil;
import dto.BnameVO;
import dto.BoardVO;
import dto.CommVO;

public class BoardDao {
	private static BoardDao dao;

	public static synchronized BoardDao getDao() {
		if (dao == null) {
			dao = new BoardDao();
		}
		return dao;
	}
	
	// boardWrite 하는 insert 메서드.
	public void insert(HashMap<String, String> map){
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("insert into board values");
			// 마지막 ? 는 게시판의 그룹 넘버. 그룹 넘버에 따라서 게시판의 종류가 달라진다.
			sql.append("(board_seq.nextVal,?,?,?,?,sysdate,0,?,?)");
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("btitle"));
			pstmt.setString(2, map.get("bcont"));
			pstmt.setString(3, map.get("bimg"));
			System.out.println("이것은 널인것인가봉가? "+map.get("bimg"));
			// 작성자의 사원 번호를 가져와야 한다.
			pstmt.setInt(4, Integer.parseInt(map.get("bmem")));
			pstmt.setInt(5, Integer.parseInt(map.get("bgnum")));
			pstmt.setInt(6, Integer.parseInt(map.get("bdeptno")));
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
	
	// boardList 가져오기.
	public ArrayList<BoardVO> getList(Map<String, Integer> map,HashMap<String, String> hmap) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			// pstmt 객체에 실어 보내 줄 쿼리문.
			StringBuffer sql = new StringBuffer();
			sql
			.append("select bnum,btitle,writer,bdate,bhit")
			.append(" from")
			.append(" (select tn.bnum,tn.btitle,tn.writer,tn.bdate,tn.bhit,rownum r_num")
			.append(" from")
			.append(" (select b.bnum, b.btitle, m.memname writer, to_char(b.bdate,'yy-MM-DD') bdate, b.bhit")
			.append(" from board b, member m")
			.append(" where b.bmem = m.memnum and b.bgnum=? and b.bdeptno=?")
			// tn(TotalNotice) 즉, 모든 게시물을 뜻함.
			.append(" order by b.bnum desc) tn)")
			.append(" where r_num between ? and ?");
			// Connection 객체 생성.
			con = ConUtil.getOds();
			// 생성한 con 객체를 pstmt 에 CallByReference 로 전달.
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, Integer.parseInt(hmap.get("bgnum")));
			pstmt.setInt(2, Integer.parseInt(hmap.get("bdeptno")));
			pstmt.setInt(3, map.get("begin"));
			pstmt.setInt(4, map.get("end"));
			// pstmt 객체를 통해서 쿼리를 DB 에 보내고 ResultSet 객체를통해서
			// 받아온다.
			rs = pstmt.executeQuery();
			// rs.next() 결과row가 있으면 true
			while(rs.next()){
				BoardVO v = new BoardVO();
				// 넘어온 칼럼의 타입 과 컬럼명(알리아스명) 으로 pojo 객체에 setter주입.
				v.setBnum(rs.getInt("bnum"));
				v.setBtitle(rs.getString("btitle"));
				v.setBwriter(rs.getString("writer"));
//				System.out.println(v.getBwriter());
				v.setBdate(rs.getString("bdate"));
				v.setBhit(rs.getInt("bhit"));
				list.add(v);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			// 객체를 열었으면 무조건 닫아 주어야 한다.
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return list;
	}
	
	// 게시글에 대한 총 갯수 구해주는 메서드.
	public int getTotalCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt from board");
		int res = 0;
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());

			rs = pstmt.executeQuery();
			if (rs.next()) {
				res = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return res;
	}

	// Comm 의 total
	// 인자값 즉, detail 의 pk 값을 기준으로,
	// detail 페이지에 소속된 댓글의 전체 카운트 값을 가져온다.
	public int getTotalCommCount(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt from comm where coboard=?");
		int res = 0;
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				res = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return res;
	}
	
	// 게시글 상세보기 메서드.
	public BoardVO getDetail(int no){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO v = null;
		StringBuffer sql = new StringBuffer();
		sql.append
		("select b.bhit,b.bnum,m.memname, b.btitle, b.bcont, TO_CHAR(b.bdate,'yyyy.MM.dd HH:mm') bdate").append
		(" from board b, member m where b.bmem=m.memnum and bnum=?");
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()){
				v = new BoardVO();
				v.setBnum(rs.getInt("bnum"));
				v.setBcont(rs.getString("bcont"));
				v.setBwriter(rs.getString("memname"));
				v.setBtitle(rs.getString("btitle"));
				v.setBdate(rs.getString("bdate"));
				v.setBhit(rs.getInt("bhit"));
				hitUp(rs.getInt("bhit"), rs.getInt("bnum"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		return v;
	}
	// 조회수 증가 시켜주는 메서드.
	private void hitUp(int i,int j){
		Connection con = null;
		PreparedStatement pstmt = null;
//		ResultSet rs = null;
		i += 1;
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("update board set bhit=? where bnum=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, i);
			pstmt.setInt(2, j);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
//			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
	
	// 게시글에 대한 댓글 불러오는 메서드.
	public ArrayList<CommVO> getCommList(HashMap<String, String> map){
		// SELECT c.cocont,c.codate,m.memname,c.CODATE,m.MEMPROFILE FROM COMM c, MEMBER m
		// WHERE c.comem = m.memnum AND coboard = 67;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CommVO> list = new ArrayList<CommVO>();
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select c.cocont, TO_CHAR(c.codate,'yyyy.MM.dd HH:mm') codate, m.memname,m.memprofile,c.coboard")
			.append(" from comm c, member m where c.comem = m.memnum and coboard=? order by conum desc");
			pstmt = con.prepareStatement(sql.toString());
			int code = Integer.parseInt(map.get("no"));
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();

			while(rs.next()){
				CommVO v = new CommVO();
				v.setCocont(rs.getString(1));
				v.setCodate(rs.getString(2));
				v.setConame(rs.getString(3));
				v.setCoimg(rs.getString(4));
				v.setCoboard(rs.getInt(5));
				list.add(v);
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
	// 댓글 입력 메서드.
	public void commInsert(HashMap<String, String> map){
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into comm(conum,cocont,codate,comem,coboard) ").
			append("values(comm_seq.nextval,?,sysdate,?,?)");
			pstmt = con.prepareStatement(sql.toString());
			int memnum = Integer.parseInt(map.get("memnum"));
			int bnum = Integer.parseInt(map.get("bnum"));;
			pstmt.setString(1, map.get("comment"));
			pstmt.setInt(2, memnum);
			pstmt.setInt(3, bnum);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
	}
	// 게시판 이름이 필요 하기 때문에 그 이름 반환 해주는 메서드.
	public ArrayList<BnameVO> bName(HashMap<String, String> map){
		Connection con = null;
		ArrayList<BnameVO> list= new ArrayList<BnameVO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			sql.append("select bname,bdeptno,bgnum from bname where bdeptno=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("bdeptno"));
			rs = pstmt.executeQuery();
			while(rs.next()){
				BnameVO v = new BnameVO();
				v.setBname(rs.getString(1));
				v.setBdeptno(rs.getInt(2));
				v.setBgnum(rs.getInt(3));
				list.add(v);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			CloseUtil.close(con);
		}
		System.out.println("이름다 뽑았다.");
		return list;
	}
}




















