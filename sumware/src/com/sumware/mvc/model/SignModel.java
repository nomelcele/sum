package com.sumware.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SignModel {
	@RequestMapping(value="sign")
	public String acountMain(HttpSession session){
		session.setAttribute("model", "sign");
		return "acount.acountMain";
	}
}
