package model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyMap;
import util.MyPage;
import controller.ModelForward;
import dao.SnsDao;
import dto.CommVO;
import dto.SnsVO;

public class SnsModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String url="";
		boolean method=false;
		
		String submod=request.getParameter("submod");
		System.out.println("snsModel submod:"+submod);
		
		if(submod!=null&&submod.equals("insertSns")){
			HashMap<String,String> map =MyMap.getMaps().getMapList(request);
			SnsDao.getDao().insertSns(map);
		}else if(submod!=null&&submod.equals("pushSns")){
			int rowsPerPage=Integer.parseInt(request.getParameter("rowsPerPage"));
			int pagesPerBlock=1;
			System.out.println("rowperpage::::::::::"+rowsPerPage);
			int totalCount=0;
			int etc = 0;
			int commTotalCount=0;
			
			int sdept = Integer.parseInt(request.getParameter("sdept"));
			totalCount=SnsDao.getDao().snsTotalCount(sdept);
			Map<String, Integer> map = MyPage.getMp().pageProcess(request,rowsPerPage,pagesPerBlock,etc, totalCount, commTotalCount);
			map.put("sdept", sdept);
			
			ArrayList<SnsVO> snsList = SnsDao.getDao().getList(map);
			StringBuffer outs = new StringBuffer();
			outs.append("retry:2000\n");
			outs.append("data:");
			for(SnsVO v : snsList){
				outs.append("<li class='left clearfix'>");
				outs.append("<span class='chat-img pull-left'>");
				outs.append("<img src='profileImg/");
				outs.append(v.getSmemprofile());
				outs.append("' alt='User Avatar' class='img-circle' style='width: 60px; height: 70px;'>");
				outs.append("</span>");
				outs.append("<div class='chat-body clearfix' style='height:100px;'>");
				outs.append("<div class='header'>");
				outs.append("<strong class='primary-font'>");
				outs.append(v.getSmemname());
				outs.append("</strong>");				
				outs.append("<small	class='pull-right text-muted'> <i class='fa fa-clock-o fa-fw'></i>");
				outs.append(v.getSdate());
				outs.append("</small>");
				outs.append("</div>");
				outs.append("<div>");
				outs.append("<p>").append(v.getScont()).append("</p>");
				outs.append("<a href='javascript:snsComm(");
				outs.append(v.getSnum());
				outs.append(")'>댓글(").append(v.getStocount());
				outs.append(")</a>");
				outs.append("<hr/>");
				outs.append("</li>");
			}
			outs.append("\n\n");
			
			request.setAttribute("outs", outs);
			
//			response.setContentType("text/html; charset=UTF-8");
//			response.setHeader("cache-control", "no-cache");
//			response.setContentType("text/event-stream");
//			PrintWriter push = response.getWriter();
//			push.write(outs.toString());
//			push.flush();
//			
			url="todo/snsLoad_push.jsp";
			method=true;
			
			
		}else if(submod!=null&&submod.equals("snsComm")){
			System.out.println("댓글보려구???");
			
			showCommList(request);
			url="todo/snsComm.jsp";
			method=true;
		}else if(submod!=null&&submod.equals("snsCommInset")){
			System.out.println("댓글을 입력하자~!");
			Map<String, String> map = MyMap.getMaps().getMapList(request);
			SnsDao.getDao().inssertSnsComm(map);
			
			//--리스트 받아오기
			showCommList(request);
			//--리스트 받아오기끝
			url="todo/snsComm.jsp";
			method=true;
		}else if(submod!=null&&submod.equals("snsCommDelete")){
			System.out.println("삭제를 해보자");
			Map<String,String> map = MyMap.getMaps().getMapList(request);
			SnsDao.getDao().snsCommDelete(map);
			showCommList(request);
			url="todo/snsComm.jsp";
			method=true;
		}
		
		return new ModelForward(url, method);
	}
	private void showCommList(HttpServletRequest request){
		int rowsPerPage=Integer.parseInt(request.getParameter("rowsPerPage"));
		int pagesPerBlock=1;
		int etc = 1;
		int commTotalCount=0;
		
		int snum = Integer.parseInt(request.getParameter("snum"));
		commTotalCount = SnsDao.getDao().snsCommTotalCount(snum);
		Map<String,Integer> map = MyPage.getMp().pageProcess(request, rowsPerPage, pagesPerBlock, etc, 0, commTotalCount);
		map.put("commsns", snum);
		ArrayList<CommVO> commSnsList = SnsDao.getDao().getCommList(map);
	
		request.setAttribute("commSnsList", commSnsList);
		request.setAttribute("commsns", snum);
	}

}
