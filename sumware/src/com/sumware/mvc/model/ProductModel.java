package com.sumware.mvc.model;

import java.io.File;
import java.io.IOException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
import com.sumware.util.MyPage;

@Controller
public class ProductModel {
	
	@Autowired
	private ProductDao pdao;
	
	// 상단 메뉴 탭 눌렀을 경우 보여지는 첫 페이지.
	@RequestMapping(value="/saproductList")
	public ModelAndView productList(Map<String,Integer> map, HttpSession ses,HttpServletRequest req){
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
			map = MyPage.getMp().pageProcess(req, 10, 5, 0, pdao.proTotalCount(), 0);
			mav.setViewName("product.productList");
			ses.setAttribute("sesPage",map.get("page"));
			mav.addObject("plist",pdao.proList(map));
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
		System.out.println("enddate 는 ? :::::" + provo.get("enddate"));
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
		provo.put("price", provo.get("startprice"));
		
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
		System.out.println("bidInsert() 실행!");
		System.out.println("입찰한 상품 번호?:::::: "+bidvo.getBidpronum());
		System.out.println("입찰한 상품 가격?:::::: "+bidvo.getBidprice());
		pdao.bidInsert(bidvo);
		pdao.bidUpdate(bidvo);
		pdao.bidCount(bidvo);
		// 현재 시간과 해당 상품 판매 종료시간을 비교하여 10분전인지 아닌지 판별 한다.
		String enddate = pdao.enddate(bidvo.getBidpronum());
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
		// new ParsePosition 스트링을 여러가지 타입으로 파싱 해주는 클래스
		// 여기서는 스트링 문자를 Date 형식으로 파싱 해준다. 인자값 0 은 
		// 시작 인덱스를 의미함.	
		Date eDate = sdf.parse(enddate, new ParsePosition(0));
		// 입찰 종료 시간.
		long e = eDate.getTime();
		System.out.println("이것은 현재 db 에 저장된 이 상품의 경매 종료 시간 :  "+e);
		
		// 입찰이 일어난 현재 시간.
		Calendar cal = Calendar.getInstance();
		Date sDate = cal.getTime();
		long s = sDate.getTime();
		System.out.println("이것은 현재 이 상품의 입찰 시도 시간 :  "+s);
		
		// 두 시각의 차이를 계산.
		long mills = e-s;
		
		// mills 를 분으로 치환
		long min = mills/60000;
		System.out.println("!!!!!! 입찰 종료까지 남은 시간 :::::: "+min+" 분 이다.");
		if(min <= 10){
			System.out.println("입찰종료 시간이 1 시간 늘어 납니다.");
			pdao.enddateUpdate(bidvo.getBidpronum());
		}
		
		return "redirect:/saproDetail?pronum="+bidvo.getBidpronum();
	
	}	
	
	// 상품목록에서 입찰정보 누르면 동작.
	@RequestMapping(value="/bidInfo")
	public String bidInfo(BidderVO bidvo,Model model){
		// modal 페이지로 리스트의 주소값을 forward 한다.
		System.out.println("bidInformation 메소드 동작 !!!!");
		model.addAttribute("bidderList",pdao.bidInfo(bidvo));
		return "product/promodal";
	}
	
}



















