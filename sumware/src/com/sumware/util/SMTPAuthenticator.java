package com.sumware.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	public PasswordAuthentication getPasswordAuthentication(){
		// 보내는 메일계정 인증 부분
		return new PasswordAuthentication("rlawntkd89@naver.com","hieverybody");
	}
}
