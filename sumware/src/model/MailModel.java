package model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyFileUp;
import util.MyMap;
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
		
		// 로그인한 사원의 사원 번호와 아이디(사내 메일)
		int usernum = Integer.parseInt(request.getParameter("usernum"));
		String userid = request.getParameter("userid");
				
//		if(submod != null && submod.equals("mailMain")){
//			url = "sumware?model=mail&submod=mailFromList";
//			method = true; // forward
//			
	    if(submod != null && submod.equals("mailWriteForm")){
			String toMem = request.getParameter("toMem");
			String mailtitle = request.getParameter("mailtitle");
			
			if(toMem != null){
				System.out.println("toMem: "+toMem);
				request.setAttribute("toMem", toMem);
				request.setAttribute("mailtitle", mailtitle);
			}
			
			url = "mail/mailWrite.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailWrite")){
			System.out.println("현재 submod: mailWrite");
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
			System.out.println("현재 submod: mailFromList");
			// 받은 메일함
			// HashMap<String,String> map =MyMap.getMaps().getMapList(request);
//			int usernum = Integer.parseInt(request.getParameter("usernum"));
//			String userid = request.getParameter("userid");
			
			// 현재 로그인한 사원의 id
			ArrayList<MailVO> fromlist = MailDao.getDao().getFromMailList(usernum,userid);
			
			request.setAttribute("list", fromlist);
			request.setAttribute("tofrom", 1);
			
			url = "mail/mailList.jsp";
			method = true;
		} else if(submod != null && submod.equals("mailToList")){
			System.out.println("현재 submod: mailToList");
			// 보낸 메일함
			// 현재 로그인한 사원의 사원 번호
//			int usernum = Integer.parseInt(request.getParameter("usernum"));
//			String userid = request.getParameter("userid");
			ArrayList<MailVO> tolist = MailDao.getDao().getToMailList(usernum,userid);
			
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
			StringBuilder su = new StringBuilder();
			su.append("[");
			if(suggests != null){
				for(int i=0; i<suggests.length; i++){
					su.append("\"");
					su.append(suggests[i]);
					su.append("\"");
					if(!(i == suggests.length-1)){
						su.append(",");
					}		
				}
			}
			su.append("]");
			request.setAttribute("sug", su.toString());
//			PrintWriter pw = response.getWriter();
//			pw.write(su.toString());
//			pw.flush();
			
			url = "mail/mailSuggest.jsp";
			method = true;
		} else if(submod != null && submod.equals("mailDetail")){
			// 메일 상세 보기
			// 메일 번호
			System.out.println("현재 submod: mailDetail");
			int mailnum = Integer.parseInt(request.getParameter("mailnum"));
			
			MailVO detail = MailDao.getDao().getMailDetail(mailnum);
			
			request.setAttribute("detail", detail);
			
			url = "mail/mailDetail.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailMyList")){
			System.out.println("현재 submod: mailMyList");
			// 내게 쓴 메일함
//			int usernum = Integer.parseInt(request.getParameter("usernum"));
//			String userid = request.getParameter("userid");
			
			ArrayList<MailVO> mylist = MailDao.getDao().getMyMailList(usernum, userid);
			
			request.setAttribute("list", mylist);
			request.setAttribute("tofrom", 3);
			
			url = "mail/mailList.jsp";
			method = true;
			
		} else if(submod != null && submod.equals("mailTrashcan")){
			System.out.println("현재 submod: mailTrashList");
			// 메뉴에서 휴지통을 클릭했을 때
//			int usernum = Integer.parseInt(request.getParameter("usernum"));
//			String userid = request.getParameter("userid");
			
			// 휴지통에서 보여줄 메일 리스트
			ArrayList<MailVO> trashlist = MailDao.getDao().getTrashList(usernum, userid);
			request.setAttribute("list", trashlist);
			request.setAttribute("tofrom", 4);
			
			url = "mail/mailList.jsp";
			method = true;
		}  else if(submod != null && submod.equals("mailSetDel")){
			// 메일 테이블의 delete 속성 설정
			System.out.println("현재 submod: mailSetDel");
//			int usernum = Integer.parseInt(request.getParameter("usernum"));
//			String userid = request.getParameter("userid");
			String[] mailnums = request.getParameterValues("chk");
			mailnums[0]=mailnums[0].substring(mailnums[0].indexOf("=")+1);
			for(String e:mailnums){
				System.out.println("선택된 메일 번호: "+e);
			}
			
			int delvalue = Integer.parseInt(request.getParameter("delvalue"));
			int tofrom = Integer.parseInt(request.getParameter("tofrom"));
			System.out.println("mailSetDel=="+tofrom);
			
			MailDao.getDao().setDeleteAttr(mailnums, usernum, userid, delvalue);
			// 받은 사람과 보낸 사람이 모두 영구 삭제한 메일을 db에서 삭제하기 위한 메서드
			// MailDao.getDao().delMailFromDB(); 
			ArrayList<MailVO> list = new ArrayList<MailVO>();
			
			switch(tofrom){
				case 1: // 받은 메일함
					System.out.println("받은메일함 갈꺼야");
					list = MailDao.getDao().getFromMailList(usernum,userid);
					break;
				case 2: // 보낸 메일함
					System.out.println("보낸메일함 고고");
					list = MailDao.getDao().getToMailList(usernum,userid);
					break;
				case 3: // 내게 쓴 메일함
					System.out.println("내게쓴메일함 고고");
					list = MailDao.getDao().getMyMailList(usernum, userid);
					break;
				case 4: // 휴지통
					System.out.println("휴지통 고고");
					list = MailDao.getDao().getTrashList(usernum, userid);
					break;
			}
			
		    request.setAttribute("list", list);
			request.setAttribute("tofrom", tofrom);
			
			url = "mail/mailList.jsp";
			method = true;
		}
	    
	    // 왼쪽 메뉴에서 각 메일함에 있는 메일의 갯수를 보여주기 위한 메서드 호출
	 	int[] numArr = MailDao.getDao().getListNum(usernum, userid);
	 	for(int e:numArr){
	 		System.out.println("메일 갯수: "+e);
	 	}
	 	request.setAttribute("numArr", numArr);
		
		return new ModelForward(url, method);
	}

}
