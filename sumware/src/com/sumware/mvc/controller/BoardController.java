package com.sumware.mvc.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.BnameVO;
import com.sumware.dto.BoardVO;
import com.sumware.dto.CommVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.BoardDao;
import com.sumware.util.MyPage;

@Controller
public class BoardModel {
	@Autowired
	private BoardDao dao;
	private int page;
	// 게시판 목록
	@RequestMapping(value="/saboardList")
	public ModelAndView getList(BoardVO bvo,HttpServletRequest req,HttpSession ses){
		ModelAndView mav = new ModelAndView();
		String first = (String) ses.getAttribute("first");
		if(first.equals("1")){
			mav.setViewName("safirstLoginForm");
		}else if(first.equals("0")){
			ses.invalidate();
			mav.setViewName("home");
		}else{
			
			Map<String,Integer> pMap;
			
			int bgnum = bvo.getBgnum();
	
			mav.setViewName("board.boardList");
			
			ses.setAttribute("model", "board");
			ses.setAttribute("bname", boardName(bgnum));
			ses.setAttribute("bbbgnum", bgnum);
			
			ses.setAttribute("boardSearch", bvo.getBsearch());
			ses.setAttribute("boardDiv", bvo.getDiv());
			if((!bvo.getBsearch().isEmpty())){
				bvo.setBtitle(bvo.getBsearch());
				pMap =MyPage.getMp().pageProcess(req, 10, 5, 0, dao.searchCount(bvo), 0);	
			}else{
				pMap =MyPage.getMp().pageProcess(req, 10, 5, 0, dao.getTotalCount(bgnum), 0);	
			}
			
			int begin = pMap.get("begin");
			int end = pMap.get("end");
			this.page = pMap.get("page");
			ses.setAttribute("boardPage", this.page);
			bvo.setBegin(begin);
			bvo.setEnd(end);
			
			mav.addObject("list",boardList(bvo));
			
			// contentLeft.jsp 에 뿌려줄 게시판 이름 불러오는 로직.
	//		MemberVO v = (MemberVO) ses.getAttribute("v");
	//		System.out.println("접속자의 부서번호 : "+v.getMemnum());
	//		ses.setAttribute("bNameList", boardNameList(v.getMemdept()));
	//		ses.setAttribute("currentPage", page);
			
			// contentLeft.jsp 에 뿌려줄 게시판 이름 불러오는 로직.
			MemberVO v = (MemberVO) ses.getAttribute("v");
			MemberVO adv = (MemberVO) ses.getAttribute("adminv");
			if(v != null){ // 일반 사원이 로그인했을 경우
				ses.setAttribute("bNameList", boardNameList(v.getMemdept()));
				ses.setAttribute("currentPage", page);
			} else { // 관리자 모드의 게시판 열람에서 접근했을 경우
				mav.setViewName("board/boardList");
			}	
		}
		return mav;
	}
	
	// 디테일 목록! 
	@RequestMapping(value="/saboardDetail",method=RequestMethod.POST)
	public ModelAndView getDetail(int no){
		ModelAndView mav = new ModelAndView("board/boardDetail");
		BoardVO v = dao.getDetail(no);
		mav.addObject("clist",commList(no));
		mav.addObject("board",v);
		return mav;
	}
	
	// 글작성 폼 !
	@RequestMapping(value="/saboardWrite",method=RequestMethod.POST)
	public String writeForm(){
		return "board.boardWrite";
	}
	
	
	// 글 입력 !!!
	@RequestMapping(value="/saboardInsert", method=RequestMethod.POST)
	public ModelAndView boardInsert(BoardVO bvo,HttpServletRequest req){
		dao.insert(bvo);
		ModelAndView mav = new ModelAndView("board.boardList");
		int bgnum=bvo.getBgnum();
		int begin = MyPage.getMp().pageProcess(req, 10, 5, 0, dao.getTotalCount(bgnum), 0).get("begin");
		int end = MyPage.getMp().pageProcess(req, 10, 5, 0, dao.getTotalCount(bgnum), 0).get("end");
//		map.put("begin", String.valueOf(begin));
//		map.put("end", String.valueOf(end));
		bvo.setBegin(begin);
		bvo.setEnd(end);
		mav.addObject("list",boardList(bvo));
		return mav;
	}

	// 게시글 삭제.
	@RequestMapping(value="/saboardDelete", method=RequestMethod.POST)
	public ModelAndView boardDelete(BoardVO vo){

		ModelAndView mav = new ModelAndView("redirect:/saboardList?page="+page+"&bdeptno="+vo.getBdeptno()+"&bgnum="+vo.getBgnum()+"&model=board&bsearch=");
		dao.delete(vo.getBnum());
		return mav;
	}
	
	// 댓글 입력 !!!!
	@RequestMapping(value="/sacommIn",method=RequestMethod.POST)
	public ModelAndView commIn(CommVO vo){
		ModelAndView mav = new ModelAndView("board/boardComm");
		dao.commInsert(vo);
		mav.addObject("clist",commList(vo.getCoboard()));
		mav.addObject("board",vo.getCoboard());
		return mav;
	}
	
	// 댓글 삭제.
	@RequestMapping(value="/sacommDelete",method=RequestMethod.POST)
	public ModelAndView commDelete(CommVO vo){
		ModelAndView mav = new ModelAndView("board/boardComm");
		dao.commDelete(vo.getConum());
		mav.addObject("clist",commList(vo.getCoboard()));
		mav.addObject("board",vo.getCoboard());
		return mav;
	}
	//suggest
	@RequestMapping(value="/saboardSearchSug")
	public void boardSearchSug(String bsearch,HttpServletResponse response) throws IOException{

		StringBuilder sb = new StringBuilder();
		sb.append("[\"").append(bsearch).append(" 제목\"").append(",")
		.append("\"").append(bsearch).append(" 작성자\"").append(",")
		.append("\"").append(bsearch).append(" 내용\"").append(",")
		.append("\"").append(bsearch).append(" 제목+내용\"").append("]");
		
		PrintWriter pw = response.getWriter();
		pw.write(sb.toString());
		pw.flush();
		pw.close();
		
	}
	
	// 실제로 게시글! 리스트 불러오는 메서드 컨트롤러가 내부에서 사용 됨.
	private List<BoardVO> boardList(BoardVO bvo){
		List<BoardVO> list = dao.getList(bvo);
		return list;
	}
	
	// 게시판! 의 목록을 불러오는 메서드
	private List<BnameVO> boardNameList(int bdetpno){
		List<BnameVO> list = dao.bNameList(bdetpno);
		return list;
	}
	
	// 게시판 이름 불러오는 메서드
	private String boardName(int bgnum){
		String bname = dao.bName(bgnum);
		return bname;
	}
	
	// 댓글 목록 불러오는 메서드!
	private List<CommVO> commList(int no){
		List<CommVO> list = dao.getCommList(no);
		return list;
	}
	
}
