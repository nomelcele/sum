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
			// 메일에 보내질 제목
			String mailsubject = "신입 사원 로그인 정보입니다.";
			
			// 메일에 보내질 내용
			String mailcont = nmvo.getMemname()+"님의 사원번호는 "+nmvo.getMemnum()+", 비밀번호는 "
					+nmvo.getMempwd()+", 부서는 "+nmvo.getDename()+", 상급자는 "+nmvo.getMgrname()+" 입니다.";
			
			// 메일전송 클래스를 이용하여 메일전송
			int res = SendEmail.getSendemail().sendEmailToMem(nmvo, mailsubject, mailcont);
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
	public void changeJobSalary(MemberVO mvo,int[] juniors) {
		// 사원 진급 처리
		adao.promoteMem(mvo); // 직급 변경
		adao.changeSalary(mvo); // 연봉 변경
		adao.changeMgr(mvo);// 상급자 변경
		// 현재 하급자의 상급자 지정
		for(int e:juniors){
			MemberVO v = new MemberVO();
			v.setMemmgr(mvo.getMemjmgr());
			v.setMemnum(e);
			adao.changeMgr(v);
		}
	}

	@Override
	public void changeDeptMgr(MemberVO mvo,int[] juniors) {
		// 사원 부서 이동
		adao.moveDept(mvo); // 부서 이동
		adao.changeMgr(mvo);// 상급자 변경
		// 현재 하급자의 상급자 지정
		for(int e:juniors){
			MemberVO v = new MemberVO();
			v.setMemmgr(mvo.getMemjmgr());
			v.setMemnum(e);
			adao.changeMgr(v);
		}
	}
	
	
}
