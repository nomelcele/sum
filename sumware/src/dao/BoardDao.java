package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import service.FactorySrevice;
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
		SqlSession ss = FactorySrevice.getFactory().openSession(true);
		ss.insert("board.insert", map);
		ss.close();
	}
	
	// boardList 가져오기.
	public List<BoardVO> getList(Map<String, Integer> map) {
		SqlSession ss = FactorySrevice.getFactory().openSession();
		List<BoardVO> list = ss.selectList("board.getList",map);
		ss.close();
		return list;
	}
	
	// 게시글에 대한 총 갯수 구해주는 메서드.
	public int getTotalCount(int no) {
		int res = 0;
		SqlSession ss = FactorySrevice.getFactory().openSession();
		res = ss.selectOne("board.getTotalCount",no);
		ss.close();
		return res;
	}

	// Comm 의 total
	// 인자값 즉, detail 의 pk 값을 기준으로,
	// detail 페이지에 소속된 댓글의 전체 카운트 값을 가져온다.
	public int getTotalCommCount(int no) {
		int res = 0;
		SqlSession ss = FactorySrevice.getFactory().openSession();
		res = ss.selectOne("board.getTotalCommCount",no);
		ss.close();
		return res;
	}
	
	// 게시글 상세보기 메서드.
	public BoardVO getDetail(int no){
		BoardVO v = null;
		SqlSession ss = FactorySrevice.getFactory().openSession();
		v = ss.selectOne("board.getDetail",no);
		ss.close();
		hitUp(no);
		return v;
	}
	// 조회수 증가 시켜주는 메서드.
	private void hitUp(int bnum){
		SqlSession ss = FactorySrevice.getFactory().openSession();
		ss.selectOne("board.hitUp",bnum);
		ss.close();
	}
	
	// 게시글에 대한 댓글 불러오는 메서드.
	public List<CommVO> getCommList(HashMap<String, String> map){
		// SELECT c.cocont,c.codate,m.memname,c.CODATE,m.MEMPROFILE FROM COMM c, MEMBER m
		// WHERE c.comem = m.memnum AND coboard = 67;
		int code = Integer.parseInt(map.get("no"));
		SqlSession ss = FactorySrevice.getFactory().openSession();
		List<CommVO> list = ss.selectList("board.getCommList",code);
		ss.close();
		
		return list;
	}
	// 댓글 입력 메서드.
	public void commInsert(HashMap<String, String> map){
		SqlSession ss = FactorySrevice.getFactory().openSession(true);
		ss.insert("board.commInsert",map);
		ss.close();
	}
	// 게시판 이름이 필요 하기 때문에 그 이름 반환 해주는 메서드.
	public List<BnameVO> bName(HashMap<String, String> map){
		SqlSession ss = FactorySrevice.getFactory().openSession();
		List<BnameVO> list= ss.selectList("board.bName",map);
		System.out.println("이름다 뽑았다.");
		return list;
	}
	// 게시글 삭제 메서드
	public void delete(HashMap<String, String> map){
		SqlSession ss = FactorySrevice.getFactory().openSession(true);
		ss.delete("board.delete",Integer.parseInt(map.get("no")));
		ss.close();	
	}
	
	// 게시판 추가 하는 메서드
	public void addBoard(HashMap<String, String> map){
		SqlSession ss = FactorySrevice.getFactory().openSession(true);
		ss.delete("board.addBoard",map);
		ss.close();	
	}
}

