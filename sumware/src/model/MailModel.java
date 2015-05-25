package model;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import util.MyMap;
import util.Suggest;
import controller.ModelForward;
import dao.MailDao;
import dao.MemberDao;
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
			// 메일 작성 => map으로
			request.setCharacterEncoding("UTF-8");

			String title = request.getParameter("title"); // 메일 제목
			String content = request.getParameter("content"); // 메일 내용
			String file = "test.jpg"; // 첨부 파일
			int fromMem = Integer.parseInt(request.getParameter("fromMem")); // 메일 발신자-사원 번호(세션 통해 불러올 예정)
			//여기서 toMem이 참조하고 있는 member table의 사내 메일 주소에 저장되어있어야함.(제약조건)
			// 메일 수신자 이름
			String toMem = request.getParameter("toMem");
			// 메일 수신자 아이디(사내 메일)
			String toMemMail = MemberDao.getDao().getInMail(toMem);
			
			MailVO vo = new MailVO();
			vo.setMailtitle(title);
			vo.setMailcont(content);
			vo.setMailfile(file);
			vo.setMailmem(fromMem);
			vo.setMailreceiver(toMemMail);

			boolean res = MailDao.getDao().addMail(vo); // db에 메일 정보 넣기
			
			System.out.println(res);
			
			if(res){
				url = "mail/mailSend.jsp"; // 메일 전송 완료 페이지
				method = true;
			}
		} else if(submod != null && submod.equals("mailFromList")){
			// 받은 메일함
			// System.out.println("dddddddddd");
			// HashMap<String,String> map =MyMap.getMaps().getMapList(request);
			System.out.println("??????");
			String userid = request.getParameter("userid");
//			System.out.println(userid+"???????");
			
			// 현재 로그인한 사원의 id
			ArrayList<MailVO> fromlist = MailDao.getDao().getFromMailList(userid);
			// 보낸 사람 이름 리스트
			String[] namelist = new String[fromlist.size()];
			
			for(int i=0; i<namelist.length; i++){
				int memnum = fromlist.get(i).getMailmem(); // 보낸 사람 사원 번호
				String name = MemberDao.getDao().getNameMail(memnum).getMemname();
				namelist[i] = name;
			}
			
			request.setAttribute("list", fromlist);
			request.setAttribute("tofrom", 1);
			request.setAttribute("name", namelist);
			
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
			
			System.out.println("aaaaaaaaaaaaaaaaaaaaa");
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
			int mailnum = Integer.parseInt(request.getParameter("mailnum"));
			MailVO detail = MailDao.getDao().getMailDetail(mailnum);
			
			// 보낸 사람 이름
			String sender = MemberDao.getDao().getNameMail(detail.getMailmem()).getMemname();
			
			request.setAttribute("detail", detail);
			request.setAttribute("sender", sender);
			
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
			
		} else if(submod != null && submod.equals("mailCk")){
			// 체크에디터
			
		}
				
		return new ModelForward(url, method);
	}

}
