package com.sumware.util;

import java.util.Enumeration;
import java.util.HashMap;


import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

public class MyMap {
	private static MyMap maps;
	public static synchronized MyMap getMaps() {
		if(maps == null) maps = new MyMap();
		return maps;
	}
public HashMap<String, String> getMapList(HttpServletRequest request){
		// 요청시 request객체로 부터 파라미터값을 자동으로 얻어 오기 위해서
		//getParameterNames()사용해서 얻어온 파라미터 이름값을 
		//Enumeration으로 저장한다.
		Enumeration<String> params = request.getParameterNames();
		 HashMap<String, String> parms = new HashMap<>();
	      String parmName;
	      String parmValue;
	   // 이름을 Enumeration에서 하나씩 뽑으면서 HashMap에
	      // 이름과 값으로 저장한다.
	     while (params.hasMoreElements())
	      {
	         parmName = params.nextElement();
	         parmValue = request.getParameter(parmName);
	         parms.put(parmName, parmValue);
	      }
	     System.out.println("자동 파라미터 받기 시작 : --------");
	      for(Map.Entry<String, String> e : parms.entrySet()){
	    	  System.out.println(e.getKey()+":"+e.getValue());
	      }
	      System.out.println("자동 파라미터 받기 끝 : --------");
	      return parms;
	}

}
