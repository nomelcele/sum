package com.sumware.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

public class Suggest {
	private static Suggest suggest;
	private Document doc;
	private Element root;
	
	public static synchronized Suggest getSuggest(){
		if(suggest == null) suggest = new Suggest();
		return suggest;
	}
	
	public Suggest(){
		SAXBuilder sb = new SAXBuilder();
		// xml 파일의 경로
		String path = "C:\\sumware\\project\\ws\\sumware\\WebContent\\resources\\xml\\nameMailList.xml"; 
		try {
			doc = sb.build(path);
			root = doc.getRootElement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 필요한 값을 얻어내는 메서드
	public String[] getSuggest(String key){
		ArrayList<String> sugList = new ArrayList<String>();
		
		List<Element> list = root.getChildren("member");
		Iterator<Element> it = list.iterator();
		
		// key는 한글->메일 쓰기에서 받는 사람에 사원 이름을 입력하니까
		// toLowerCase 메서드 쓸 필요 없음
		
		// 6) 사원의 이름과 아이디가 저장된 xml 파일을 읽는다.
		while(it.hasNext()){
			Element el = it.next();
			String name = el.getChild("name").getText();
			String inmail = el.getChild("inmail").getText();
			
			// 7) name 태그의 데이터가 사용자가 입력한 문자로 시작하는 경우 리스트에 추가하고
			// 리스트를 String 타입의 배열로 변환 후 리턴해준다.
			if(name.startsWith(key)){
				System.out.println("이름: "+name);
				System.out.println("메일: "+inmail);
				sugList.add(name+" &lt;"+inmail+"@sumware.com&gt;");
			}
		}
		
		int sugSize = sugList.size();
		if(sugSize>0){
			// ArrayList를 배열로 변환
			String[] sugArr = new String[sugSize];
			return sugList.toArray(sugArr);
		}
		
		return null;
		
	}
}
