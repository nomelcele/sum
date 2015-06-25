package com.sumware.dto;

public class TodoJobVO {
	private int jobnum, jobtonum, jobmemnum;
	private String jobcont, memname, memprofile;
	
	
	
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getMemprofile() {
		return memprofile;
	}
	public void setMemprofile(String memprofile) {
		this.memprofile = memprofile;
	}
	public int getJobnum() {
		return jobnum;
	}
	public void setJobnum(int jobnum) {
		this.jobnum = jobnum;
	}
	public int getJobtonum() {
		return jobtonum;
	}
	public void setJobtonum(int jobtonum) {
		this.jobtonum = jobtonum;
	}
	public int getJobmemnum() {
		return jobmemnum;
	}
	public void setJobmemnum(int jobmemnum) {
		this.jobmemnum = jobmemnum;
	}
	public String getJobcont() {
		return jobcont;
	}
	public void setJobcont(String jobcont) {
		this.jobcont = jobcont;
	}
	
	
};
