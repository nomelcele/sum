package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.ProductVO;
import com.sumware.mvc.dao.ProductDao;

@Controller
public class ProductModel {
	
	@Autowired
	private ProductDao pdao;
	
	// 상단 메뉴 탭 눌렀을 경우 보여지는 첫 페이지.
	@RequestMapping(value="/saproductList")
	public ModelAndView productList(HttpSession ses){
		ModelAndView mav = new ModelAndView();
		// 시큐리티 관련 되어서 멤버 세션을 저장하는데...필요해서.. 추후 홍코더 한테 다시 물어 보자.
		String first = (String) ses.getAttribute("first");
		if(first.equals("1")){
			mav.setViewName("safirstLoginForm");
		}else if(first.equals("0")){
			ses.invalidate();
			mav.setViewName("home");
		}else{
			ses.setAttribute("model", "auction");
			mav.setViewName("product.productList");
			mav.addObject("plist",pdao.proList());
		}
		return mav;
	}
	
	// 상품 등록 버튼 눌렀을 때 상품 등록 폼으로 이동
	@RequestMapping(value="/sawriteForm")
	public String writeForm(){
		return "product/promodal";
	}
	
	// promodal.jsp 에서 Done 버튼 눌렀을 경우에 인서트 되고 리스트 다시 불러온다.
	@RequestMapping(value="/sadone")
	public String proInsert(@RequestParam Map<String,String> provo, @RequestParam MultipartFile proimg,HttpSession ses){
		System.out.println("옥션 done !!!!!");
		
		// 상품 이미지 업로드
		String rPath = ses.getServletContext().getRealPath("/");
		String realName = proimg.getOriginalFilename();
		
		StringBuffer path = new StringBuffer();
		path.append(rPath).append("aucImg/").append(realName);
		
		File f = new File(path.toString());
		if(!f.exists()){
			f.mkdirs();
		}
		try {
			proimg.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		provo.put("proimg", realName);
		
		
		pdao.proInsert(provo);
		return "redirect:saproductList";
	}
	
	// 상품 디테일 보여주는 메서드.
	@RequestMapping(value="/saproDetail")
	public String proDetail(ProductVO vo,Model model){
		System.out.println("proDetail 메소드!");		
		model.addAttribute("provo", pdao.proDetail(vo.getPronum()));
		return "product.proDetail";
	}
	
	// 상품 디테일 화면에서 입찰하기 버튼 눌렀을 경우 실행.
	@RequestMapping(value="/saproBid")
	public String proBid(){
		return "product/promodal";
	}
	
}



















