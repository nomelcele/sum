package com.sumware.dto;

public class CommissionVO {
	/*comdetail VARCHAR2(50), -- 커시면 내역
    comamount number(9), -- 커미션 금액
    comnum NUMBER(10), -- 지급번호는 payhistory 의 hisnum 을 fk*/
	private String comdetail;
	private int comamount,comnum;
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
