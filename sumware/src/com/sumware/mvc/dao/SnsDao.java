package com.sumware.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.CommVO;
import com.sumware.dto.SnsVO;

@Repository
public class SnsDao {
	@Autowired
	private SqlSessionTemplate st;
	//sns 입력
	public void insertSns(SnsVO svo){
		st.insert("sns.insertSns",svo);
	}
	//sns 가져오기
	public List<SnsVO> getList(Map<String,Integer> map){
		return st.selectList("sns.getList",map);
	}
	
	public int snsTotalCount(int sdept){
		return st.selectOne("sns.snsTotalCount",sdept);
	}
	public int snsCommTotalCount(int commsns){
		return st.selectOne("sns.snsCommTotalCount",commsns);
	}
	public List<CommVO> getCommList(Map<String,Integer> map){
		return st.selectList("sns.getCommList",map);
	}
	public void insertSnsComm(Map<String,String> map){
		st.insert("sns.insertSnsComm",map);
	}
	public void snsCommDelete(int conum){
		st.delete("sns.snsCommDelete",conum);
	}
}
