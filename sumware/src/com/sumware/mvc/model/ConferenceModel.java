package com.sumware.mvc.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sumware.dto.ConferenceVO;
import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.dao.ConferenceDao;
import com.sumware.util.MyPage;

@Controller
public class ConferenceModel {
	@Autowired
	private AdminDao adao;
	@Autowired
	private ConferenceDao cdao;

	@RequestMapping(value = "/saconfForm")
	public String vcForm(MemberVO mvo, Model model, HttpServletRequest req) {
		// 회의방 만들기 폼으로 이동
		// 일단 admindao에서 사원 리스트 불러오는 메서드 이용
		// -> 따로 만들어야 되나?
		// 페이지 처리
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,
				totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		System.out.println("Conference Controller");
		List<MemberVO> list = adao.getMemInfoList(mvo);
		System.out.println("사원 수: " + list.size());
		model.addAttribute("list", list);
		return "conference/confForm";
	}

	@RequestMapping(value = "/saconfSearch")
	public String vcMakeRoom(MemberVO mvo, Model model, HttpServletRequest req) {
		// 폼에서 사원 검색했을 때 리스트만 불러옴
		int totalCount = adao.getMemCount(mvo);
		Map<String, Integer> pmap = MyPage.getMp().pageProcess(req, 10, 5, 0,
				totalCount, 0);
		mvo.setBegin(pmap.get("begin"));
		mvo.setEnd(pmap.get("end"));

		List<MemberVO> list = adao.getMemInfoList(mvo);
		model.addAttribute("list", list);
		return "conference/confMemSearch";
	}

	@RequestMapping(value = "/saconfMemAdd")
	public void vcNotify(String confurl, int[] confmems) {
		for(int e:confmems){
			System.out.println("알림 보낼 사원 번호: "+e);
			ConferenceVO confvo = new ConferenceVO();
			confvo.setConfurl(confurl);
			confvo.setConfmem(e);
			cdao.addConfmem(confvo);
		}
	}

}
