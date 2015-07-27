package com.sumware.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.sumware.dto.ProductVO;
import com.sumware.mvc.dao.QuartzDao;

public class BidQuartzJob extends QuartzJobBean{

	private SimpleDateFormat sdf;
	private QuartzDao qdao;
	private List<ProductVO> endList = null;

	@Override
	protected void executeInternal(JobExecutionContext arg0)throws JobExecutionException {
		System.out.println("쿼츠가 1분단위로 작동 합니다.");
		int now = Integer.parseInt(sdf.format(new Date()));
		// 종료날짜를 리스트로 불러온다. 혹시 몰라서 상품 번호까지 같이 불러옴.
		endList = qdao.getEnddate();
		for(ProductVO provo : endList){
//			System.out.println("쿼츠의 for 문 입니다.");
			int	end = Integer.parseInt(provo.getEnddate().trim());
			if(now >= end){
//				System.out.println("종료 시점 : "+end);
//				System.out.println("현재 시점 : "+now);
				// 업데이트 구문.
				qdao.statusUpdate(provo.getPronum());
			}
		}
	}
	
	public void setQdao(QuartzDao qdao) {
		this.qdao = qdao;
	}

	public void setSdf(SimpleDateFormat sdf) {
		this.sdf = sdf;
	}
	

}
