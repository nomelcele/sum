package com.sumware.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;

import com.sumware.dto.MemberVO;


public class SendEmail {
	private  static SendEmail sendemail;

	public static synchronized SendEmail getSendemail() {
		if(sendemail == null) sendemail = new SendEmail();
		return sendemail;
	}




	public int sendEmailToNewMem(MemberVO mvo) throws IOException{
		
		System.out.print(mvo.getMemmail());
		String sender = "rlawntkd89@naver.com";
		String receiver = mvo.getMemmail();
		String subject = "신입 사원 로그인 정보입니다.";
		String content = mvo.getMemname()+"님의 사원번호는 "+mvo.getMemnum()+", 비밀번호는 "
		+mvo.getMempwd()+", 부서는 "+mvo.getDename()+", 상급자는 "+mvo.getMgrname()+" 입니다.";
		
		//정보를 담기 위한 객체
		Properties p = new Properties();
		
		//SMTP 서버의 계정 설정
		//Naver와 연결할 경우 네이버 아이디 지정
		//Google과 연결할 경우 본인의 Gmail 주소
		p.put("mail.smtp.user", "rlawntkd89");

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
//			String script = "<script type='text/javascript'>\n";
//			script += "alert('메일발송에 실패했습니다.');\n";
//			script += "history.back();\n";
//			script += "</script>";
//			out.print(script);
			System.out.println("메일 전송 실패");
			return 0;
		}

//		String script = "<script type='text/javascript'>\n";
//		script += "alert('메일발송에 성공했습니다.');\n";
//		script += "</script>";
		//script += "<meta http-equiv='refresh' content='0; url=afterAddMemberForm' />";
//		out.print(script);
		return 1;
	}
}
