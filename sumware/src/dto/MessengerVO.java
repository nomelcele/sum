package dto;

public class MessengerVO {
	private int mesmember, mesnum, conum, mesconum, meswriternum, mesendnum;
	private String openmemberyn, entstdate, entendate, mescont, mesreip;

	public int getMesendnum() {
		return mesendnum;
	}
	public void setMesendnum(int mesendnum) {
		this.mesendnum = mesendnum;
	}
	public int getMesmember() {
		return mesmember;
	}
	public void setMesmember(int mesmember) {
		this.mesmember = mesmember;
	}
	public int getMesnum() {
		return mesnum;
	}
	public void setMesnum(int mesnum) {
		this.mesnum = mesnum;
	}
	public int getConum() {
		return conum;
	}
	public void setConum(int conum) {
		this.conum = conum;
	}
	public int getMesconum() {
		return mesconum;
	}
	public void setMesconum(int mesconum) {
		this.mesconum = mesconum;
	}
	public int getMeswriternum() {
		return meswriternum;
	}
	public void setMeswriternum(int meswriternum) {
		this.meswriternum = meswriternum;
	}
	
	public String getOpenmemberyn() {
		return openmemberyn;
	}
	public void setOpenmemberyn(String openmemberyn) {
		this.openmemberyn = openmemberyn;
	}
	public String getEntstdate() {
		return entstdate;
	}
	public void setEntstdate(String entstdate) {
		this.entstdate = entstdate;
	}
	public String getEntendate() {
		return entendate;
	}
	public void setEntendate(String entendate) {
		this.entendate = entendate;
	}
	public String getMescont() {
		return mescont;
	}
	public void setMescont(String mescont) {
		this.mescont = mescont;
	}
	
	public String getMesreip() {
		return mesreip;
	}
	public void setMesreip(String mesreip) {
		this.mesreip = mesreip;
	}
}
