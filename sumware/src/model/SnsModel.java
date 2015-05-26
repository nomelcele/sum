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
			int rowsPerPage=8;
			int totalCount=0;
			int etc = 0;
			int commTotalCount=0;
			
			int sdept = Integer.parseInt(request.getParameter("sdept"));
			totalCount=SnsDao.getDao().snsTotalCount(sdept);
			Map<String, Integer> map = MyPage.getMp().pageProcess(request,rowsPerPage,etc, totalCount, commTotalCount);
			map.put("sdept", sdept);
			
			ArrayList<SnsVO> snsList = SnsDao.getDao().getList(map);
			StringBuffer outs = new StringBuffer();
			outs.append("data:");
			for(SnsVO v : snsList){
				outs.append("<li class='left clearfix'>");
				outs.append("<span class='chat-img pull-left'>");
				outs.append("<img src='http://placehold.it/50/FA6F57/fff' alt='User Avatar' class='img-circle'>");
				outs.append("</span>");
				outs.append("<div class='chat-body clearfix'>");
				outs.append("<div class='header'>");
				outs.append("<strong class='primary-font'>");
				outs.append(v.getSmem());
				outs.append("</strong>");				
				outs.append("<small	class='pull-right text-muted'> <i class='fa fa-clock-o fa-fw'></i>");
				outs.append(v.getSdate());
				outs.append("</small>");
				outs.append("</div>");
				outs.append("<div>");
				outs.append("<p>").append(v.getScont()).append("</p>");
				outs.append("</div>");
				outs.append("</li>");
			}
			outs.append("\n\n");
			request.setAttribute("outs", outs);
			url="todo/snsLoad_push.jsp";
			method=true;
			
		}
		
		return new ModelForward(url, method);
	}

}