package com.sumware.mvc.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.MailVO;
import com.sumware.mvc.dao.MailDao;

@Transactional
@Service
public class MailServiceImple extends AbstractService{
	@Autowired
	private MailDao mdao;
	
	@Override
	public void setDeleteAttrService(String[] mailnums, Map<String, String> map) {
		for(String e:mailnums){
			MailVO vo = mdao.getDelAttrMailInfo(e);
			
			int mailmem = vo.getMailmem();
			String mailreceiver = vo.getMailreceiver();
			
			if(mailmem == Integer.parseInt(map.get("usernum"))){
				map.put("mailnum", e);
				mdao.setDelAttrFrom(map);
			}
			
			if(mailreceiver.equals(map.get("userid"))){
				map.put("mailnum", e);
				mdao.setDelAttrTo(map);
				
			}
		}
	}
	
}
