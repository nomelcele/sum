package com.sumware.dto;

public class CalendarVO {
	private int calnum, caldept, calmem;
	private String calstart, calend, calcont;
	
	public int getCalnum() {
		return calnum;
	}
	public void setCalnum(int calnum) {
		this.calnum = calnum;
	}
	public int getCaldept() {
		return caldept;
	}
	public void setCaldept(int caldept) {
		this.caldept = caldept;
	}
	public int getCalmem() {
		return calmem;
	}
	public void setCalmem(int calmem) {
		this.calmem = calmem;
	}
	public String getCalstart() {
		return calstart;
	}
	public void setCalstart(String calstart) {
		this.calstart = calstart;
	}
	public String getCalend() {
		return calend;
	}
	public void setCalend(String calend) {
		this.calend = calend;
	}
	public String getCalcont() {
		return calcont;
	}
	public void setCalcont(String calcont) {
		this.calcont = calcont;
	}
}
