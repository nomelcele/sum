package com.sumware.dto;

public class MessengerRoomVO {
	private int masnum,key;
	private String masstdate, masendate, masreip;
	
	public int getKey() {
		return key;
	}
	public void setKey(int key) {
		this.key = key;
	}
	public int getMasnum() {
		return masnum;
	}
	public void setMasnum(int masnum) {
		this.masnum = masnum;
	}
	public String getMasstdate() {
		return masstdate;
	}
	public void setMasstdate(String masstdate) {
		this.masstdate = masstdate;
	}
	public String getMasendate() {
		return masendate;
	}
	public void setMasendate(String masendate) {
		this.masendate = masendate;
	}
	public String getMasreip() {
		return masreip;
	}
	public void setMasreip(String masreip) {
		this.masreip = masreip;
	}



}
