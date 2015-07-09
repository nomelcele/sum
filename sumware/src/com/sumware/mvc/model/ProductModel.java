package com.sumware.mvc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import sun.security.krb5.internal.PAData;

import com.sumware.dto.ProductVO;
import com.sumware.mvc.dao.ProductDao;

@Controller
public class ProductModel {
	
	@Autowired
	private ProductDao pdao;
	
	// 상단 메뉴 탭 눌렀을 경우 보여지는 첫 페이지.
	@RequestMapping(value="productList")
	public String productList(){
		return "product.productList";
	}
	
	// 상품 등록 버튼 눌렀을 때 상품 등록 폼으로 이동
	@RequestMapping(value="writeForm")
	public String writeForm(){
//		System.out.println("옥션 writeForm");
		return "product/promodal";
	}
	
	// promodal.jsp 에서 Done 버튼 눌렀을 경우에 인서트 되는 메소드.
	@RequestMapping(value="done")
	public void proInsert(ProductVO vo){
		System.out.println("옥션 done!");
		vo.setProimg("야매로");
		pdao.proInsert(vo);
		
	}
	
	
}











