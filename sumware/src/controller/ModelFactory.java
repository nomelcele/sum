package controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import model.ModelInter;

import org.apache.coyote.http11.filters.BufferedInputFilter;

public class ModelFactory {
	// 싱글톤
	private static ModelFactory mf;
	private Properties prop;
	
	private ModelFactory(){
		prop = new Properties();
	}
	public static synchronized ModelFactory getMf(){
		if(mf == null){
			mf = new ModelFactory();
		}
		return mf;
	}
	
	// 컨트롤러에서 받아온 파라미터의 값을 인자로 갖는다.
	public ModelInter getModel(String mod){
		// model 을 선택 하기 위해 요청이온 parameter 의 값으로 해당모델의 
		// 클래스명을 뽑아 오기 위한 properties 파일의 경로
		String path = "C:\\sumware\\project\\ws\\sumware\\src\\controller\\modelchoice.txt";
		ModelInter model = null;
		try {
			// path 의 경로에 있는 파일을 읽어온다.
			prop.load(new BufferedInputStream(new FileInputStream(path)));
			// 새로운 변수 rpath 에 요청온 파라미터의 값으로 properties 의 값을 
			// 가져온다. 이 값은 곧 model 의 클래스명이 된다.
			String rpath = prop.getProperty(mod);
			System.out.println(rpath);
			// 만약 들어온 요청의 값이 없을 경우 기본 페이지로 이동 시키는 로직
			if(mod == null){
				mod = "index";
				rpath = prop.getProperty(mod);
			}
			// 클래스명만으로 객체를 생성 해주기 위한 
			// java 에서 제공하는 Class 객체 사용.
			// Class.forName("클래스명") 을 사용하여 해당 클래스를 로드 해온다.
			Class<ModelInter> handler = (Class<ModelInter>) Class.forName(rpath);
			// newInstance() 를 통해서 로드해온 클래스를 객체화(instance화) 시킨다.
			model = handler.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
}
