package com.sumware.dto;

public class ProductVO {
	/*
	product VARCHAR2(100) CONSTRAINT product_product_nn NOT null, -- 상품명(글제목)
    proimg VARCHAR2(50), -- 상품 이미지
    prowriter NUMBER(5), -- 상품 게시자 fk member(memnum)
    price NUMBER(8) CONSTRAINT product_price_nn NOT NULL, -- 상품 금액
    procount NUMBER(3),-- 경매에 참여한 사람 수
    pronum NUMBER(5), -- 경매번호 pk
    zzim VARCHAR2(1) DEFAULT 'n', -- 찜한목록이면 y 아니면 n*/
	private String product,proimg,status;
	private String startdate, enddate,procont,price,memname,startprice,prostep;
	private int prowriter,procount,pronum,begin,end;
	
	
	public String getProstep() {
		return prostep;
	}
	public void setProstep(String prostep) {
		this.prostep = prostep;
	}
	public String getStartprice() {
		return startprice;
	}
	public void setStartprice(String startprice) {
		this.startprice = startprice;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getProcont() {
		return procont;
	}
	public void setProcont(String procont) {
		this.procont = procont;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getProimg() {
		return proimg;
	}
	public void setProimg(String proimg) {
		this.proimg = proimg;
	}
	public int getProwriter() {
		return prowriter;
	}
	public void setProwriter(int prowriter) {
		this.prowriter = prowriter;
	}
	public int getProcount() {
		return procount;
	}
	public void setProcount(int procount) {
		this.procount = procount;
	}
	public int getPronum() {
		return pronum;
	}
	public void setPronum(int pronum) {
		this.pronum = pronum;
	}
	
	
}
