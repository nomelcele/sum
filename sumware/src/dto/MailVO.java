package dto;

public class MailVO {
	private int mailnum, mailmem;
	private String mailtitle, mailcont, mailfile, mailreceiver, maildate;
	
	public int getMailnum() {
		return mailnum;
	}
	public void setMailnum(int mailnum) {
		this.mailnum = mailnum;
	}
	public int getMailmem() {
		return mailmem;
	}
	public void setMailmem(int mailmem) {
		this.mailmem = mailmem;
	}
	public String getMailtitle() {
		return mailtitle;
	}
	public void setMailtitle(String mailtitle) {
		this.mailtitle = mailtitle;
	}
	public String getMailcont() {
		return mailcont;
	}
	public void setMailcont(String mailcont) {
		this.mailcont = mailcont;
	}
	public String getMailfile() {
		return mailfile;
	}
	public void setMailfile(String mailfile) {
		this.mailfile = mailfile;
	}
	public String getMailreceiver() {
		return mailreceiver;
	}
	public void setMailreceiver(String mailreceiver) {
		this.mailreceiver = mailreceiver;
	}
	public String getMaildate() {
		return maildate;
	}
	public void setMaildate(String maildate) {
		this.maildate = maildate;
	}
	
}
