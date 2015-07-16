package com.sumware.mvc.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DownloadModel {

	
	private static final int BUFFER_SIZE = 4096;
	// 다운로드 요청에 대한 HandlerMapping !!
		// 이미 업로드 된 경로에서 파일 다운로드를 할 것이기 때문에 
		// 리스트나 뷰에서 해당 파일의 이름을 받아와야 한다.
		// -> @RequestParam("fileName") String fileName
		// ServletContext 와 파일의 절대 경로를 얻어내기 위해서
		// -> HttpSession session, HttpServletRequest request
		// 다운로드란, 브라우저와 Stream 으로 연결 되어서 통신 되어야 하기 때문에....
		// -> HttpServletResponse response
	@RequestMapping(value="/sadownloadFile")
	   public void fileDown(@RequestParam("fileName") String fileName,
	         HttpSession session, HttpServletRequest request,
	         HttpServletResponse response) throws IOException{
			// applicationContext 객체를 request로 부터 얻어냄
	      ServletContext context = request.getServletContext();
	   // 업로드된 경로를 얻고,
	      String path = session.getServletContext().getRealPath("/upload/")+fileName;
	   // 그 경로로 파일객체를 생성한다.
	      File downloadFile = new File(path);
	   // FileInputStream 로 파일을 읽어옴.
	      FileInputStream fi = new FileInputStream(downloadFile);
	  	// 요청객체로 부터 연결된 브라우저의 마임타입을 얻어냄.
	      String mimeType = context.getMimeType(path);
	   // 만약 마임타입 값이 없으면 그냥 디폴트로 스트림으로 연결.
	      if(mimeType == null){
	         mimeType = "application/octet-stream";
	      }
	   // 지정된 마입타입 세팅
	      response.setContentType(mimeType);
	   // 다운로드될 파일의 길이 세팅
	      response.setContentLength((int) downloadFile.length());
	   // response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
	      // response.setHeader("Content-Transfer-Encoding", "binary");
	      
	      // download는 response
	      
	      // set headers for the response
	      // 다운로드 Type을 설정함
	      String headerKey = "Content-Disposition";
	      String headerValue = String.format("attachment;filename=\"%s\"",downloadFile.getName());
	   // 위의 다운로드 타입의 정보를 헤더로 설정
	      response.setHeader(headerKey, headerValue);
	      // 브라우저로부터 스트림을 연결
	      OutputStream outStream = response.getOutputStream();
	      
	   // 버퍼를 끼워서 빠르게 전달 목적
	      byte[] buffer = new byte[BUFFER_SIZE];
	   // 이제 브라우저로 보내고, 자원 닫으면 끝
	      int bytesRead = -1;
	      
	      // write bytes read from the input stream into the output
	      while((bytesRead = fi.read(buffer)) != -1){
	         outStream.write(buffer,0,bytesRead);
	      }
	      
	      fi.close();
	      outStream.close();
	            
	   }
}
