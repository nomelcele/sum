package com.sumware.mvc.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.dto.SignFormVO;
import com.sumware.dto.SignatureVO;
import com.sumware.mvc.dao.SignDao;
import com.sumware.mvc.service.SignServiceImple;

@Controller
public class SignModel {
	@Autowired
	private SignDao sgdao;
	@Autowired
	private SignServiceImple signService;
	// 전자결재 첫화면으로 가는 메쏘오드.
	@RequestMapping(value="sign")
	public String acountMain(HttpSession session){
		session.setAttribute("model", "sign");
		return "sign.signMain";
	}
	
	// 해당 부서의 결재 문서를 조회 관리(전체, 대기, 완료, 수신, 반려) 등등~
	@RequestMapping(value="getSignList")
	public String getSignList(SignatureVO sgvo,Model mod,HttpSession session){
		session.setAttribute("model", "sign");
		return "sign.signList";
	}
	// 회사의 결재 문서들의 종류를 보여주는 메소오드~ajax처리
	@RequestMapping(value="getSignFormList")
	public String getSignFormList(Model mod,HttpSession session){
		MemberVO mvo = (MemberVO) session.getAttribute("v");

		List<MemberVO> mgrList = signService.getMgrList(mvo.getMemnum());
		List<SignFormVO> sfList=sgdao.getSfList();
	
		mod.addAttribute("mgrList", mgrList);
		mod.addAttribute("sfList", sfList);
		
		return "sign/signFormList";
	}
	
	// 결재문서의 종류 중 하나를 택해서 가져옴.
	public String getSignForm(SignFormVO sfvo){
		return null;
	}
	
	// 선택된 문서를 작성 함.
	@RequestMapping(value="writeSign")
	public String writeSignForm(Map<String,Object> map){
		return null;
	}
	
	// 결재권자가 올라온 문서를 결재 할때 사용 되는 메서드
	@RequestMapping(value="confirm")
	public String confirm(SignatureVO sgvo){
		return null;
	}
	
	// 결재 문서를 조건에 맞게 검색(결과 내 검색)
	@RequestMapping(value="signSearch")
	public String signSearch(SignatureVO sgvo){
		return null;
	}
	
	// 사용자가 요청하는 문서를 출력 해주는 메쏘오드!
	@RequestMapping(value="getDoc")
	public String getDoc(SignatureVO sgvo){
		return null;
	}
	
}
