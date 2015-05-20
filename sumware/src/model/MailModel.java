package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyMap;
import controller.ModelForward;
import dao.MailDao;
import dto.MailVO;

public class MailModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String submod = request.getParameter("submod");
		String url = "";
		boolean method = false;
		
		if(submod != null && submod.equals("mailMain")){
			url = "MailMain.jsp";
		} else if(submod != null && submod.equals("mailWrite")){
			// 메일 작성
			request.setCharacterEncoding("UTF-8");

			String title = request.getParameter("title"); // 메일 제목
			String content = request.getParameter("content"); // 메일 내용
			String file = "test.jpg"; // 첨부 파일
			int fromMem = Integer.parseInt(request.getParameter("fromMem")); // 메일 발신자-사원 번호(세션 통해 불러올 예정)
			//여기서 toMem이 참조하고 있는 member table의 사내 메일 주소에 저장되어있어야함.(제약조건)
			String toMem = request.getParameter("toMem");
			// 메일 수신자-메일 주소(아이디)
			
			MailVO vo = new MailVO();
			vo.setMailtitle(title);
			vo.setMailcont(content);
			vo.setMailfile(file);
			vo.setMailmem(fromMem);
			vo.setMailreceiver(toMem);

			boolean res = MailDao.getDao().addMail(vo); // db에 메일 정보 넣기
			
			if(res){
				url = "MailMain.jsp";
				method = true;
			}
		} else if(submod != null && submod.equals("mailList")){
			// 받은 메일함
			System.out.println("dddddddddd");
			HashMap<String,String> map =MyMap.getMaps().getMapList(request);
//			String userid = request.getParameter("userid");
//			System.out.println(userid+"???????");
			
			// 현재 로그인한 사원의 id
			ArrayList<MailVO> mlist = MailDao.getDao().getMailList(map.get("userid"));
			
			
			
			request.setAttribute("list", mlist);
			
			url = "MailList.jsp";
			method = false;
		}
				
		return new ModelForward(url, method);
	}

}
