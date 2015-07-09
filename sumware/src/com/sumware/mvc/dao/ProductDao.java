package com.sumware.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.ProductVO;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public void proInsert(ProductVO vo){
		st.insert("pro.proInsert",vo);
	}
}
