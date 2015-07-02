package com.sumware.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication("joosang0904@naver.com","hieverybody");
	}

}
