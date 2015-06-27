package com.sumware.mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MemberVO;
import com.sumware.dto.MessengerRoomVO;
import com.sumware.dto.MessengerVO;

import conn.ConUtil;

@Repository
public class MessengerDao {
	@Autowired
	private SqlSessionTemplate st;
	
	// insertCreateRoom 메서드//////////////////////////////////////////
	public int getNewRoomNum(){
		//방번호 얻기
		return st.selectOne("messenger.getNewRoomNum");

	}
	
	public void insertRoomInfo(MessengerRoomVO mrvo){
		// 얻은 방번호로 mastertable에 정보 저장, 방번호, 사용자 ip
		st.insert("messenger.insertRoomInfo", mrvo);
	}
	
	public void insertRoomForTeamMgr(MessengerVO mevo){
		// 방장인 경우 시작일만 지정
		// 방번호, 참여자 번호, 방장 여부, 사용자 ip 저장
		st.insert("messenger.insertRoomForTeamMgr", mevo);
	}
	
	// hostip 반환
	public String getHostIp(MessengerVO mevo){
		// 참여자인 경우
		// master table에서 해당 방번호의 ip 주소를 얻어 옴
		return st.selectOne("messenger.getHostIp", mevo);
	}
	
	// 참여자인 경우 시작, 종료일은 null값을 db에 저장
	// hostip set해서 넣을 것
	public void insertRoomForMem(MessengerVO mevo){
		st.insert("messenger.insertRoomForMem", mevo);
	}

	///// insertCreateRoom 메서드//////////////////////////////////////////
	
	
	public List<MessengerVO> gettentList(int userNum){
		return st.selectList("messenger.gettentList", userNum);
	}
	
	//방 갯수 확인
	public int countRoomNum(int userNum){
		return st.selectOne("messenger.countRoomNum", userNum);
	}
	
	// 방 입장
	public void joinRoom(MessengerVO mevo){
		st.update("messenger.joinRoom", mevo);
	}
	
	
	////closeRoom 메서드 //////////////////////////////////////////
	
	public void updateRoomDate(MessengerVO mevo){
		st.update("messenger.updateRoomDate", mevo);
	}
	
	public List<MessengerRoomVO> getMesNums(){
		return st.selectList("messenger.getMesNums");
	}
	
	public void upMemMaster(MessengerRoomVO mrvo){
		st.update("messenger.upMemMaster", mrvo);
	}
	
	public void upMesEntry(MessengerRoomVO mrvo){
		st.update("messenger.upMesEntry", mrvo);
	}
	
	/////closeRoom 메서드 ///////////////////////////////////////////
	
	//
	public List<MemberVO> getList(int userNum){
		return st.selectList("messenger.getList");
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	// 로그인한 회원, 접속자는 제외하여 출력
//	public ArrayList<MemberVO> getList(int userNum){
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
//		StringBuffer sql = new StringBuffer();
//		
//		// 로그인 된 회원만 조회하여 출력
//		sql.append("select DISTINCT m.memnum, m.memname, m.memprofile, d.dename, g.LOCHECK ");
//		sql.append("from member m, dept d, login g ");
//		sql.append("where m.memdept=d.denum and m.memnum=g.LOMEM and g.LOCHECK='t' order by d.dename,m.memname");
//		try {
//			con = ConUtil.getOds();
//			pstmt = con.prepareStatement(sql.toString());
//			rs = pstmt.executeQuery();
//			
//			while (rs.next()) {
//				if(userNum != rs.getInt("memnum")){
//				MemberVO v = new MemberVO();
//				v.setMemnum(rs.getInt("memnum"));
//				v.setMemname(rs.getString("memname"));
//				v.setMemprofile(rs.getString("memprofile"));
//				v.setDename(rs.getString("dename"));
//				list.add(v);
//				System.out.println("Dao 사원 이름 : "+v.getMemname());	
//				}else{ System.out.println("else 입니다.");}
//			}
//			System.out.println("Dao에서의 Array Size : "+list.size());
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally{
//			try {
//				if(con != null) CloseUtil.close(con);
//				if(pstmt != null) CloseUtil.close(pstmt);
//				if(rs != null) CloseUtil.close(rs);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		} return list;
//	}
	
	
	
	
	
	
	
	
	
	
	// 그냥 전체 사원 List를 출력하는 메서드
//	public ArrayList<MemberVO> getList(){
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
//		StringBuffer sql = new StringBuffer();
//		
//		// 로그인 된 회원만 조회하여 출력
//		sql.append("select m.memnum, m.memname, m.memaddr, m.memprofile, m.meminmail, d.dename from member m,");
//		sql.append(" dept d where m.memdept=d.denum order by d.dename,m.memname");
//		
//		try {
//			con = ConUtil.getOds();
//			pstmt = con.prepareStatement(sql.toString());
//			rs = pstmt.executeQuery();
//			
//			while (rs.next()) {
//				MemberVO v = new MemberVO();
//				v.setMemnum(rs.getInt("memnum"));
//				v.setMemname(rs.getString("memname"));
//				v.setMemaddr(rs.getString("memaddr"));
//				v.setMemprofile(rs.getString("memprofile"));
//				v.setMemmail(rs.getString("meminmail"));
//				v.setDename(rs.getString("dename"));
//				list.add(v);
//				System.out.println("Dao 사원 이름 : "+v.getMemname());
//			}
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally{
//			try {
//				if(con != null) CloseUtil.close(con);
//				if(pstmt != null) CloseUtil.close(pstmt);
//				if(rs != null) CloseUtil.close(rs);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		} return list;
//	}

}
