package com.sumware.mvc.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public void proInsert(Map<String,String> provo){
		st.insert("pro.proInsert",provo);
	}
}
