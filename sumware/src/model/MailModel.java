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
			request.setAttribute("tofrom", 1);
			
			url = "mail/mailList.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailGoTrash")){
			// 메일함에서 체크박스로 삭제할 메일들 선택 후 삭제 버튼을 클릭했을 때
			// 삭제 관련 속성(mailsdelete, mailrdelete)을 변경한다.
			
			// 휴지통에 들어갈 메일들의 번호(mailnum)을 저장한 배열
			int usernum = Integer.parseInt(request.getParameter("usernum"));
			String userid = request.getParameter("userid");
			String[] mailnums = request.getParameterValues("chk");
			int tofrom = Integer.parseInt(request.getParameter("tofrom"));
			System.out.println("tofrom: "+tofrom);
			
			MailDao.getDao().updateTrash(mailnums, usernum, userid);
			
			ArrayList<MailVO> list = new ArrayList<MailVO>();
			
			switch(tofrom){
				case '1':{ // 받은 메일함에서 삭제했을 때
					list = MailDao.getDao().getFromMailList(userid);
				}
				case '2':{ // 보낸 메일함에서 삭제했을 때
					list = MailDao.getDao().getToMailList(usernum);
				}
				case '3':{ // 내게 쓴 메일함에서 삭제했을 때
					list = MailDao.getDao().getMyMailList(usernum, userid);
				}
			}
			
			request.setAttribute("list", list);
			request.setAttribute("tofrom",tofrom);
			
			url = "mail/mail.jsp";
			method = true;
		} else if(submod != null && submod.equals("mailTrashcan")){
			// 메뉴에서 휴지통을 클릭했을 때
			int usernum = Integer.parseInt(request.getParameter("usernum"));
			String userid = request.getParameter("userid");
			
			// 휴지통에서 보여줄 메일 리스트
			ArrayList<MailVO> trashlist = MailDao.getDao().getTrashList(usernum, userid);
			request.setAttribute("list", trashlist);
			request.setAttribute("tofrom", 3);
			
			url = "mail/mailList.jsp";
			method = true;
		}
		
		return new ModelForward(url, method);
	}

}
