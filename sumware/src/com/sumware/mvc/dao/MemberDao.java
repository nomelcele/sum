package com.sumware.mvc.dao;
import java.util.HashMap;
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
	public void update(HashMap<String, String> map){
		
		st.update("mem.update",map);
		//SqlSession ss= FactorySrevice.getFactory().openSession(true);
		//ss.update("mem.update",map);
				//ss.close();
		//uSystem.out.println("xml �뙆�씪 �뾽�뜲�씠�듃");
		MakeXML.updateXML(); 
		
		
	}
	
	//회원 정보 수정 
	public void modify(HashMap<String, String> map){
		st.update("mem.modify",map);
		//SqlSession ss = FactorySrevice.getFactory().openSession(true);
		//ss.update("mem.modify",map);
		//ss.close();
	}
	
	
	//
	public void addMember(HashMap<String, String> map){
		st.insert("mem.addMember",map);
		//SqlSession ss = FactorySrevice.getFactory().openSession(true);
		//ss.insert("mem.addMember",map);
		//ss.close();
	}
	
	//
	public List<MemberVO> getMemMgr(int memdept){
		
	
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//List<MemberVO> alist = ss.selectList("mem.getMemMgr",memdept);
		
		//ss.close();
		return st.selectList("mem.getMemMgr",memdept);
	//내일 물어보기	
	}
	
//
	public MemberVO getNewMemInfo(String memmail ){
		
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//MemberVO vo = ss.selectOne("mem.getNewMemInfo",memmail);
		//ss.close();
		return st.selectOne("mem.getNewMemInfo",memmail);
		
	}
}
