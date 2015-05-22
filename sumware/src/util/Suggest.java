package util;

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
		String path = "C:\\sumware\\project\\ws\\sumware\\WebContent\\xml\\nameMailList.xml"; 
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
		while(it.hasNext()){
			String result = it.next().getChild("name").getText();
			
			// 사용자가 입력한 값으로 시작하는 것인지 판별하는 조건문
			if(result.startsWith(key)){
				sugList.add(result);
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
	
	public static void main(String[] args) {
		Suggest su = new Suggest();
		String[] re = su.getSuggest("김");
		for(String e: re){
			System.out.println(e);
		}
	}
}
