package com.sumware.dto;

import org.hibernate.validator.constraints.NotEmpty;

import com.sumware.valid.custom.MailReceiver;

public class ValidMailVO {
	@NotEmpty
	@MailReceiver
	private String mailreceiver;
	@NotEmpty
	private String mailtitle;
	
	public String getMailreceiver() {
		return mailreceiver;
	}

	public void setMailreceiver(String mailreceiver) {
		this.mailreceiver = mailreceiver;
	}

	public String getMailtitle() {
		return mailtitle;
	}

	public void setMailtitle(String mailtitle) {
		this.mailtitle = mailtitle;
	}
	
	
}
