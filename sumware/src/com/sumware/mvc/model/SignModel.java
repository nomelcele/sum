package com.sumware.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.dto.SignatureVO;

@Controller
public class SignModel {
	
	// 전자결재 첫화면으로 가는 메쏘오드.
	@RequestMapping(value="sign")
	public String acountMain(HttpSession session){
		session.setAttribute("model", "sign");
		return "sign.signMain";
	}
	
	@RequestMapping(value="getSignList")
	public String getSignList(SignatureVO sgvo,Model mod){
		
		return null;
	}
	
	@RequestMapping(value="getSignFormList",method=RequestMethod.POST)
	public String getSignFormList(MemberVO mvo,Model mod){
		
		return null;
	}
}
