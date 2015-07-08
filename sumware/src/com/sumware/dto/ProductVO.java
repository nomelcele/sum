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
	private String product,proimg,zzim;
	private int prowriter,price,procount,pronum;
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
	public String getZzim() {
		return zzim;
	}
	public void setZzim(String zzim) {
		this.zzim = zzim;
	}
	public int getProwriter() {
		return prowriter;
	}
	public void setProwriter(int prowriter) {
		this.prowriter = prowriter;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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
