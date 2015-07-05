package com.sumware.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.BnameVO;
import com.sumware.dto.BoardVO;
import com.sumware.dto.CommVO;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate ss;

	// boardWrite 하는 insert 메서드.
	public void insert(BoardVO bvo) {
		ss.insert("board.insert", bvo);
	}

	// 조회수 증가 시켜주는 메서드.
	private void hitUp(int bnum) {
		ss.selectOne("board.hitUp", bnum);
	}

	// boardList 가져오기.
	public List<BoardVO> getList(BoardVO bvo) {
		List<BoardVO> list = ss.selectList("board.getList", bvo);
		return list;
	}

	// 게시글에 대한 총 갯수 구해주는 메서드.
	public int getTotalCount(int no) {
		int res = 0;
		res = ss.selectOne("board.getTotalCount", no);
		return res;
	}

	// 게시판 목록이 필요 하기 때문에 그 이름 반환 해주는 메서드.
	public List<BnameVO> bNameList(int bdeptno) {
		List<BnameVO> list = ss.selectList("board.bNameList", bdeptno);
		System.out.println("이름다 뽑았다.");
		return list;
	}

	// 게시판의 이름 불러 오는 메소드
	public String bName(int bgnum) {
		String bname = ss.selectOne("board.bName", bgnum);
		return bname;
	}

	// 게시글 삭제 메서드
	public void delete(int no) {
		ss.delete("board.delete", no);
	}

	// 게시글 상세보기 메서드.
	public BoardVO getDetail(int no) {
		BoardVO v = null;
		v = ss.selectOne("board.getDetail", no);
		hitUp(no);
		return v;
	}

	// ///////////////////////////////// 댓글 관련
	// 게시글에 대한 댓글 불러오는 메서드.
	public List<CommVO> getCommList(int code) {
		// SELECT c.cocont,c.codate,m.memname,c.CODATE,m.MEMPROFILE FROM COMM c,
		// MEMBER m
		// WHERE c.comem = m.memnum AND coboard = 67;
		List<CommVO> list = ss.selectList("board.getCommList", code);
		return list;
	}

	// 댓글 입력 메서드.
	public void commInsert(CommVO vo) {
		ss.insert("board.commInsert", vo);
	}

	// Comm 의 total
	// 인자값 즉, detail 의 pk 값을 기준으로,
	// detail 페이지에 소속된 댓글의 전체 카운트 값을 가져온다.
	public int getTotalCommCount(int no) {
		int res = 0;
		res = ss.selectOne("board.getTotalCommCount", no);
		return res;
	}
	
	// 댓글 삭제
	public void commDelete(int conum){
		ss.delete("board.commDelete",conum);
	}
	//게시글 검색된 수
	public int searchCount(BoardVO bvo){
		return ss.selectOne("board.searchCount",bvo);
	}
	
}
