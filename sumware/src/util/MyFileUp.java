package util;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class MyFileUp {
	private static MyFileUp fup;
	
	public static synchronized MyFileUp getFup() {
		if(fup==null){
			fup = new MyFileUp();
		}
		return fup;
	}

	private String getFileName(Part part){
		String fileName="";
		
		String header= part.getHeader("content-disposition");
		System.out.println(header);
		String [] elements = header.split(";");
		
		//elements에서 filename에 해당하는 데이터 찾기
		for(String element : elements){
			if(element.trim().startsWith("filename")){
				fileName = element.substring(element.indexOf('=')+1);
				fileName = fileName.trim().replace("\"", "");
				
			}
		}
		return fileName;
	}
	public HashMap<String,String> fileUp(String fname,HttpServletRequest request) throws IOException, ServletException{
		request.setCharacterEncoding("euc-kr");
		HashMap<String, String> result = new HashMap<>(); 
		Part part = request.getPart(fname);
		String fileName = getFileName(part);
		result=MyMap.getMaps().getMapList(request);
		result.put(fname, fileName);
		System.out.println("fileName : "+fileName);
		if(fileName != null && fileName.length() != 0){
			part.write(fileName);
		}
		return result;
	}
	
}
