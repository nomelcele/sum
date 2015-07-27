package com.sumware.dto;

public class SignStepVO {
/*stepnum number, -- 결재 고유번호 pk
 stepsnum number, -- 문서 고유번호 fk
 stepmemnum NUMBER(5), -- 결재자들의 사번 fk
 stepconfirm varchar2(1), -- 결재 여부
 */
	private int stepnum,stepsnum,stepmemnum;
	private String stepconfirm,memsignimg;
	
	public String getMemsignimg() {
		return memsignimg;
	}
	public void setMemsignimg(String memsignimg) {
		this.memsignimg = memsignimg;
	}
	public int getStepnum() {
		return stepnum;
	}
	public void setStepnum(int stepnum) {
		this.stepnum = stepnum;
	}
	public int getStepsnum() {
		return stepsnum;
	}
	public void setStepsnum(int stepsnum) {
		this.stepsnum = stepsnum;
	}
	public int getStepmemnum() {
		return stepmemnum;
	}
	public void setStepmemnum(int stepmemnum) {
		this.stepmemnum = stepmemnum;
	}
	public String getStepconfirm() {
		return stepconfirm;
	}
	public void setStepconfirm(String stepconfirm) {
		this.stepconfirm = stepconfirm;
	}
	
}
