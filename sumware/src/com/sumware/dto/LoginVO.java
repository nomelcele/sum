package com.sumware.dto;

public class LoginVO {
	private int lonum, lomem, begin, end, memdept, memauth;
	private String locheck, lostdate, loendate, memname, dename, memjob;
	
	public int getMemauth() {
		return memauth;
	}
	public void setMemauth(int memauth) {
		this.memauth = memauth;
	}
	public int getMemdept() {
		return memdept;
	}
	public void setMemdept(int memdept) {
		this.memdept = memdept;
	}
	public int getBegin() {
		return begin;
	}
	public void setBegin(int begin) {
		this.begin = begin;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getDename() {
		return dename;
	}
	public void setDename(String dename) {
		this.dename = dename;
	}
	public String getMemjob() {
		return memjob;
	}
	public void setMemjob(String memjob) {
		this.memjob = memjob;
	}
	public int getLonum() {
		return lonum;
	}
	public void setLonum(int lonum) {
		this.lonum = lonum;
	}
	public int getLomem() {
		return lomem;
	}
	public void setLomem(int lomem) {
		this.lomem = lomem;
	}
	public String getLocheck() {
		return locheck;
	}
	public void setLocheck(String locheck) {
		this.locheck = locheck;
	}
	public String getLostdate() {
		return lostdate;
	}
	public void setLostdate(String lostdate) {
		this.lostdate = lostdate;
	}
	public String getLoendate() {
		return loendate;
	}
	public void setLoendate(String loendate) {
		this.loendate = loendate;
	}
	
}
