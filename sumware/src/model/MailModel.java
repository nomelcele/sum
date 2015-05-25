package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyFileUp;
import util.Suggest;
import controller.ModelForward;
import dao.MailDao;
import dto.MailVO;

public class MailModel implements ModelInter{

	@Override
	public ModelForward exe(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String submod = request.getParameter("submod");
		String url = "";
		boolean method = true; // forward
		
		if(submod != null && submod.equals("mailMain")){
			url = "mail/mail.jsp";
			method = true; // forward
			
		} else if(submod != null && submod.equals("mailWriteForm")){
			url = "mail/mailWrite.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailWrite")){
			request.setCharacterEncoding("UTF-8");
			try {
				HashMap<String, String> map = MyFileUp.getFup().fileUp("attach", request);
				
				boolean res = MailDao.getDao().addMail(map); // db에 메일 정보 넣기
				System.out.println(res);
				
				if(res){
					url = "mail/mailSend.jsp"; // 메일 전송 완료 페이지
					method = true;
				}
			} catch (ServletException e) {
				e.printStackTrace();
			}
			
		} else if(submod != null && submod.equals("mailFromList")){
			// 받은 메일함
			// HashMap<String,String> map =MyMap.getMaps().getMapList(request);
			String userid = request.getParameter("userid");
			
			// 현재 로그인한 사원의 id
			ArrayList<MailVO> fromlist = MailDao.getDao().getFromMailList(userid);
			
			request.setAttribute("list", fromlist);
			request.setAttribute("tofrom", 1);
			
			url = "mail/mailList.jsp";
			method = true;
		} else if(submod != null && submod.equals("mailToList")){
			// 보낸 메일함
			// 현재 로그인한 사원의 사원 번호
			int usernum = Integer.parseInt(request.getParameter("usernum"));
			ArrayList<MailVO> tolist = MailDao.getDao().getToMailList(usernum);
			
			request.setAttribute("list", tolist);
			request.setAttribute("tofrom", 2);
			
			url = "mail/mailList.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailSug")){
			// 메일 쓰기 받는 사람에서 suggest 기능
			request.setCharacterEncoding("UTF-8");
			String key = request.getParameter("key");
			
			String[] suggests = Suggest.getSuggest().getSuggest(key);
			request.setAttribute("sugArr", suggests);
		
			System.out.println("????????");
			System.out.println("key: "+key);
			System.out.println("배열: "+suggests[0]);
			// 여기까지는 된다
			
			url = "mail/mailWrite.jsp"; // ?
			method = true;
		} else if(submod != null && submod.equals("mailDetail")){
			// 메일 상세 보기
			// 메일 번호
			int mailnum = Integer.parseInt(request.getParameter("mailnum"));
			MailVO detail = MailDao.getDao().getMailDetail(mailnum);
			
			request.setAttribute("detail", detail);
			
			url = "mail/mailDetail.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailMyList")){
			// 내게 쓴 메일함
			int usernum = Integer.parseInt(request.getParameter("usernum"));
			String userid = request.getParameter("userid");
			
			ArrayList<MailVO> mylist = MailDao.getDao().getMyMailList(usernum, userid);
			
			request.setAttribute("list", mylist);
			request.setAttribute("tofrom", 3);
			
			url = "mail/mailList.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailTrash")){
			// 휴지통
			// 휴지통에 들어갈 메일들의 번호(mailnum)을 저장한 배열
			String[] mailnums = request.getParameterValues("chk");
			int usernum = Integer.parseInt(request.getParameter("usernum"));
			String userid = request.getParameter("userid");
			ArrayList<MailVO> trashlist = MailDao.getDao().getTrashList(mailnums, usernum, userid);
			
			request.setAttribute("list", trashlist);
			
			url = "mail/mailList.jsp";
			method = true;
		}
		
		return new ModelForward(url, method);
	}

}
