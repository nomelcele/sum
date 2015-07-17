package com.sumware.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MemberVO;
import com.sumware.dto.SignatureVO;
import com.sumware.mvc.dao.SignDao;
@Transactional
@Service
@Qualifier(value="sign")
public class SignServiceImple extends AbstractService{
	@Autowired
	private SignDao sgdao;
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
	@Override
	public String[] getMgrNames(String[] memnum) {
		String[] str=new String[memnum.length];
		for(int i=0; i<memnum.length; i++){
			str[i]=sgdao.getMgrName(Integer.parseInt(memnum[i]));
		}
		return str;
	}
	@Override
	public void insertSignService(SignatureVO sgvo,
			List<HashMap<String, String>> mgrList) {
		sgdao.writeSf(sgvo);
		String stepsnum = String.valueOf(sgdao.getMax());
		for(Map<String,String> map : mgrList){
			map.put("stepsnum", stepsnum);
			sgdao.writeSignStep(map);
		}
	}
	@Override
	public void setNowmemService(int snum) {
		int nowmemnum=sgdao.getNowmem(snum);
		System.out.println("nowmemnum::"+nowmemnum);
		if(nowmemnum != 0){
			HashMap<String, Integer> setNow = new HashMap<String, Integer>();
			setNow.put("snum", snum);
			setNow.put("nowmemnum",nowmemnum );
			sgdao.setNowmem(setNow);
		}
	}
	
	
}
