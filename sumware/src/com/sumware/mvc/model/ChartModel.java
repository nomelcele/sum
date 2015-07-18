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
		System.out.println("json : "+comnamesf.toString());	
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
				System.out.println("json : "+comsumsf.toString());	
				model.addAttribute("comsums", comsumsf.toString());
				
				
			//  sns 게시왕
				List<SnsVO> svo = cdao.getSnsKing();
				//
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
				System.out.println("json3 : "+snssf.toString());	
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
				System.out.println("json4 : "+todosf.toString());	
				model.addAttribute("tododept", todosf.toString());
				
		
		return "charts.charts";
	}
	
}
