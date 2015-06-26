package com.sumware.dto;

public class CalendarVO {
	private int calnum, caldept, calmem;
	// List에서 cal은 부서텝을 선택했는지 사원텝을 선택했는지 구분한다.
	private String calstart, calend, calcont,selCal,cal;
	
	

	public String getCal() {
		return cal;
	}
	public void setCal(String cal) {
		this.cal = cal;
	}
	public String getSelCal() {
		return selCal;
	}
	public void setSelCal(String selCal) {
		this.selCal = selCal;
	}

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
