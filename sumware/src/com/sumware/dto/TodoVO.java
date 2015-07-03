package com.sumware.dto;

import org.springframework.web.multipart.MultipartFile;

public class TodoVO {
	private int torownum,tonum, todept, tomem;
	//memname : manager 이름
	private String memname, tostdate, toendate, totitle, tocont, tofile,toconfirm, tocomm;
	private MultipartFile mfile;
	
	
	
	public MultipartFile getMfile() {
		return mfile;
	}
	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}
	public synchronized String getMemname() {
		return memname;
	}
	public synchronized void setMemname(String memname) {
		this.memname = memname;
	}
	public int getTorownum() {
		return torownum;
	}
	public void setTorownum(int torownum) {
		this.torownum = torownum;
	}
	public String getTocomm() {
		return tocomm;
	}
	public void setTocomm(String tocomm) {
		this.tocomm = tocomm;
	}
	public String getToconfirm() {
		return toconfirm;
	}
	public void setToconfirm(String toconfirm) {
		this.toconfirm = toconfirm;
	}
	public int getTonum() {
		return tonum;
	}
	public void setTonum(int tonum) {
		this.tonum = tonum;
	}
	public int getTodept() {
		return todept;
	}
	public void setTodept(int todept) {
		this.todept = todept;
	}
	public int getTomem() {
		return tomem;
	}
	public void setTomem(int tomem) {
		this.tomem = tomem;
	}
	public String getTostdate() {
		return tostdate;
	}
	public void setTostdate(String tostdate) {
		this.tostdate = tostdate;
	}
	public String getToendate() {
		return toendate;
	}
	public void setToendate(String toendate) {
		this.toendate = toendate;
	}
	public String getTotitle() {
		return totitle;
	}
	public void setTotitle(String totitle) {
		this.totitle = totitle;
	}
	public String getTocont() {
		return tocont;
	}
	public void setTocont(String tocont) {
		this.tocont = tocont;
	}
	public String getTofile() {
		return tofile;
	}
	public void setTofile(String tofile) {
		this.tofile = tofile;
	}
}
