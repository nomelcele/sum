package com.sumware.mvc.model;
import java.io.IOException;
import java.io.PrintWriter;
import javax.jws.WebParam.Mode;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.MemberDao;
import com.sumware.util.CaptchasDotNet;


@Controller
public class JoinModel{
	
	@Autowired
	private MemberDao mdao;
	
	

	@RequestMapping(value="/memberForm")
	public String memberForm(){
		return "join/member";	
	}
	
	@RequestMapping(value="/joinck")
	public void joinCk(String meminmail,HttpServletResponse response) throws IOException{
		int res = mdao.ckid(meminmail);
		
		PrintWriter pw = response.getWriter();
		if(res==1){
			pw.write("<p>사용 불가능한 아이디입니다.</p>");
			pw.flush();
	
		}else{
			pw.write("<p>사용 가능한 아이디입니다.</p>");
			pw.flush();
		}
	}
	
	@RequestMapping(value="/signup")
	public String signup(MemberVO mvo, HttpSession session){
	
	    mdao.update(mvo);
	    //모든 세션 정보를 삭제함 ...
		session.invalidate();	
		return "home/index";	
	}
	
	@RequestMapping(value="/viewCap",method=RequestMethod.POST)
	public String viewCap(HttpServletRequest request){
		// Construct the captchas object
		// Use same settings as in query.jsp
		CaptchasDotNet captchas = new com.sumware.util.CaptchasDotNet(
				request.getSession(true), // Ensure session
				"jtrip", // client
				"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
		);
		// Read the form values
		String id =request.getParameter("id");
		String pw =request.getParameter("pw");
		String password = request.getParameter("password");
		System.out.println("cappwd "+password);
		// Check captcha
		String body;
		switch (captchas.check(password)) {
		case 's':
			body = "Session seems to be timed out or broken. ";
			body += "Please try again or report error to administrator.";
			break;
		case 'm':
			body = "Every CAPTCHA can only be used once. ";
			body += "The current CAPTCHA has already been used. ";
			body += "Please use back button and reload";
			break;
		case 'w':
			body = "You entered the wrong password. ";
			body += "Please use back button and try again. ";
			break;
		    default:
			body = "ok";
			
			break;
		}
		System.out.println("aa : " + captchas.check(password));
		request.setAttribute("body", body);
	
		return "join/cap/captcha";
		
	}
	
	
	@RequestMapping(value="/getCap",method=RequestMethod.POST)
	public String getCap(HttpServletRequest request){
		
		CaptchasDotNet captchas = new com.sumware.util.CaptchasDotNet(
				request.getSession(true), // Ensure session
				"jtrip", // client
				"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
		);
		request.setAttribute("capImg", captchas.image());
		
		return "join/cap/getCap";
	}
	
