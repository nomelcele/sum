package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.ProductVO;

@Repository
public class QuartzDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	// 쿼츠가 1분단위로 호출 하는 메서드
		// 경매시간의 종료 여부를 알수 있다.
		public List<ProductVO> getEnddate(){
			List<ProductVO> list = st.selectList("pro.getEnddate"); 
			return list;
		}
		
		// 판매중인 경매 상품을 판매 종료로 바꿔 준다.
		public void statusUpdate(int pronum){
			st.update("pro.statusUpdate",pronum);
		}
}
