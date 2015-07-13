package com.sumware.doc;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.sumware.dto.MemberVO;

public class ExcelBuilder extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String,String> map = (Map<String, String>) model.get("map");
		ArrayList<MemberVO> mgrList = (ArrayList<MemberVO>) model.get("mgrList");
		for(Map.Entry<String, String> m : map.entrySet()){
			System.out.println(m.getKey()+" :Excel: "+m.getValue());
		}
		System.out.println("list size::"+mgrList.size());
		HSSFSheet sheet = workbook.createSheet(map.get("stitle"));
		HSSFRow header = sheet.createRow(0);
		header.createCell(0).setCellValue("문서번호:");
		header.createCell(1).setCellValue(map.get("formnum"));
		
		for(int j = 1; j<=2; j++){
			HSSFRow aheader = sheet.createRow(j);
			for(int i = 0; i<mgrList.size(); i++){
				if(j==1){
					aheader.createCell(3+i).setCellValue(mgrList.get(i).getMemname());
				}else{
					aheader.createCell(3+i).setCellValue(mgrList.get(i).getMemsignimg());
				}
			}
		}
		int i = 3;
		for(Map.Entry<String, String> m : map.entrySet()){
			if((!m.getKey().startsWith("sg"))&&(!m.getKey().equals("snum"))&&(!m.getKey().startsWith("step"))&&(!m.getKey().equals("formnum"))){
				HSSFRow body = sheet.createRow(i++);
				if(!m.getValue().isEmpty()){
					body.createCell(0).setCellValue(m.getKey());
					body.createCell(1).setCellValue(m.getValue());
				}
			}else{
				continue;
			}
		}
		response.setContentType("Application/Msexcel");
		response.setHeader("Content-Disposition", "attachment; filename="+map.get("stitle")+"_exce.xls;");
		
	}

}
