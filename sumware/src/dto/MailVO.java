package dto;

public class MailVO {
	private int mailnum, mailmem;
	private String mailtitle, mailcont, mailfile, mailreceiver;
	
	protected int getMailnum() {
		return mailnum;
	}
	protected void setMailnum(int mailnum) {
		this.mailnum = mailnum;
	}
	protected int getMailmem() {
		return mailmem;
	}
	protected void setMailmem(int mailmem) {
		this.mailmem = mailmem;
	}
	protected String getMailtitle() {
		return mailtitle;
	}
	protected void setMailtitle(String mailtitle) {
		this.mailtitle = mailtitle;
	}
	protected String getMailcont() {
		return mailcont;
	}
	protected void setMailcont(String mailcont) {
		this.mailcont = mailcont;
	}
	protected String getMailfile() {
		return mailfile;
	}
	protected void setMailfile(String mailfile) {
		this.mailfile = mailfile;
	}
	protected String getMailreceiver() {
		return mailreceiver;
	}
	protected void setMailreceiver(String mailreceiver) {
		this.mailreceiver = mailreceiver;
	}
	
	
}
