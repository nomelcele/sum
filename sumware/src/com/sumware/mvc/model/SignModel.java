package com.sumware.mvc.model;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sumware.dto.MemberVO;
import com.sumware.dto.SignFormVO;
import com.sumware.dto.SignStepVO;
import com.sumware.dto.SignatureVO;
import com.sumware.mvc.dao.SignDao;
import com.sumware.mvc.service.SignServiceImple;
import com.sumware.util.MyPage;

@Controller
public class SignModel {
	@Autowired
	private SignDao sgdao;
	@Autowired
	private SignServiceImple signService;
	
	// 해당 부서의 결재 문서를 조회 관리(전체, 대기, 완료, 수신, 반려) 등등~
	@RequestMapping(value="getSignList")
	public String getSignList(HttpServletRequest request){
		Enumeration<String> en = request.getParameterNames();
		while(en.hasMoreElements()){
			String key = en.nextElement();
			System.out.println("key::"+key+" value::"+request.getParameter(key));
		}
		HttpSession session = request.getSession();
		session.setAttribute("model", "sign");
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		System.out.println();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		String div=request.getParameter("signdiv");
		if(div==null||div==""){
			div="0";
		}
		
		map.put("signdiv",Integer.parseInt(div));
		map.put("sgdept", mvo.getMemdept());
		map.put("nowmemnum", mvo.getMemnum());
		
		int totalCount = sgdao.getSignCount(map);
		System.out.println("totalCount::"+totalCount);
		System.out.println("page::"+request.getParameter("page"));
		Map<String,Integer> pMap = MyPage.getMp().pageProcess(request, 10, 5, 0, totalCount, 0);
		
		map.put("begin", pMap.get("begin"));
		map.put("end", pMap.get("end"));
		
		List<SignatureVO> sgList=sgdao.getSignList(map);
		request.setAttribute("sgList", sgList);
		request.setAttribute("signdiv", div);
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
	@RequestMapping(value="getSignForm",method=RequestMethod.POST)
	public String getSignForm(HttpServletRequest request){
		System.out.println("결재문서 선택");
		int formnum = Integer.parseInt(request.getParameter("formnum"));
		String[] signMgrs = request.getParameterValues("signMgrs");
		
		System.out.println("formnum::"+formnum);
		for(String e: signMgrs){
			System.out.println("signMgr::"+e);
		}
		String[] signNames=signService.getMgrNames(signMgrs);
		
		SignFormVO sfvo = sgdao.getSf(formnum);
		request.setAttribute("formnum", formnum);
		request.setAttribute("sf", sfvo);
		request.setAttribute("signMgrs", signMgrs);
		request.setAttribute("sgNames", signNames);
		request.setAttribute("signMode", "write");
		return "sign.signWriteForm";
	}
	
	// 선택된 문서를 작성 함.
	@RequestMapping(value="writeSign",method=RequestMethod.POST)
	public String writeSignForm(SignatureVO sgvo,@RequestParam Map<String,String> map){
		System.out.println("작성합시다.");
		for(Map.Entry<String, String> m : map.entrySet()){
			System.out.println(m.getKey()+" :: "+m.getValue());
		}
		
		ArrayList<HashMap<String, String>> sgMgrList=setSignStep(map);
		
		sgvo.setNowmemnum(Integer.parseInt(sgMgrList.get(0).get("stepmemnum")));
		sgvo.setFinalmemnum(Integer.parseInt(map.get("sgMgr"+(sgMgrList.size()))));
		
		System.out.println("============");
		System.out.println("문서번호: "+sgvo.getFormnum());
		System.out.println("제목: "+sgvo.getStitle());
		System.out.println("기안자: "+sgvo.getSgwriter());
		System.out.println("시작날짜: "+sgvo.getStartdate());
		System.out.println("끝나는날짜: "+sgvo.getEnddate());
		System.out.println("현재결재자: "+sgvo.getNowmemnum());
		System.out.println("최종결재자: "+sgvo.getFinalmemnum());
		System.out.println("내용: "+sgvo.getScont());
		System.out.println("사유: "+sgvo.getSreason());
		System.out.println("장소: "+sgvo.getSplace());
		System.out.println("특이사항: "+sgvo.getSps());
		System.out.println("기간: "+sgvo.getSdate());
		System.out.println("============");
		
		signService.insertSignService(sgvo, sgMgrList);
		return "redirect:getSignList?page=1";
	}
	//상세보기
	@RequestMapping(value="signDetail",method=RequestMethod.GET)
	public String signDetail(HttpServletRequest request){
		int snum = Integer.parseInt(request.getParameter("snum"));
		String page = request.getParameter("page");
		SignatureVO sgvo= sgdao.signDetail(snum);
		List<SignStepVO> ssList=sgdao.getSignStep(snum);
		SignFormVO sfvo = sgdao.getSf(sgvo.getFormnum());
		String[] ssMem = new String[ssList.size()];
		
		for(int i =0; i<ssMem.length; i++){
			ssMem[i]=String.valueOf(ssList.get(i).getStepmemnum());
		}
		String[] signNames=signService.getMgrNames(ssMem);
		request.setAttribute("sgvo", sgvo);
		request.setAttribute("sf", sfvo);
		request.setAttribute("ssList", ssList);
		request.setAttribute("sgNames", signNames);
		request.setAttribute("signMode", "detail");
		request.setAttribute("page", page);
		return "sign.signDetail";
	}
	// 결재권자가 올라온 문서를 결재 할때 사용 되는 메서드
	@RequestMapping(value="confirm",method=RequestMethod.POST)
	public String confirm(@RequestParam Map<String,String> map){
		System.out.println("결재를 하자");
		for(Map.Entry<String, String> m : map.entrySet()){
			System.out.println(m.getKey()+" :: "+m.getValue());
		}
		ArrayList<HashMap<String, String>> stepList =setSignStep(map);
		for(HashMap<String, String> step : stepList){
			if(step.get("stepnum")!=null){
				System.out.println("if in stepnum::"+step.get("stepnum"));
				sgdao.updateSignStep(step);
			}
		}
		signService.setNowmemService(Integer.parseInt(map.get("snum")));
		
		return "redirect:getSignList?page=1";
	}
	@RequestMapping(value="signReturn",method=RequestMethod.POST)
	public String signReturn(int snum,String sgreturncomm,HttpSession session){
		System.out.println("반려!");
		MemberVO mvo = (MemberVO) session.getAttribute("v");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sgreturn", String.valueOf(mvo.getMemnum()));
		map.put("snum", String.valueOf(snum));
		map.put("sgreturncomm", sgreturncomm);
		
		sgdao.signReturn(map);
		return "redirect:getSignList?page=1";
	}
	// 결재 문서를 조건에 맞게 검색(결과 내 검색)
	@RequestMapping(value="signSearch")
	public String signSearch(SignatureVO sgvo){
		return null;
	}
	
	// 사용자가 요청하는 문서를 출력 해주는 메쏘오드!
	@RequestMapping(value="getDoc",method=RequestMethod.POST)
	public ModelAndView getDoc(@RequestParam Map<String, String> map){
		System.out.println("문서출력");
		ArrayList<MemberVO> mgrList = new ArrayList<MemberVO>();
		for(int i =1; i<map.size(); i++){
			if(map.get("sgMgr"+i)!=""&&map.get("sgMgr"+i)!=null){
				System.out.println(map.get("sgMgr"+i));
				mgrList.add(sgdao.getSignImg(Integer.parseInt(map.get("sgMgr"+i))));
			}else{
				break;
			}
		}
		SignatureVO sgvo = sgdao.signDetail(Integer.parseInt(map.get("snum")));
		map.put("memname", sgvo.getMemname());
		if(sgvo.getScont()!=""&&sgvo.getScont()!=null){
			map.remove("scont");
			map.put("scont", sgvo.getScont());
		}
		if(sgvo.getSreason()!=""&&sgvo.getSreason()!=null){
			map.remove("sreason");
			map.put("sreason", sgvo.getSreason());
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("excelView");
		mav.addObject("map", map);
		mav.addObject("mgrList", mgrList);
		return mav;
	}
	private ArrayList<HashMap<String,String>> setSignStep(Map<String,String> map){
		ArrayList<HashMap<String, String>> sgMgrList=new ArrayList<HashMap<String,String>>();
		int i=1;
		while(true){
			if(map.get("sgMgr"+i)!=null){
				HashMap<String, String> mgr= new HashMap<String, String>();
				mgr.put("stepmemnum", map.get("sgMgr"+i));
				mgr.put("stepconfirm", map.get("sgImg"+i));
				if(map.get("stepnum"+i)!=null){
					mgr.put("stepnum", map.get("stepnum"+i));
				}
				sgMgrList.add(mgr);
				i++;
			}else{
				break;
			}
		}
		return sgMgrList;
	}	
}
