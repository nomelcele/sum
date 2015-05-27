package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyMap;
import util.MyPage;
import controller.ModelForward;
import dao.SnsDao;
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
				outs.append(",1)'>댓글</a>");
				outs.append("<hr/>");
				outs.append("<div id='wrap2'");
				outs.append("</div>");
				outs.append("</li>");
			}
			outs.append("\n\n");
			request.setAttribute("outs", outs);
			
			url="todo/snsLoad_push.jsp";
			method=true;
			
		}else if(submod!=null&&submod.equals("snsComm")){
			System.out.println("댓글보려구???");
			int rowsPerPage=5;
			int pagesPerBlock=5;
			int etc = 1;
			int commTotalCount=0;
			
			int snum = Integer.parseInt(request.getParameter("snum"));
			commTotalCount = SnsDao.getDao().snsCommTotalCount(snum);
			Map<String,Integer> map = MyPage.getMp().pageProcess(request, rowsPerPage, pagesPerBlock, etc, 0, commTotalCount);
			
		}
		
		return new ModelForward(url, method);
	}

}
