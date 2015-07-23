package com.sumware.dto;

public class MemberVO {
	private int memnum, memauth, memmgr, memdept,begin,end, salstprice, salenprice;
	private String memname, memaddr, mempwd, memprofile, memjob, memmail, meminmail, dename, mgrname, 
	memhire, memresign, membirth, memsignimg, pyearly, psalary, hiredstdate, hiredendate;
	private String imgchange;//기존 회원이 이미지를 변경 했는지 판단
	
	
	public String getImgchange() {
		return imgchange;
	}
	public void setImgchange(String imgchange) {
		this.imgchange = imgchange;
	}
	public int getSalstprice() {
		return salstprice;
	}
	public void setSalstprice(int salstprice) {
		this.salstprice = salstprice;
	}
	public int getSalenprice() {
		return salenprice;
	}
	public void setSalenprice(int salenprice) {
		this.salenprice = salenprice;
	}
	public String getHiredstdate() {
		return hiredstdate;
	}
	public void setHiredstdate(String hiredstdate) {
		this.hiredstdate = hiredstdate;
	}
	public String getHiredendate() {
		return hiredendate;
	}
	public void setHiredendate(String hiredendate) {
		this.hiredendate = hiredendate;
	}
	public String getPyearly() {
		return pyearly;
	}
	public void setPyearly(String pyearly) {
		this.pyearly = pyearly;
	}
	public String getPsalary() {
		return psalary;
	}
	public void setPsalary(String psalary) {
		this.psalary = psalary;
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
	public String getMemhire() {
		return memhire;
	}
	public void setMemhire(String memhire) {
		this.memhire = memhire;
	}
	public String getMemresign() {
		return memresign;
	}
	public void setMemresign(String memresign) {
		this.memresign = memresign;
	}
	public String getMembirth() {
		return membirth;
	}
	public void setMembirth(String membirth) {
		this.membirth = membirth;
	}
	public String getMemsignimg() {
		return memsignimg;
	}
	public void setMemsignimg(String memsignimg) {
		this.memsignimg = memsignimg;
	}
	public String getMgrname() {
		return mgrname;
	}
	public void setMgrname(String mgrname) {
		this.mgrname = mgrname;
	}
	public String getDename() {
		return dename;
	}
	public void setDename(String dename) {
		this.dename = dename;
	}
	public int getMemnum() {
		return memnum;
	}
	public void setMemnum(int memnum) {
		this.memnum = memnum;
	}
	public int getMemauth() {
		return memauth;
	}
	public void setMemauth(int memauth) {
		this.memauth = memauth;
	}
	public int getMemmgr() {
		return memmgr;
	}
	public void setMemmgr(int memmgr) {
		this.memmgr = memmgr;
	}
	public int getMemdept() {
		return memdept;
	}
	public void setMemdept(int memdept) {
		this.memdept = memdept;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getMemaddr() {
		return memaddr;
	}
	public void setMemaddr(String memaddr) {
		this.memaddr = memaddr;
	}
	public String getMempwd() {
		return mempwd;
	}
	public void setMempwd(String mempwd) {
		this.mempwd = mempwd;
	}
	public String getMemprofile() {
		return memprofile;
	}
	public void setMemprofile(String memprofile) {
		this.memprofile = memprofile;
	}
	public String getMemjob() {
		return memjob;
	}
	public void setMemjob(String memjob) {
		this.memjob = memjob;
	}
	public String getMemmail() {
		return memmail;
	}
	public void setMemmail(String memmail) {
		this.memmail = memmail;
	}
	public String getMeminmail() {
		return meminmail;
	}
	public void setMeminmail(String meminmail) {
		this.meminmail = meminmail;
	}
	
	
}
