package dto;

public class MessengerVO {
	private int mesnum, mesmem;
	private String mescont, mesreceiver;
	
	public int getMesnum() {
		return mesnum;
	}
	public void setMesnum(int mesnum) {
		this.mesnum = mesnum;
	}
	public int getMesmem() {
		return mesmem;
	}
	public void setMesmem(int mesmem) {
		this.mesmem = mesmem;
	}
	public String getMescont() {
		return mescont;
	}
	public void setMescont(String mescont) {
		this.mescont = mescont;
	}
	public String getMesreceiver() {
		return mesreceiver;
	}
	public void setMesreceiver(String mesreceiver) {
		this.mesreceiver = mesreceiver;
	}

}
