package com.sumware.mvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sumware.dto.ConferenceVO;
import com.sumware.mvc.dao.ConferenceDao;

@Transactional
@Service
@Qualifier(value="index")
public class IndexServiceImple extends AbstractService {
	@Autowired
	private ConferenceDao cdao;
	
	@Override
	public String confNotify(int confmem) {
		ConferenceVO confvo = cdao.getConfurl(confmem);
		String confurl = confvo.getConfurl();
		int confnum = confvo.getConfnum();
		cdao.deleteConfnum(confnum);
		
		return confurl;
	}
	
	
}
