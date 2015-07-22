package com.sumware.dto;

public class BidderVO {
	private int bidnum,bidmem,bidpronum,bidprice;
	private String bidmemname,biddate;

	

	public String getBiddate() {
		return biddate;
	}

	public void setBiddate(String biddate) {
		this.biddate = biddate;
	}

	public String getBidmemname() {
		return bidmemname;
	}

	public void setBidmemname(String bidmemname) {
		this.bidmemname = bidmemname;
	}

	public int getBidnum() {
		return bidnum;
	}

	public void setBidnum(int bidnum) {
		this.bidnum = bidnum;
	}

	public int getBidmem() {
		return bidmem;
	}

	public void setBidmem(int bidmem) {
		this.bidmem = bidmem;
	}

	public int getBidpronum() {
		return bidpronum;
	}

	public void setBidpronum(int bidpronum) {
		this.bidpronum = bidpronum;
	}

	public int getBidprice() {
		return bidprice;
	}

	public void setBidprice(int bidprice) {
		this.bidprice = bidprice;
	}
	
	
}
