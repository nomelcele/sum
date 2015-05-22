package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import util.MyMap;
import controller.ModelForward;
import dao.BoardDao;
import dto.BoardVO;
import dto.PageVO;

public class BoardModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String url = "";
		boolean method = false;
		String submod = request.getParameter("submod");
		System.out.println("BoardModel[submod] : "+submod);
		if(submod.equals("boardList") && submod!=null){
			/* Page 처리 영역 */
			// 들어온 요청은 boardList 를 보여주는 것, 그렇다면 1페이지 부터 보여줘야 한다.
			// 두번쨰 인자값은 게시물인지, 댓글인지를 구별 해주는 인자. 0이면 게시물~
			Map<String, Integer> map = pageProcess(request, 0);
			ArrayList<BoardVO> list = BoardDao.getDao().getList(map);
			request.setAttribute("list", list);
			for(BoardVO e : list){
				System.out.println(e.getBwriter());
			}
			request.setAttribute("list", list);
			url = "board/boardList.jsp";
			method = true;
		}else if(submod != null && submod.equals("writeForm")){
			url="board/boardWrite.jsp";
			method=true;
		}else if(submod.equals("boardInsert") && submod!=null){
			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
			BoardDao.getDao().insert(map);
			url = "sumware?model=board&submod=boardList&page=1";
			method = false; // redirect
		}else if(submod != null && submod.equals("boardDetail")){
			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
			ArrayList<BoardVO> list = BoardDao.getDao().getDetail(map);
			HttpSession ses = request.getSession();
			ses.setAttribute("list", list);
			url = "board/boardDetail.jsp";
			method = true;
			
		}else if(submod != null && submod.equals("ckBoard")){
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
				part.write(fileName+"_"+System.currentTimeMillis());
			}
			// chk callback 설정 : Ajax 로 넘어온 요청을 response 해주기 위한 설정
			// CKEditorFuncNum 은 체크에디터가 사용하는 파라미터 명.
			// callback 에 필요한 구문들이 넘어 온다.
			// 체크 에디터는 이런식으로 자기만의 방식으로 전달을 했기 때문에
			// callback 을 받을때도 자기 만의 방식으로 콜백 받아야 한다. 
			// 그렇기 때문에 callback.jsp 를 따로 작성 해 준다.
			String callback = request.getParameter("CKEditorFuncNum");
			String fileUrl = "/upload"+fileName;
			HttpSession ses = request.getSession();
			ses.setAttribute("callback", callback);
			ses.setAttribute("fileUrl", fileUrl);
			url = "board/callback.jsp";
			method = false;
		}
		return new ModelForward(url, method);
	}
	
	private Map<String, Integer> pageProcess(HttpServletRequest request, int etc) {
		PageVO pageInfo = new PageVO();

		// 한페이지에 보일 게시글 갯수
		int rowsPerPage = 15;
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
			totalRows = BoardDao.getDao().getTotalCount();
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
				
				fileName = fileName.trim().replace("\"", "");
			}
		}
		return fileName;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
