package com.sumware.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.jdom2.output.Format.TextMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sumware.dto.MemberVO;
import com.sumware.mvc.dao.MemberDao;

import conn.ConUtil;

@Component
public class MakeXML {
	// db를 읽어서 xml 파일로 생성하는 클래스
	// db는 계속 갱신될 수 있기 때문에 새로운 회원이 추가되면 xml 파일에도 적용되어야 한다.
	
	@Autowired
	private MemberDao dao;
	
	public void updateXML(){
		//  autowired
		// dao = new MemberDao();
		System.out.println("null????????????");
		System.out.println(dao.getNameMailList());
		
		List<MemberVO> list = dao.getNameMailList();

		// 사원 이름, 내부 메일 주소(아이디)가 저장된 리스트를 읽어서 
		// root의 자식 엘리먼트로 설정
		Element root = new Element("sumware");
		for(MemberVO e:list){
			// 엘리먼트 생성
			Element mem = new Element("member");
			Element name = new Element("name");
			Element inmail = new Element("inmail");
			
			// 엘리먼트에 값 설정(이름, 아이디)
			name.setText(e.getMemname());
			inmail.setText(e.getMeminmail());
			
			// 구조적 배치
			/*
			 * <sumware>
			 * 		<member>
			 * 			<name>김길동</name>
			 * 			<inmail>gildong</inmail>
			 * 		</member>
			 * </sumware>
			 */
			mem.addContent(name);
			mem.addContent(inmail);
			root.addContent(mem);
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
			xo.output(doc, new FileOutputStream("C:\\sumware\\project\\ws\\sumware\\WebContent\\xml\\nameMailList.xml"));
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		
	}
	
}
