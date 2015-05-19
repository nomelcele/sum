package dto;

public class MemberVO {
	private int memnum, memauth, memmgr, memdept;
	private String memname, memaddr, mempwd, memprofile, memjob, memmail, meminmail;
	
	
	protected int getMemnum() {
		return memnum;
	}
	protected void setMemnum(int memnum) {
		this.memnum = memnum;
	}
	protected int getMemauth() {
		return memauth;
	}
	protected void setMemauth(int memauth) {
		this.memauth = memauth;
	}
	protected int getMemmgr() {
		return memmgr;
	}
	protected void setMemmgr(int memmgr) {
		this.memmgr = memmgr;
	}
	protected int getMemdept() {
		return memdept;
	}
	protected void setMemdept(int memdept) {
		this.memdept = memdept;
	}
	protected String getMemname() {
		return memname;
	}
	protected void setMemname(String memname) {
		this.memname = memname;
	}
	protected String getMemaddr() {
		return memaddr;
	}
	protected void setMemaddr(String memaddr) {
		this.memaddr = memaddr;
	}
	protected String getMempwd() {
		return mempwd;
	}
	protected void setMempwd(String mempwd) {
		this.mempwd = mempwd;
	}
	protected String getMemprofile() {
		return memprofile;
	}
	protected void setMemprofile(String memprofile) {
		this.memprofile = memprofile;
	}
	protected String getMemjob() {
		return memjob;
	}
	protected void setMemjob(String memjob) {
		this.memjob = memjob;
	}
	protected String getMemmail() {
		return memmail;
	}
	protected void setMemmail(String memmail) {
		this.memmail = memmail;
	}
	protected String getMeminmail() {
		return meminmail;
	}
	protected void setMeminmail(String meminmail) {
		this.meminmail = meminmail;
	}
}
