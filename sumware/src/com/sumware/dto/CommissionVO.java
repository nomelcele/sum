package com.sumware.dto;

public class CommissionVO {
	/*comdetail VARCHAR2(50), -- 커시면 내역
    comamount number(9), -- 커미션 금액
    comdate date -- 지급 받은 날짜
    commem number(5) -- 지급받은 사원
    comnum NUMBER(10), -- 지급번호*/
	private String comdetail, comdate, memname;
	private int comamount,comnum, commem, comsum;
	
	
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public int getComsum() {
		return comsum;
	}
	public void setComsum(int comsum) {
		this.comsum = comsum;
	}
	public String getComdate() {
		return comdate;
	}
	public void setComdate(String comdate) {
		this.comdate = comdate;
	}
	public int getCommem() {
		return commem;
	}
	public void setCommem(int commem) {
		this.commem = commem;
	}
	public String getComdetail() {
		return comdetail;
	}
	public void setComdetail(String comdetail) {
		this.comdetail = comdetail;
	}
	public int getComamount() {
		return comamount;
	}
	public void setComamount(int comamount) {
		this.comamount = comamount;
	}
	public int getComnum() {
		return comnum;
	}
	public void setComnum(int comnum) {
		this.comnum = comnum;
	}
}
