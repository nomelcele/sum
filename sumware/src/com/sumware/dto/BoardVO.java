package com.sumware.dto;

public class BoardVO {
	private int bnum,bmem,bhit,bgnum,begin,end,bdeptno,page;
	private String btitle,bcont,bimg, bdate,bwriter,bname,bsearch,div;
	
	
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getBdeptno() {
		return bdeptno;
	}
	public void setBdeptno(int bdeptno) {
		this.bdeptno = bdeptno;
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
	public String getBwriter() {
		return bwriter;
	}
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public int getBmem() {
		return bmem;
	}
	public void setBmem(int bmem) {
		this.bmem = bmem;
	}
	public int getBhit() {
		return bhit;
	}
	public void setBhit(int bhit) {
		this.bhit = bhit;
	}
	public int getBgnum() {
		return bgnum;
	}
	public void setBgnum(int bgnum) {
		this.bgnum = bgnum;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcont() {
		return bcont;
	}
	public void setBcont(String bcont) {
		this.bcont = bcont;
	}
	public String getBimg() {
		return bimg;
	}
	public void setBimg(String bimg) {
		this.bimg = bimg;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getBsearch() {
		return bsearch;
	}
	public void setBsearch(String bsearch) {
		this.bsearch = bsearch;
	}
	public String getDiv() {
		return div;
	}
	public void setDiv(String div) {
		this.div = div;
	}
	
}
