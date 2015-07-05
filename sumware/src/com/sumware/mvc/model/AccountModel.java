package com.sumware.mvc.model;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AccountModel {
	@RequestMapping(value="account")
	public String acountMain(HttpSession session){
		session.setAttribute("model", "acount");
		return "acount.acountMain";
	}
}
