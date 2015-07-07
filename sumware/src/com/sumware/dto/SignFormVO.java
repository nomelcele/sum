package com.sumware.dto;

public class SignFormVO {
/*sfname varchar2(20), -- 문서의 이름
 sfnum number, -- 문서종류 번호 pk
 sform CLOB,*/
	private String sfname,sform;
	private int sfnum;
	
	public String getSfname() {
		return sfname;
	}
	public void setSfname(String sfname) {
		this.sfname = sfname;
	}
	public String getSform() {
		return sform;
	}
	public void setSform(String sform) {
		this.sform = sform;
	}
	public int getSfnum() {
		return sfnum;
	}
	public void setSfnum(int sfnum) {
		this.sfnum = sfnum;
	}
	
	
}