	@RequestMapping(value="/modifyProfile",method=RequestMethod.POST)
	public String modifyProfile(Mode mode){
		//프로필 수정폼 
		return "join/member";
		
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public String modify(MemberVO mvo,HttpSession session){
		//수정 버튼 
		
		//HashMap<String, String> map= MyMap.getMaps().getMapList(request);
		
		mdao.modify(mvo);
		//session = request.getSession();
		//저장된 세션 다 날림.
		session.removeAttribute("v");
		session.removeAttribute("teamNameList");		
		return "home/index";
		
	}
	
	
	
//	@Override
//	public ModelForward exe(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//	
//		String submod= request.getParameter("submod");
//		System.out.println("join submod:::::"+submod);
//		String url="";
//		boolean method = false;
//		if(submod !=null && submod.equals("memberForm")){
//			
//			url ="join/member.jsp";
//			method=true;
//			
//		}else if(submod !=null && submod.equals("signup")){
//			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
//			MemberDao.getDao().update(map);
//
//			HttpSession session = request.getSession();
//			session.invalidate();
//			
//			url="index.jsp";
//			method=true;
	
//		}else if(submod != null && submod.equals("viewCap")){
//			// Construct the captchas object
//			// Use same settings as in query.jsp
//			CaptchasDotNet captchas = new com.sumware.util.CaptchasDotNet(
//					request.getSession(true), // Ensure session
//					"jtrip", // client
//					"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
//			);
//			// Read the form values
////			String id =request.getParameter("id");
////			String pw =request.getParameter("pw");
//			String password = request.getParameter("password");
//			System.out.println("cappwd "+password);
////			// Check captcha
//			String body;
//			switch (captchas.check(password)) {
//			case 's':
//				body = "Session seems to be timed out or broken. ";
//				body += "Please try again or report error to administrator.";
//				break;
//			case 'm':
//				body = "Every CAPTCHA can only be used once. ";
//				body += "The current CAPTCHA has already been used. ";
//				body += "Please use back button and reload";
//				break;
//			case 'w':
//				body = "You entered the wrong password. ";
//				body += "Please use back button and try again. ";
//				break;
//			default:
//				body = "ok";
//				
//				break;
//			}
//			System.out.println("aa : " + captchas.check(password));
//			request.setAttribute("body", body);
//			url="join/captcha.jsp";
//			method=true;
//		}else if(submod != null && submod.equals("getCap")){
//			CaptchasDotNet captchas = new com.sumware.util.CaptchasDotNet(
//					request.getSession(true), // Ensure session
//					"jtrip", // client
//					"3yNe6F7kItK5fHjFZtGCMey6d6PNtYfva6Uqht4i" // secret
//			);
//			request.setAttribute("capImg", captchas.image());
//			url="join/getCap.jsp";
//			method=true;
//			
//		}else if(submod !=null && submod.equals("modifyProfile")){
//			// 프로필 수정 폼
//			url="join/member.jsp";
//			method=true;
//		}else if(submod !=null && submod.equals("modify")){
//			// 수정 버튼
//			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
//			MemberDao.getDao().modify(map);
//			
//			HttpSession session = request.getSession();
//			//저장된 세션 다 날림.
//			session.removeAttribute("v");
//			session.removeAttribute("teamNameList");
//
//			url="index.jsp";
//			method = false;
//
//		}else if(submod !=null && submod.equals("addMember")) {
//			// 신입사원 추가 버튼 클릭시 추가 기능
//			HashMap<String, String> map= MyMap.getMaps().getMapList(request);
//			MemberDao.getDao().addMember(map);
//			
//			String memmail = map.get("newmail");
//			MemberVO vo = MemberDao.getDao().getNewMemInfo(memmail);
//			request.setAttribute("newmemVo", vo);
//			url = "admin/sendEmailUser.jsp";
//			method = true;
//			
//		}else if(submod !=null && submod.equals("getMemMgr")){
//			System.out.println("addMemberForm들어옴");
//			// 부서선택하면 부서에 대한 팀장들 리스트가져옴
//			int memdept = Integer.parseInt(request.getParameter("memdept"));
//			List<MemberVO> memmgrlist = MemberDao.getDao().getMemMgr(memdept);
//			request.setAttribute("mgrList", memmgrlist);
//			
//			url="admin/getMgrListCallback.jsp";
//			method = true;
//			
//		}else if(submod !=null && submod.equals("addMemberForm")){
//			url="admin/admin.jsp";
//			method = true;
//		}else if(submod != null && submod.equals("addBoard")){
//			HashMap<String, String> map = MyMap.getMaps().getMapList(request);
//			BoardDao.getDao().addBoard(map);
//			
//			url = "sumware?model=join&submod=addBoardForm";
	//      "redirect:/addBordForm"
//			method = true;
//
//		}else if(submod != null && submod.equals("addBoardForm")){
//			url = "admin/addBoard.jsp";
//			method = true;
//		}
//		
//		System.out.println("url:"+url+" method:"+method);
//		return new ModelForward(url, method);
//	}
//	
//	
//	
}


