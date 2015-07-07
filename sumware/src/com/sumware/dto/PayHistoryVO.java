package com.sumware.dto;

public class PayHistoryVO {
	/*hisdate DATE, -- 급여지급 날짜
    hisamount NUMBER(11), -- 지급 금액
    hismem NUMBER(5), -- 지급 대상(사번 fk)
    hisnum NUMBER(10), -- 지급 고유 번호 pk*/
	private String hisdate;
	private int hisamount,hismem,hisnum;
	public String getHisdate() {
		return hisdate;
	}
	public void setHisdate(String hisdate) {
		this.hisdate = hisdate;
	}
	public int getHisamount() {
		return hisamount;
	}
	public void setHisamount(int hisamount) {
		this.hisamount = hisamount;
	}
	public int getHismem() {
		return hismem;
	}
	public void setHismem(int hismem) {
		this.hismem = hismem;
	}
	public int getHisnum() {
		return hisnum;
	}
	public void setHisnum(int hisnum) {
		this.hisnum = hisnum;
	}
	
	
}
