package com.sumware.dto;

import org.hibernate.validator.constraints.NotEmpty;

public class ValidMailVO {
	@NotEmpty
	private String mailreceiver;

	public String getMailreceiver() {
		return mailreceiver;
	}

	public void setMailreceiver(String mailreceiver) {
		this.mailreceiver = mailreceiver;
	}
	
}
