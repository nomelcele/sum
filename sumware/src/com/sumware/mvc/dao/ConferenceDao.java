package com.sumware.mvc.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.ConferenceVO;

@Repository
public class ConferenceDao {

	@Autowired
	private SqlSessionTemplate st;
	
	public void addConfmem(ConferenceVO confvo){
		st.insert("conf.addConfmem", confvo);
	}
	
	public ConferenceVO getConfurl(int confmem){
		return st.selectOne("conf.getConfurl", confmem);
	}
	
	public void deleteConfnum(int confnum){
		st.delete("conf.deleteConfnum", confnum);
	}
}
