package com.sumware.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.sumware.dto.PageVO;

public class MyPage {
	private static MyPage mp;

	public static synchronized MyPage getMp() {
		if(mp==null){
			mp=new MyPage();
		}
		return mp;
	}
	public Map<String,Integer> pageProcess(HttpServletRequest request,int rowsPerPage,int pagesPerBlock,int etc,int totalCount,int commTotalCount){
		/*Page 처리 영역 */
		PageVO pageInfo = new PageVO();
		
		//외부에서 페이지값을 받아 오는것 부터 시작.
		//페이지당 보여질 줄수.(행)
//		int rowsPerPage = 5;
		//나눌 페이지수  
//		int pagesPerBlock = 5;
		
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		//페이지 구하는 공식.
		int currentBlock = 0;
		if(currentPage % pagesPerBlock == 0){
			currentBlock = currentPage / pagesPerBlock;
		}else{
			currentBlock = currentPage / pagesPerBlock + 1;
		}
		//현재 블록과 페이지를 구한 다음 시작페잊와 마지막페이지 : 한블록 안에 한페이지당
		//보여질 첫번째 행과 마지막 행
		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;
		
		int totalRows = 0;
		if(etc ==0){
			totalRows = totalCount;
		}else if(etc == 1){
//			int no = Integer.parseInt(request.getParameter("no"));
			totalRows = commTotalCount;
		}
		
		int totalPages = 0;
		if(totalRows % rowsPerPage == 0){
			totalPages = totalRows / rowsPerPage;
		}else{
			totalPages = totalRows / rowsPerPage + 1;
		}
		
		int totalBlocks = 0;
		if(totalPages % pagesPerBlock == 0){
			totalBlocks = totalPages / pagesPerBlock;
		}else{
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
		
		request.setAttribute("pageInfo", pageInfo);
		HashMap<String, Integer> map = new HashMap<>();
		map.put("begin", startRow);
		map.put("end", endRow);
		return map;
	}
	
}
