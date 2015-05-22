package util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.jdom2.output.Format.TextMode;

import conn.ConUtil;
import dao.MemberDao;
import dto.MemberVO;

public class MakeXML {
	/*
	 * db를 읽어서 xml 파일로 생성하는 클래스
	 * <sumware>
	 * 		<member>김길동</member>
	 * <sumware>
	 * 
	 * root는 sumware
	 * */
	
	// 어디서 호출되어야?
	// db는 계속 갱신될 수 있기 때문에...
	// 새로운 회원이 추가되면 xml 파일에도 적용되어야 한다.
	
	// 일단 테스트
	public static void updateXML(){
		ArrayList<String> list = MemberDao.getDao().getInmailList();

		// 아이디가 저장된 리스트를 읽어서 root의 자식 엘리먼트로 설정
		Element root = new Element("sumware");
		for(String e:list){
			root.addContent(new Element("member").setText(e));
		}
		
		// 문서 객체 생성
		Document doc = new Document();
		doc.setRootElement(root);
		
		// 문서 객체를 읽어서 xml 생성
		XMLOutputter xo = new XMLOutputter();
		Format f = xo.getFormat();
		f.setEncoding("UTF-8");
		f.setIndent(" ");
		f.setLineSeparator("\r\n");
		f.setTextMode(TextMode.TRIM);
		xo.setFormat(f); // 설정을 xo 객체에 초기화
		
		try {
			xo.output(doc, System.out);
			xo.output(doc, new FileOutputStream("C:\\sumware\\project\\ws\\sumware\\WebContent\\xml\\inmailList.xml"));
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		
	}
	
}
