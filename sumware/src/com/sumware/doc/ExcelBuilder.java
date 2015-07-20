package com.sumware.doc;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.util.IOUtils;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.sumware.dto.MemberVO;

public class ExcelBuilder extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String,String> map = (Map<String, String>) model.get("map");
		ArrayList<MemberVO> mgrList = (ArrayList<MemberVO>) model.get("mgrList");
		int mgrSize =mgrList.size();
		for(Map.Entry<String, String> m : map.entrySet()){
			System.out.println(m.getKey()+" :Excel: "+m.getValue());
		}
		System.out.println("list size::"+mgrList.size());
		HSSFSheet sheet = workbook.createSheet(map.get("stitle"));
		sheet.setDefaultColumnWidth(16);
		//Excel Style
		CellStyle style = workbook.createCellStyle();
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setFillForegroundColor(HSSFColor.WHITE.index);
		for(int i=0; i<40; i++){
			HSSFRow header = sheet.createRow(i);
			for(int j=1; j<=7; j++){
				header.createCell(j).setCellValue("");
				header.getCell(j).setCellStyle(style);
			}
		}
		
		HSSFRow header = sheet.createRow(1);
		header.createCell(1).setCellValue("문서번호:");
		header.createCell(2).setCellValue(map.get("formnum"));
		header.getCell(1).setCellStyle(style);
		header.getCell(2).setCellStyle(style);
		for(int a=3;a<=7; a++){
			header.createCell(a);
			header.getCell(a).setCellStyle(style);
		}
		for(int j = 2; j<=3; j++){
			HSSFRow aheader = sheet.createRow(j);
			for(int i = 0; i<mgrSize; i++){
				if(j==2){
					aheader.createCell(3+(4-mgrSize)+i).setCellValue(mgrList.get(i).getMemname());
				}else{
					InputStream is = new FileInputStream("C:\\sumware\\project\\ws\\sumware\\WebContent\\resources\\signImg\\"+mgrList.get(i).getMemsignimg());
					byte[] bytes = IOUtils.toByteArray(is);
					int pictureIdx = workbook.addPicture(bytes, Workbook.PICTURE_TYPE_JPEG);
					is.close();
					
					CreationHelper helper = workbook.getCreationHelper();
					Drawing drawing = sheet.createDrawingPatriarch();
					ClientAnchor anchor = helper.createClientAnchor();
					anchor.setCol1(3+(4-mgrSize)+i);
					anchor.setRow1(j);
					
					Picture pict = drawing.createPicture(anchor, pictureIdx);
					pict.resize(1, 5);
					
				}
			}
			for(int a=1;a<=7; a++){
				if(j==2){
					if(a<3+(4-mgrSize)||a>=(3+(4-mgrSize)+mgrSize)){
						aheader.createCell(a);
					}
				}else{
					aheader.createCell(a);
				}
				aheader.getCell(a).setCellStyle(style);
			}
		}
		int i = 9;
		int a = 1;
		
		HSSFRow body=null;
		StringBuffer sb = new StringBuffer();
		for(Map.Entry<String, String> m : map.entrySet()){
			if((!m.getKey().startsWith("sg"))&&(!m.getKey().equals("snum"))&&(!m.getKey().startsWith("step"))&&(!m.getKey().equals("formnum"))){
				if(i!=a){
					body = sheet.createRow(i);
					for(int j=1;j<=7; j++){
						body.createCell(j);
						body.getCell(j).setCellStyle(style);
					}
				}
				if(!m.getValue().isEmpty()&&m.getValue()!=null){
					if(m.getKey().equals("memname")){
						body.createCell(1).setCellValue("기안자:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("startdate")){
						body.createCell(1).setCellValue("기안일:");
						sb.append(m.getValue());
						a=i;
						continue;
					}else if(m.getKey().equals("enddate")){
						sb.append(" ~ ").append(m.getValue());
						body.createCell(2).setCellValue(sb.toString());
					}else if(m.getKey().equals("stitle")){
						body.createCell(1).setCellValue("제목:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("sdate")){
						body.createCell(1).setCellValue("일시:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("stitle")){
						body.createCell(1).setCellValue("제목:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("splace")){
						body.createCell(1).setCellValue("장소:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("scont")){
						body.createCell(1).setCellValue("내용:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("sreason")){
						body.createCell(1).setCellValue("사유:");
						body.createCell(2).setCellValue(m.getValue());
					}else if(m.getKey().equals("sps")){
						body.createCell(1).setCellValue("특이사항:");
						body.createCell(2).setCellValue(m.getValue());
					}
					body.getCell(1).setCellStyle(style);
					body.getCell(2).setCellStyle(style);
					i=i+2;
					
				}
			}else{
				continue;
			}
		}
		response.setContentType("Application/Msexcel");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename="+map.get("stitle")+"_exce.xls;");
		
	}

}
