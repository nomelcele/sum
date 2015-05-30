<%@page import="dto.MemberVO"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="util.SMTPAuthenticator"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberVO vo = (MemberVO) request.getAttribute("newmemVo");
	System.out.print(vo.getMemmail());
	String sender = "jinjo820925@naver.com";
	String receiver = vo.getMemmail();
	String subject = "신입 사원 로그인 정보입니다.";
	String content = vo.getMemname()+"님의 사원번호는 "+vo.getMemnum()+", 비밀번호는 "
	+vo.getMempwd()+", 부서는 "+vo.getDename()+", 상급자는 "+vo.getMgrname()+" 입니다.";

	//정보를 담기 위한 객체
	Properties p = new Properties();
	
	//SMTP 서버의 계정 설정
	//Naver와 연결할 경우 네이버 아이디 지정
	//Google과 연결할 경우 본인의 Gmail 주소
	p.put("mail.smtp.user", "jinjo820925");

	//SMTP 서버 정보 설정
	//네이버일 경우 smtp.naver.com
	//Google일 경우 smtp.gmail.com
	p.put("mail.smtp.host", "smtp.naver.com");

	//아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class",
			"javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	try {
		
		Authenticator auth = new SMTPAuthenticator();
		
		Session ses = Session.getInstance(p, auth);
		
		// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
		ses.setDebug(true);

		// 메일의 내용을 담기 위한 객체
		MimeMessage msg = new MimeMessage(ses);
		
		// 제목 설정
		msg.setSubject(subject);

		// 보내는 사람의 메일주소
		Address fromAddr = new InternetAddress(sender);
		msg.setFrom(fromAddr);

		// 받는 사람의 메일주소
		Address toAddr = new InternetAddress(receiver);
		msg.addRecipient(Message.RecipientType.TO, toAddr);

		// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
		msg.setContent(content, "text/html;charset=UTF-8");

		// 발송하기
		Transport.send(msg);

	} catch (Exception mex) {
		mex.printStackTrace();
		String script = "<script type='text/javascript'>\n";
		script += "alert('메일발송에 실패했습니다.');\n";
		script += "history.back();\n";
		script += "</script>";
		out.print(script);
		return;
	}

	String script = "<script type='text/javascript'>\n";
	script += "alert('메일발송에 성공했습니다.');\n";
	script += "</script>";
	script += "<meta http-equiv='refresh' content='0; url=sumware?model=join&submod=addMemberForm' />";
	out.print(script);
%>