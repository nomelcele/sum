package com.sumware.mvc.model;

import java.util.List;

import javax.jws.WebParam.Mode;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sumware.dto.MemberVO;
import com.sumware.dto.PayHistoryVO;
import com.sumware.dto.PayVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.mvc.dao.MemberDao;

@Controller
public class MemInfoModel {

	@Autowired
	private MemberDao mdao;

	@Autowired
	private AdminDao adao;

	@RequestMapping(value = "/modifyProfile")
	public String modifyProfile(Mode mode, HttpSession session) {
		session.setAttribute("model", "join");
		// 프로필 수정폼
		return "join.member";

	}

	@RequestMapping(value = "/modifyProfileMenu")
	public String modifyProfileMenu(Mode mode, HttpSession session) {
		// 프로필 수정폼
		return "join/member";

	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(MemberVO mvo, HttpSession session) {
		// 수정 버튼

		// HashMap<String, String> map= MyMap.getMaps().getMapList(request);

		mdao.modify(mvo);
		// session = request.getSession();
		// 저장된 세션 다 날림.
		session.removeAttribute("v");
		session.removeAttribute("teamNameList");
		return "home.index";

	}

	@RequestMapping(value = "/memPayInfoDetail", method = RequestMethod.POST)
	public String memPayInfoDetail(MemberVO vo, String hisdate, Model model) {

		// member 정보 가져옴
		MemberVO mvo = adao.getMemInfo(vo);
		model.addAttribute("memvo", mvo);
		// member pay 정보 가져옴
		PayVO payvo = adao.getPayInfo(vo.getMemnum());
		model.addAttribute("payvo", payvo);
		// member payhistory 정보 가져옴
		PayHistoryVO payhistoryvo = new PayHistoryVO();
		payhistoryvo.setHismem(vo.getMemnum());
		if (hisdate != null && hisdate != "") {
			payhistoryvo.setHisdate(hisdate);
		} else {
			payhistoryvo.setHisdate(null);
		}
		List<PayHistoryVO> phvo = adao.getPayHistory(payhistoryvo);
		model.addAttribute("phvoList", phvo);
		// 사원마다 급여 지급 받은 이력이 있는 년도 뽑아옴 ( select태그에 추가하기 위해)
		List<PayHistoryVO> months = adao.getMonths(vo.getMemnum());
		model.addAttribute("monthList", months);

		return "meminfo/memPayInfo";
	}
}
