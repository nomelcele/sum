package com.sumware.mvc.model;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sumware.dto.CommissionVO;
import com.sumware.dto.DeptVO;
import com.sumware.dto.ProductVO;
import com.sumware.dto.SnsVO;
import com.sumware.mvc.dao.ChartDao;

@Controller
public class ChartModel {

	@Autowired
	private ChartDao cdao;
	
	@RequestMapping(value="/sachart")
	public String chart(Model model, HttpSession session){
		
		session.setAttribute("model", "chart");
		
		// 전 월 추가급여 순위 5
		List<CommissionVO> comvo = cdao.getCommissionKing();

		// 이름
		StringBuffer comnamesf = new StringBuffer();
		comnamesf.append("[");
		if(comvo != null){
			for(int i=0; i<comvo.size(); i++){
				comnamesf.append("\"");
				comnamesf.append(comvo.get(i).getMemname());
				comnamesf.append("\"");
				if(!(i == comvo.size()-1)){
					comnamesf.append(",");
				}
			}
		}
		comnamesf.append("]");
		model.addAttribute("comnames", comnamesf.toString());
		
		// 추가금액
				StringBuffer comsumsf = new StringBuffer();
				comsumsf.append("[");
				if(comvo != null){
					for(int i=0; i<comvo.size(); i++){
						comsumsf.append(comvo.get(i).getComsum());
						if(!(i == comvo.size()-1)){
							comsumsf.append(",");
						}
					}
				}
				comsumsf.append("]");
				model.addAttribute("comsums", comsumsf.toString());
				
				
			//  sns 게시왕
				List<SnsVO> svo = cdao.getSnsKing();
				// 데이타를 JSON 형식으로 만들어 줌
				StringBuffer snssf = new StringBuffer();
				snssf.append("[");
				if(svo != null){
					for(int i=0; i<svo.size(); i++){
						snssf.append("[");
						snssf.append("\"");
						snssf.append(svo.get(i).getSmemname());
						snssf.append("\",");
						snssf.append(svo.get(i).getScnt());
						snssf.append("]");
						if(!(i == svo.size()-1)){
							snssf.append(",");
						}
					}
				}
				snssf.append("]");
				System.out.println("SNS Chart data : "+snssf.toString());
				model.addAttribute("snschart", snssf.toString());
				
				//[{name: "인사부",y: 12,drilldown: "인사부"}, 
				/// 부서 업무 수행 순위~~!!!! 부서별!
				List<DeptVO> dvolist = cdao.getTodoKingDept();
				StringBuffer todosf = new StringBuffer();
				todosf.append("[");
				if(dvolist != null){
					for(int i=0; i<dvolist.size(); i++){
						todosf.append("{name:");
						todosf.append("\"");
						todosf.append(dvolist.get(i).getDename());
						todosf.append("\",y:");
						todosf.append(dvolist.get(i).getTcnt());
						todosf.append(",drilldown:");
						todosf.append("\"");
						todosf.append(dvolist.get(i).getDename());
						todosf.append("\"");
						todosf.append("}");
						if(!(i == dvolist.size()-1)){
							todosf.append(",");
						}
					}
				}
				todosf.append("]");
				model.addAttribute("tododept", todosf.toString());
				
				// 부서의 팀장별 업무수
				StringBuffer teamtodosf = new StringBuffer();
				teamtodosf.append("[");
				if(dvolist != null){
					for(int i=0; i<dvolist.size(); i++){
						List<DeptVO> teamlist = cdao.getTodoKingTeam(dvolist.get(i).getDenum());
						teamtodosf.append("{name:");
						teamtodosf.append("\"");
						teamtodosf.append(dvolist.get(i).getDename());
						teamtodosf.append("\",id:\"");
						teamtodosf.append(dvolist.get(i).getDename());
						teamtodosf.append("\",data:[");
						if(teamlist != null){
							for(int j=0; j<teamlist.size();j++){
								teamtodosf.append("[\"");
								teamtodosf.append(teamlist.get(j).getMemname());
								teamtodosf.append(" 팀\",");
								teamtodosf.append(teamlist.get(j).getTcnt());
								teamtodosf.append("]");	
								if(!(j == teamlist.size()-1)){
									teamtodosf.append(",");
								}
							}
						}
						teamtodosf.append("]");	
						teamtodosf.append("}");
						if(!(i == dvolist.size()-1)){
							teamtodosf.append(",");
						}
					}
				}
				teamtodosf.append("]");
				model.addAttribute("todoteam", teamtodosf.toString());
				
				
				// 경매 입찰 순위
				List<ProductVO> provolist = cdao.getAuctionCount();
				//
				StringBuffer aucsf = new StringBuffer();
				aucsf.append("[");
				if (provolist != null) {
					for (int i = 0; i < provolist.size(); i++) {
						aucsf.append("[");
						aucsf.append("\"");
						aucsf.append(provolist.get(i).getProduct());
						aucsf.append("-");
						aucsf.append(provolist.get(i).getMemname());
						aucsf.append("\",");
						aucsf.append(provolist.get(i).getProcount());
						aucsf.append("]");
						if (!(i == provolist.size() - 1)) {
							aucsf.append(",");
						}
					}
				}
				aucsf.append("]");
				model.addAttribute("auctionchart", aucsf.toString());

		return "charts.charts";
	}
	
}
