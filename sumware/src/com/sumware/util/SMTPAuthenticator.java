package com.sumware.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication("rlawntkd89@naver.com","hieverybody");
	}

}
