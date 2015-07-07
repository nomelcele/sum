package com.sumware.mvc.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MailVO;
import com.sumware.mvc.dao.MailDao;

@Transactional
@Service
@Qualifier(value="mail")
public class MailServiceImple extends AbstractService{
	@Autowired
	private MailDao mdao;
	
	@Override
	public MailVO getDetailUpdate(int mailnum) {
		MailVO detail = mdao.getMailDetail(mailnum);
		if(detail.getMailread().equals("N")){ // 처음 읽은 메일의 경우
			mdao.setMailRead(mailnum); // 읽기 속성 업데이트(N->Y)
		}
		return detail;
	}

	@Override
	public void setDeleteAttrService(String[] mailnums, HashMap<String, String> map) {
		for(String e:mailnums){
			MailVO vo = mdao.getDelAttrMailInfo(e);
			int mailmem = vo.getMailmem(); // 삭제할 메일의 발신자
			String mailreceiver = vo.getMailreceiver(); // 삭제할 메일의 수신자
			if(mailmem == Integer.parseInt(map.get("usernum"))){
				// 삭제할 메일이 로그인한 사용자가 보낸 메일인 경우
				map.put("mailnum", e); // 메일 번호
				mdao.setDelAttrFrom(map);
			}
			if(mailreceiver.equals(map.get("userid"))){
				// 삭제할 메일이 로그인한 사용자가 받은 메일인 경우
				map.put("mailnum", e);
				mdao.setDelAttrTo(map);
			}
		}
	}
	
}
