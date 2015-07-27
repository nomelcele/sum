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
		System.out.println("boardfirst::"+first);
		if(first.equals("1")){
			mav.setViewName("safirstLoginForm");
		}else if(first.equals("0")){
			ses.invalidate();
			mav.setViewName("home");
		}else{
			System.out.println("보드리스트입니다람쥐!");
			System.out.println(req.getParameter("page"));
			
			Map<String,Integer> pMap;
			
			int bgnum = bvo.getBgnum();
	
			mav.setViewName("board.boardList");
			
			ses.setAttribute("model", "board");
			ses.setAttribute("bname", boardName(bgnum));
			ses.setAttribute("bbbgnum", bgnum);
			
			ses.setAttribute("boardSearch", bvo.getBsearch());
			ses.setAttribute("boardDiv", bvo.getDiv());
			System.out.println("bsearch:::::"+bvo.getBsearch());
			System.out.println("bsearch비어있나?:::::"+bvo.getBsearch().isEmpty());
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
			
	//		map.put("begin", String.valueOf(begin));
	//		map.put("end", String.valueOf(end));
			
			System.out.println("+++++++++++++++++++++++");
			System.out.println(bvo.getBgnum());
			System.out.println(bvo.getBdeptno());
			System.out.println(bvo.getBsearch());
			System.out.println(bvo.getDiv());
			System.out.println(bvo.getBegin());
			System.out.println(bvo.getEnd());
			System.out.println("+++++++++++++++++++++++");
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
				System.out.println("접속자의 사원번호 : "+v.getMemnum());
				System.out.println("접속자의 부서번호: "+v.getMemdept());
				ses.setAttribute("bNameList", boardNameList(v.getMemdept()));
				ses.setAttribute("currentPage", page);
			} else { // 관리자 모드의 게시판 열람에서 접근했을 경우
				System.out.println("관리자 게시판 열람 접근");
				System.out.println(adv.getMemdept());
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
		System.out.println("@@@@ 게시글 삭제 메서드 !!!!!!"+" / "+vo.getBnum());
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
		System.out.println("Search 들어왔어::"+bsearch);
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
	
	/*
		
		else if(submod !=null && submod.equals("boardDelete")){
			System.out.println("여기는 삭제삭제삭제!!!!!!!!!!!!!!!!!!!!!~~~~~~~");
			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
			BoardDao.getDao().delete(map);
			url = "sumware?model=board&submod=boardList&page=1&bgnum="
					+map.get("bgnum")+"&bdeptno="+map.get("bdeptno")+"&bname="+map.get("bname").toString();
			method = true; // forward
		}
		// boardDetail
		else if(submod != null && submod.equals("boardDetail")){
			int no = Integer.parseInt(request.getParameter("no"));
			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
			BoardVO list = BoardDao.getDao().getDetail(no);
			System.out.println(list.getBdate()+" / "+ list.getBcont()+" / "+map.get("no"));
			List<BnameVO> blist = BoardDao.getDao().bName(map);
			HttpSession ses = request.getSession();
			ses.setAttribute("bname", map.get("bname"));
			ses.setAttribute("bbbgnum", map.get("bgnum"));
			ses.setAttribute("blist", blist);
			request.setAttribute("list", list);
			// 댓글 불러오는 로직.
			String childmod = request.getParameter("childmod");
			System.out.println("childmod : "+childmod);
			if(childmod != null && childmod.equals("commInsert")){
				HashMap<String, String> commmap = MyMap.getMaps().getMapList(request);
				BoardDao.getDao().commInsert(commmap);
//				HttpSession sses = request.getSession();
//				sses.setAttribute("bname", map.get("bname"));
//				sses.setAttribute("bbbgnum", map.get("bgnum"));
//				sses.setAttribute("blist", blist);
			}
			List<CommVO> clist = BoardDao.getDao().getCommList(map);
			request.setAttribute("clist", clist);
			url = "board/boardDetail.jsp";
			method = true;
		}
		else if(submod != null && submod.equals("ckBoard")){
			Part part = null;
			try {
				part = request.getPart("upload");
			} catch (ServletException e) {
				e.printStackTrace();
			}
			String fileName = getFileName(part);
			// 파일이 이름이 존재 하지 않으면 업로드 하지 않는다.
			if(fileName != null && fileName.length() != 0){
				// 혹시 같은 이름의 파일이 있을 수 있으니, 업로드 되는 시간을 붙여서 
				// 실제 경로에 올려준다.
				fileName = System.currentTimeMillis()+"_"+fileName;
				part.write(fileName);
			}
			// chk callback 설정 : Ajax 로 넘어온 요청을 response 해주기 위한 설정
			// CKEditorFuncNum 은 체크에디터가 사용하는 파라미터 명.
			// callback 에 필요한 구문들이 넘어 온다.
			// 체크 에디터는 이런식으로 자기만의 방식으로 전달을 했기 때문에
			// callback 을 받을때도 자기 만의 방식으로 콜백 받아야 한다. 
			// 그렇기 때문에 callback.jsp 를 따로 작성 해 준다.
			String callback = request.getParameter("CKEditorFuncNum");
			String fileUrl = "upload/"+fileName;
			HttpSession ses = request.getSession();
			System.out.println(callback);
			ses.setAttribute("callback", callback);
			ses.setAttribute("fileUrl", fileUrl);
			url = "board/callback.jsp";
			method = false;
	*/
	/*
	private Map<String, Integer> pageProcess(HttpServletRequest request, int etc) {
		PageVO pageInfo = new PageVO();
		// 한페이지에 보일 게시글 갯수
		int rowsPerPage = 10;
		// 페이지 보이는 갯수
		int pagesPerBlock = 5;
		// 외부에서 부터 페이지 값을 받아 오는것 부터 시작
		// 1페이지 부터 시작 되어야 하니까.... page 는 1 로 시작된다.
		int currentPage = Integer.parseInt(request.getParameter("page"));

		int currentBlock = 0;
		if (currentPage % pagesPerBlock == 0) {
			currentBlock = currentPage / pagesPerBlock;
		} else {
			currentBlock = currentPage / pagesPerBlock + 1;
		}
		// 현재 블록과 페이지를 구한 다음에 시작페이지 마지막페이지 : 한블록안에 한페이지당
		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;

		int totalRows = 0;
		// 리스트인지, comm 인지를 구분함.
		// 메서드를 호출시에 etc 의 값이 0이라면 리스트의 총데이터를
		// 1 이라면 comm 의 총데이터를 가져오는 DAO 의 메서드를 따로 받아온다.
		if (etc == 0) {
			int no = Integer.parseInt(request.getParameter("bgnum"));
			totalRows = BoardDao.getDao().getTotalCount(no);
		} else if (etc == 1) {
			int no = Integer.parseInt(request.getParameter("no"));
			totalRows = BoardDao.getDao().getTotalCommCount(no);
		}

		int totalPages = 0;
		if (totalRows % rowsPerPage == 0) {
			totalPages = totalRows / rowsPerPage;
		} else {
			totalPages = totalRows / rowsPerPage + 1;
		}

		int totalBlocks = 0;
		if (totalPages % pagesPerBlock == 0) {
			totalBlocks = totalPages / pagesPerBlock;
		} else {
			totalBlocks = totalPages / pagesPerBlock + 1;
		}

		pageInfo.setCurrentPage(currentPage);
		pageInfo.setCurrentBlock(currentBlock);
		pageInfo.setRowsPerPage(rowsPerPage);
		pageInfo.setPagesPerBlock(pagesPerBlock);
		pageInfo.setStartRow(startRow);
		pageInfo.setEndRow(endRow);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		pageInfo.setTotalBlocks(totalBlocks);
		
		HttpSession ses = request.getSession();
		ses.setAttribute("pageInfo", pageInfo);
		System.out.println("커렌트 블럭 : " + pageInfo.getCurrentBlock());
		System.out.println("토탈 블럭 : " + pageInfo.getTotalBlocks());
		HashMap<String, Integer> map = new HashMap<>();
		map.put("begin", startRow);
		map.put("end", endRow);
		return map;
	}
	
	private String getFileName(Part part){
		// 파일 이름을 저장할 변수 선언
		String fileName = "";
		String header = part.getHeader("content-disposition");
		String[] elements = header.split(";");
		for(String e : elements){
			// filename으로 시작하는 elements 를 찾으면 거기에서
			// "=" 다음의 문자열, fileName만 저장한다.
			// 아래의 것들은 이미 ; 으로 스플릿 했다.
			// form-data; name="file"; filename="result.PNG" 헤더정보
			if(e.trim().startsWith("filename")){
				// e 라는 문자열 변수에 filename 으로 시작하는 구문이 있다면
				// = 다음의 문장만 뽑아 내기 위한 함수. substring();
				fileName = e.substring(e.indexOf("=")+1);
				System.out.println(fileName+"1");
				fileName = fileName.trim().replace("\"", "");
				System.out.println(fileName+"2");
			}
		}
		return fileName;
	}
	*/
}
