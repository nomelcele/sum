package com.sumware.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.sumware.dto.BidderVO;
import com.sumware.dto.ProductVO;

@Repository
public class ProductDao {
	
	@Autowired
	private SqlSessionTemplate st;
	
	// 제품 정보 인서트
	public void proInsert(Map<String,String> provo){
		st.insert("pro.proInsert",provo);
	}

	// 제품 목록 셀렉트 리스트
	public List<ProductVO> proList(){
		return st.selectList("pro.proList");
	}
	
	// 제품 상세정보 셀렉트 원
	public ProductVO proDetail(int pronum){
		return st.selectOne("pro.proDetail",pronum);
	}
	
	
	/* 나중에 트랜잭션 처리 해보자                               */
	// 제품 입찰정보 인서트
	public void bidInsert(BidderVO bidvo){
		st.insert("pro.bidInsert", bidvo);
	}
	
	// 입찰시에 제품의 가격 업데이트
	public void bidUpdate(BidderVO bidvo){
		st.update("pro.proUpdate", bidvo);
	}
	
	// 입찰시에 제품의 입찰 횟수 업데이트
	public void bidCount(BidderVO bidvo){
		st.update("pro.proCount",bidvo);
	}
	/* /나중에 트랜잭션 처리 해보자                              */
	
	// 상품목록 페이징을 위한 상품 총 갯수
	public int proTotalCount(){
		return st.selectOne("pro.proTotalCount");
	}
	
	// 입찰정보를 보여주는 셀렉트
	public List<BidderVO> bidInfo(BidderVO bidvo){
		return st.selectList("pro.bidInfo", bidvo);
	}
	
	
}








