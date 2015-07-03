package com.sumware.mvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.AdminDao;

@Transactional
@Service
@Qualifier(value = "admin")
public class AdminServiceImple extends AbstractService {

	@Autowired
	private AdminDao adao;

	@Override
	public MemberVO addNewMember(MemberVO vo) {
		// 사원의 기본 정보를 가지고 디비에 추가
		adao.addMember(vo);

		// 새 사원에 대한 정보 가져옴
		// 메일에 사원의 정보를 보여주기 위함
		MemberVO nmvo = adao.getNewMemInfo(vo);
		return nmvo;
	}

}
