package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.CommissionVO;
import com.sumware.dto.DeptVO;
import com.sumware.dto.SnsVO;

@Repository
public class ChartDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	// 전 달의 추가급여 순위 5
	public List<CommissionVO> getCommissionKing(){
		return st.selectList("chart.getCommissionKing");
	}
	
	// sns 활동
	public List<SnsVO> getSnsKing(){
		return st.selectList("chart.getSnsKing");
	}
	
	// 올해 부서 업무 성취 순위
	public List<DeptVO> getTodoKingDept(){
		return st.selectList("chart.getTodoKingDept");
	}
	
	// 부서의 팀별 팀장,업무수
	public List<DeptVO> getTodoKingTeam(int deptnum){
		return st.selectList("chart.getTodoKingTeam", deptnum);	
	}
	
}
