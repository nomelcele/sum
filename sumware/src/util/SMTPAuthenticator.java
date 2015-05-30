package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication("jinjo820925@naver.com","sumware0530");
	}

}
