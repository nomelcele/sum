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
	

	
	public List<MemberVO> getNameMailList(MemberVO vo){
		return st.selectList("mem.getNameMailList",vo);
		
		
		
		// �궗�썝�쓽 �씠由꾧낵 �궡遺� 硫붿씪 二쇱냼瑜� 媛��졇�삤�뒗 硫붿꽌�뱶
		// (suggest 湲곕뒫�쓣 �쐞�븳 xml �뙆�씪 留뚮뱶�뒗 �뜲 �궗�슜)
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//List<MemberVO> list = ss.selectList("mem.getNameMailList");
		//ss.close();
		//return list;
	}
	public int ckid(String meminmail){
		
		//int result = 0;
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//result=ss.selectOne("mem.ckid",meminmail);
		//ss.close();
		return st.selectOne("mem.ckid",meminmail);
	}
	
	public void update(MemberVO vo){
		
		st.update("mem.update",vo);
		//SqlSession ss= FactorySrevice.getFactory().openSession(true);
		//ss.update("mem.update",map);
				//ss.close();
		//uSystem.out.println("xml �뙆�씪 �뾽�뜲�씠�듃");
		MakeXML.updateXML(); 
		// �궗�썝�쓽 �씠由�+�븘�씠�뵒媛� ���옣�맂 xml �뙆�씪
		// �쉶�썝�씠 異붽��맆 �븣留덈떎 �뾽�뜲�씠�듃
		
	}
	
	/// �쉶�썝 �젙蹂� �닔�젙
	public void modify(MemberVO vo){
		st.update("mem.modify",vo);
		//SqlSession ss = FactorySrevice.getFactory().openSession(true);
		//ss.update("mem.modify",map);
		//ss.close();
	}
	
	// �떊�엯 �궗�썝 �뵒鍮꾩뿉 異붽�
	public void addMember(MemberVO vo){
		st.insert("mem.addMember",vo);
		//SqlSession ss = FactorySrevice.getFactory().openSession(true);
		//ss.insert("mem.addMember",map);
		//ss.close();
	}
	
	public List<MemberVO> getMemMgr(int memdept){
		
		// ���옣�젙蹂대뱾 媛��졇�샂
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//List<MemberVO> alist = ss.selectList("mem.getMemMgr",memdept);
		
		//ss.close();
		return st.selectList("mem.getMemMgr",memdept);
	//내일 물어보기	
	}
	
	// �떊�엯�궗�썝 �젙蹂� 戮묒븘�샂
	public MemberVO getNewMemInfo(String memmail ){
		
		//SqlSession ss = FactorySrevice.getFactory().openSession();
		//MemberVO vo = ss.selectOne("mem.getNewMemInfo",memmail);
		//ss.close();
		return st.selectOne("mem.getNewMemInfo",memmail);
		
	}
}
