package com.sumware.dto;

public class SignatureVO {
	/*
		 snum number, -- 문서고유 번호 pk
		 formnum number, -- 문서종류 번호 fk
		 finalmemnum number, -- 최종 결재자의 사번 fk
		 nowmemnum number, -- 현재 결재자의 사번 fk
		 stitle varchar2(40), 
		 scont clob,
		 sreason clob,
		 startdate date,
		 enddate DATE,*/
	private String stitle,scont,sreason,startdate,enddate,sgwriter,sfname,memname;
	private int formnum,snum,finalmemnum,nowmemnum,sgdept;
	private int ncount,ycount;//결재 상태
	public String getStitle() {
		return stitle;
	}
	public void setStitle(String stitle) {
		this.stitle = stitle;
	}
	public String getScont() {
		return scont;
	}
	public void setScont(String scont) {
		this.scont = scont;
	}
	public String getSreason() {
		return sreason;
	}
	public void setSreason(String sreason) {
		this.sreason = sreason;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public int getFormnum() {
		return formnum;
	}
	public void setFormnum(int formnum) {
		this.formnum = formnum;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public int getFinalmemnum() {
		return finalmemnum;
	}
	public void setFinalmemnum(int finalmemnum) {
		this.finalmemnum = finalmemnum;
	}
	public int getNowmemnum() {
		return nowmemnum;
	}
	public void setNowmemnum(int nowmemnum) {
		this.nowmemnum = nowmemnum;
	}
	public String getSgwriter() {
		return sgwriter;
	}
	public void setSgwriter(String sgwriter) {
		this.sgwriter = sgwriter;
	}
	
	public int getNcount() {
		return ncount;
	}
	public void setNcount(int ncount) {
		this.ncount = ncount;
	}
	public int getYcount() {
		return ycount;
	}
	public void setYcount(int ycount) {
		this.ycount = ycount;
	}
	public int getSgdept() {
		return sgdept;
	}
	public void setSgdept(int sgdept) {
		this.sgdept = sgdept;
	}
	public String getSfname() {
		return sfname;
	}
	public void setSfname(String sfname) {
		this.sfname = sfname;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	
	
}
