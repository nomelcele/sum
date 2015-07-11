package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.mvc.dao.ProductDao;

@Controller
public class ProductModel {
	
	@Autowired
	private ProductDao pdao;
	
	// 상단 메뉴 탭 눌렀을 경우 보여지는 첫 페이지.
	@RequestMapping(value="productList")
	public ModelAndView productList(){
		ModelAndView mav = new ModelAndView("product.productList");
		mav.addObject("plist",pdao.proList());
		
		return mav;
	}
	
	// 상품 등록 버튼 눌렀을 때 상품 등록 폼으로 이동
	@RequestMapping(value="writeForm")
	public String writeForm(){
//		System.out.println("옥션 writeForm");
		return "product/promodal";
	}
	
	// promodal.jsp 에서 Done 버튼 눌렀을 경우에 인서트 되는 메소드.
	@RequestMapping(value="done")
	public void proInsert(@RequestParam Map<String,String> provo, @RequestParam MultipartFile proimg,HttpSession ses){
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
	}
	
	
}











