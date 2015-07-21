package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.BidderVO;
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
	public String proDetail(ProductVO vo,HttpSession ses){
		System.out.println("proDetail 메소드!");		
		// 입찰가격이 변경 된다면 detail 페이지에서도 현재 가격이 변동 되어야 함으로
		// session 에 저장 해서 관리 한다.
		ProductVO provo = pdao.proDetail(vo.getPronum());
		ses.setAttribute("provo", provo);
		System.out.println("상품의 가격은 제대로 ? : "+provo.getPrice());
		// promodal.jsp 에서 숫자값이 필요 하기 때문에 가공 하는 로직.
		StringBuffer sb = new StringBuffer(); 
		String[] price = provo.getPrice().trim().split(",");
		for(int i = 0; i<price.length;i++){
			sb.append(price[i]);
		}
		int p = Integer.parseInt(sb.toString());
		//////////////////////////////////////////////////////
		ses.setAttribute("price", p);
		return "product.proDetail";
	}
	
	// 상품 디테일 화면에서 입찰하기 폼으로 이동.(modal 폼)
	@RequestMapping(value="/saproBid")
	public String proBid(){
		System.out.println("proBid() 실행!");
		return "product/promodal";
	}
	
	// 입찰하기 폼(modal 폼) 에서 입찰 누르면 입찰 실행 하는 method.
	@RequestMapping(value="/bidInsert")
	public String bidInsert(BidderVO bidvo){
		// bidder 테이블에 입찰 정보가 입력 되어야 하고,
		// product 의 price 가 업데이트 되어야 한다.
		System.out.println("입찰한 상품 번호?:::::: "+bidvo.getBidpronum());
		System.out.println("입찰한 상품 가격?:::::: "+bidvo.getBidprice());
		pdao.bidInsert(bidvo);
		pdao.bidUpdate(bidvo);
		pdao.bidCount(bidvo);
		return "redirect:/saproDetail?pronum="+bidvo.getBidpronum();
	
	}	
	
	
	
}



















