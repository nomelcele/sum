package com.sumware.mvc.dao;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sumware.dto.MemberVO;
import com.sumware.util.MakeXML;


@Repository
public class MemberDao {
	//private static MemberDao dao;

	//public synchronized static MemberDao getDao() {
		//if(dao == null) dao = new MemberDao();
		//return dao;
	//}
	@Autowired
	private SqlSessionTemplate st;
	

	//메일 에서 사용??
	public List<MemberVO> getNameMailList(){
		System.out.println("들어오니?");
		return st.selectList("mem.getNameMailList");

		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//List<MemberVO> list = ss.selectList("mem.getNameMailList");
		//ss.close();
		//return list;
	}
	
	//아이디 중복 검사 할때 
	public int ckid(String meminmail){
		
		//int result = 0;
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//result=ss.selectOne("mem.ckid",meminmail);
		//ss.close();
		return st.selectOne("mem.ckid",meminmail);
	}
	
	
	//회원 정보 업데이트 
	public void update(MemberVO vo){
		
		st.update("mem.update",vo);
		//SqlSession ss= FactorySrevice.getFactory().openSession(true);
		//ss.update("mem.update",map);
				//ss.close();
		//uSystem.out.println("xml �뙆�씪 �뾽�뜲�씠�듃");
		new MakeXML().updateXML();
		
		
	}
	
	//회원 정보 수정 
	public void modify(MemberVO vo){
		System.out.println("memprofile::"+vo.getMemprofile());
		st.update("mem.modify",vo);
		//SqlSession ss = FactorySrevice.getFactory().openSession(true);
		//ss.update("mem.modify",map);
		//ss.close();
	}
	
	
	
//

}
