package com.sumware.mvc.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.CalendarVO;
@Repository
public class CalendarDAO {
	@Autowired
	private SqlSessionTemplate st;
	public void calInsert(CalendarVO cavo){
		cavo.setCalstart(timeFomat(cavo.getCalstart()));
		cavo.setCalend(timeFomat(cavo.getCalend()));
		st.insert("calendar.calInsert", cavo);
	}
	
	public List<CalendarVO> getCalList(CalendarVO cavo){
		System.out.println("list를 보자");
		System.out.println(cavo.getCal());
		return st.selectList("calendar.getCalList",cavo);
	}
	public void calDel(int calnum){
		st.delete("calendar.calDel", calnum);
	}
	public String makeJson(List<CalendarVO> list){
		StringBuilder json = new StringBuilder();
		int size=list.size();
		//json.append("[");
		for(int i = 0; i<size; i++){
			CalendarVO v = list.get(i);
			json.append("{title:'").append(v.getCalcont()).append("',");
			json.append("start:'").append(v.getCalstart()).append("',");
			json.append("end:'").append(v.getCalend()).append("',");
			json.append("_id:'").append(v.getCalnum()).append("'}");
			if(!(i ==size-1)){
				json.append(",");
			}
		}
		//json.append("]");
		System.out.println("json:"+json.toString());
		return json.toString();
	}
	private String timeFomat(String time){
		String result=null;
		result = time.replaceAll("T", "");
		System.out.println("timeFomat: "+result);
		return result;
	}
//	public String calSQL(int n){
//		StringBuffer sql = new StringBuffer();
//		if(n==0){ //부서일정
//			sql.append("select calnum,to_char(calstart,'yyyy-MM-DD')||'T'||to_char(calstart,'HH24:mi:ss') calstart,")
//				.append("nvl(to_char(calend,'yyyy-MM-DD')||'T'||to_char(calend,'HH24:mi:ss'),'0') calend,")
//				.append("calcont from calendar where caldept=?");
//		}else if(n==1){ //사원일정
//			sql.append("select calnum,to_char(calstart,'yyyy-MM-DD')||'T'||to_char(calstart,'HH24:mi:ss') calstart,")
//			.append("nvl(to_char(calend,'yyyy-MM-DD')||'T'||to_char(calend,'HH24:mi:ss'),'0') calend,")
//			.append("calcont from calendar where calmem=?");
//		}else if(n==2){
//			sql.append("insert into calendar(calnum,calstart,calend,calcont,caldept)");
//			sql.append(" values(calendar_seq.nextVal,");
//			sql.append("to_date(?,'yyyy-MM-dd-HH24:mi:ss'),to_date(?,'yyyy-MM-dd-HH24:mi:ss'),?,?)");
//		}else if(n==3){
//			sql.append("insert into calendar(calnum,calstart,calend,calcont,calmem)");
//			sql.append(" values(calendar_seq.nextVal,");
//			sql.append("to_date(?,'yyyy-MM-dd-HH24:mi:ss'),to_date(?,'yyyy-MM-dd-HH24:mi:ss'),?,?)");
//		}
//		return sql.toString();
//	}
}
	
