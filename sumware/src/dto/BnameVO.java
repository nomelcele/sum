package dto;

import java.io.Serializable;

public class BnameVO implements Serializable {
	private String bname;
	private int bgnum, bdeptno;
	
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public int getBgnum() {
		return bgnum;
	}
	public void setBgnum(int bgnum) {
		this.bgnum = bgnum;
	}
	public int getBdeptno() {
		return bdeptno;
	}
	public void setBdeptno(int bdeptno) {
		this.bdeptno = bdeptno;
	}
}
