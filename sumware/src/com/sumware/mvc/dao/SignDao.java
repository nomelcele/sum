package com.sumware.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SignDao {
	@Autowired
	private SqlSessionTemplate st;
	
	
	
}
