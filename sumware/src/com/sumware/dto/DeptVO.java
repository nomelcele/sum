package com.sumware.dto;

public class DeptVO {
	private int denum, tcnt;
	private String dename;
	
	public int getTcnt() {
		return tcnt;
	}
	public void setTcnt(int tcnt) {
		this.tcnt = tcnt;
	}
	public int getDenum() {
		return denum;
	}
	public void setDenum(int denum) {
		this.denum = denum;
	}
	public String getDename() {
		return dename;
	}
	public void setDename(String dename) {
		this.dename = dename;
	}
}
