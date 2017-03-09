package com.sumware.dto;

import org.hibernate.validator.constraints.NotEmpty;

import com.sumware.valid.custom.MailReceiver;

public class ValidMailVO {
	// 메일 작성 form에서 입력한 데이터 중 유효성 검사 대상이 되는 데이터들(받는 사람, 제목)
	
	// @NotEmpty: 해당 값이 비어 있는지를 확인
	// @MailReceiver: 커스터마이징한 어노테이션
	// 메일 작성 시 받는 사람: 사원 이름<아이디@sumware.com>
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
