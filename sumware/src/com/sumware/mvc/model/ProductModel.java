package com.sumware.mvc.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
}
