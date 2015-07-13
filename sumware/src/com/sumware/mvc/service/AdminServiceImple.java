package com.sumware.mvc.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MemberVO;
import com.sumware.dto.PayVO;
import com.sumware.mvc.dao.AdminDao;
import com.sumware.util.SendEmail;

@Transactional
@Service
@Qualifier(value = "admin")
public class AdminServiceImple extends AbstractService {
	@Autowired
	private AdminDao adao;
	
	@Override
	public void addNewMember(MemberVO vo, PayVO payvo) throws Exception {
		// 사원의 기본 정보를 가지고 디비에 추가
		adao.addMember(vo);
		// 새 사원에 대한 정보 가져옴
		// 메일에 사원의 정보를 보여주기 위함
		MemberVO nmvo = adao.getNewMemInfo(vo);
		try {
			// 메일전송 클래스를 이용하여 메일전송
			int res = SendEmail.getSendemail().sendEmailToNewMem(nmvo);
			if (res == 0) {
				// 메일 전송 실패 시 디비 삭제
				adao.cancelAddMem(nmvo.getMemnum());
				throw new Exception("메일 전송 실패");
			}
			// 연봉 정보 테이블에 연봉 추가
			payvo.setPmem(nmvo.getMemnum());
			adao.insertPay(payvo);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void changeJobSalary(MemberVO mvo) {
		// 사원 진급 처리
		adao.promoteMem(mvo); // 직급 변경
		adao.changeSalary(mvo); // 연봉 변경
	}
}
