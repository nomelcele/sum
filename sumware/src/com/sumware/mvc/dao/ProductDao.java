package com.sumware.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.ProductVO;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	public void proInsert(Map<String,String> provo){
		st.insert("pro.proInsert",provo);
	}

	public List<ProductVO> proList(){
		return st.selectList("pro.proList");
	}
	
	
}
