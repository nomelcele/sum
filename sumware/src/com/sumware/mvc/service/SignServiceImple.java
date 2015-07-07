package com.sumware.mvc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.SignDao;
@Service
public class SignServiceImple extends AbstractService{
	@Autowired
	SignDao sgdao;
	@Override
	public List<MemberVO> getMgrList(int memnum) {
		ArrayList<MemberVO> mList = new ArrayList<MemberVO>();
		MemberVO mvo;
		while(true){	
			mvo=sgdao.getMgr(memnum);
			System.out.println(mvo.getMemnum()+" 의 상급자는?:"+mvo.getMemmgr());
			if(mvo.getMemnum()==1){
				System.out.println("나가자!");
				break;
			}else{
				mList.add(mvo);
				memnum=mvo.getMemnum();
			}
		}
		return mList;
	}
	

}
