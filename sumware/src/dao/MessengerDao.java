package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import util.CloseUtil;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

import conn.ConUtil;
import dto.MemberVO;
import dto.MessengerRoomVO;
import dto.MessengerVO;

public class MessengerDao {
	private static MessengerDao dao;

	public static MessengerDao getDao() {
		if(dao == null) dao = new MessengerDao();
		return dao;
	}
	
	public int insertCreateRoom(ArrayList<MessengerVO> list, MessengerRoomVO rv, int mesendNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int key = 0;	
		
		System.out.println(list.size());
		
		try {
			con = ConUtil.getOds();
			StringBuffer sql = new StringBuffer();
			// 방번호 얻기
			sql.append("select mesmaster_seq.nextval from dual");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
			MessengerVO v = new MessengerVO();
			v.setMesnum(rs.getInt("NEXTVAL")); // 방번호 master, mesentry table인지 확인 필요
			key = rs.getInt("NEXTVAL");			
			}
			
			System.out.println("key : "+key);
				
			CloseUtil.close(rs);
			CloseUtil.close(pstmt);
			// StrinBuffer 초기화
			sql.setLength(0);
			

			// 얻은 방번호로 mastertable에 정보 저장, 방번호, 사용자 ip
			sql.append("insert into mesmaster values(?,sysdate,'9999/12/31',?)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, key);
			pstmt.setString(2, rv.getMasreip());
			pstmt.executeUpdate();
			
			
			CloseUtil.close(pstmt);
			sql.setLength(0);
			
			// 참여자 정보 Table에 정보 저장
			
			String openCk= null; // 방장 여부 초기화			
			for(MessengerVO e : list){
				openCk = e.getOpenmemberyn();
				System.out.println("방장여부 : "+openCk);
				if(openCk.equals("Y")){ // 방장인 경우 시작일만 지정
					
					// 방번호, 참여자 번호, 방장 여부, 사용자 ip 저장
					sql.append("insert into mesentry values(?,?,?,sysdate,'9999/12/31',?,?)");						
					pstmt= con.prepareStatement(sql.toString());					
					pstmt.setInt(1, key);
					pstmt.setInt(2, e.getMesmember());
					pstmt.setString(3, e.getOpenmemberyn());
					pstmt.setString(4, e.getMesreip());
					pstmt.setInt(5, e.getMesmember());
					pstmt.executeUpdate();
					
					CloseUtil.close(pstmt);
					sql.setLength(0);
										
					
				}else{ 
					// 참여자인 경우 시작, 종료일은 null값을 db에 저장
					// master table에서 해당 방번호의 ip 주소를 얻어 옴
					String hostIp = null;
					sql.append("select masreip from mesmaster where masnum=?");
					pstmt=con.prepareStatement(sql.toString());
					pstmt.setInt(1, key);
					rs = pstmt.executeQuery();
					
					// 방장은 1명
					while(rs.next()){
						hostIp = rs.getString("masreip");
					}
					
					
					sql.setLength(0);
					
					sql.append("insert into mesentry values(?,?,?,null,null,?,?)");
					pstmt= con.prepareStatement(sql.toString());					
					pstmt.setInt(1, key);
					pstmt.setInt(2, e.getMesmember());
					pstmt.setString(3, e.getOpenmemberyn());
					pstmt.setString(4, hostIp);
					pstmt.setInt(5, mesendNum);
					
					pstmt.executeUpdate();
					
					CloseUtil.close(rs);
					CloseUtil.close(pstmt);
				}
				sql.setLength(0);
			}
			sql.setLength(0);
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
				if(rs != null) CloseUtil.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return key;
		
	}
	
	// 방이 종료 되었을 경우를 추가하기 
	// 방은 요청자가 신청 후 그냥 나간 경우
	public ArrayList<MessengerVO> getentList(int userNum){
		System.out.println("Messenger getentList 영역입니다.");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MessengerVO> list = new ArrayList<MessengerVO>();
		StringBuffer sql = new StringBuffer();
		// 참가자 사번, 시작일이 null인 사원만 리스트로 출력
		sql.append("select mesnum, mesmember, openmemberyn, entstdate, mesendnum from mesentry where mesmember=? and openmemberyn='N' and entstdate is null");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MessengerVO v = new MessengerVO();
				v.setMesnum(rs.getInt("mesnum"));
				v.setMesmember(rs.getInt("mesmember"));
				v.setOpenmemberyn(rs.getString("openmemberyn"));
				v.setEntstdate(rs.getString("entstdate"));
				v.setMesendnum(rs.getInt("mesendnum"));
				System.out.println("시작일 : "+v.getEntstdate());
				list.add(v);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
				if(rs != null) CloseUtil.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}return list;
	}
	
	public void joinRoom(MessengerVO v){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		sql.append("update mesentry set entstdate = sysdate, entendate = '9999/12/31' where mesnum=? and mesmember=? and openmemberyn='N'");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());			
//			pstmt.setString(1, v.getMesreip());
			pstmt.setInt(1, v.getMesnum());
			pstmt.setInt(2, v.getMesmember());
			
			System.out.println("joinRoome의 ip : "+v.getMesreip());
			System.out.println("joinroom의 방번호 : "+v.getMesnum());
			System.out.println("joinRoom의 유저 번호 : "+v.getMesmember());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
	}
	// main과 room에서 넘어온 data인지 확인
	public void closeRoom(MessengerVO v, String resState){
		System.out.println("Dao의 CloseRoom 영역입니다.");
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		// 채팅창에서 넘어온 data : 종료일만 변경
		if(resState.equals("room")){
			sql.append("update mesentry set entendate = sysdate where mesnum=? and mesmember=?");			
			System.out.println("room의 if문");			
			// messenger main에서 넘어온 data, 시작과 종료일을 변경
		}else if(resState.equals("mesMain")){
			sql.append("update mesentry set entstdate = sysdate, entendate = sysdate where mesnum=? and mesmember=?");
			System.out.println("mesMain의 if문");
		}else{
			System.out.println("이게 출력되면 망한거임!!");
		}
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, v.getMesnum());
			pstmt.setInt(2, v.getMesmember());
			pstmt.executeUpdate();
			
			System.out.println("Dao의 방번호 : "+v.getMesnum());
			System.out.println("Dao의 사용자 번호 : "+v.getMesmember());
			
			// 방 종료 설정을 진행
			
			
			
		} catch (SQLException e) {

			e.printStackTrace();
		}finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
	}
	
	
	public ArrayList<MemberVO> getList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		StringBuffer sql = new StringBuffer();
		sql.append("select m.memnum, m.memname, m.memaddr, m.memprofile, m.meminmail, d.dename from member m,");
		sql.append(" dept d where m.memdept=d.denum order by d.dename,m.memname");
		
		try {
			con = ConUtil.getOds();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MemberVO v = new MemberVO();
				v.setMemnum(rs.getInt("memnum"));
				v.setMemname(rs.getString("memname"));
				v.setMemaddr(rs.getString("memaddr"));
				v.setMemprofile(rs.getString("memprofile"));
				v.setMemmail(rs.getString("meminmail"));
				v.setDename(rs.getString("dename"));
				list.add(v);
				System.out.println("Dao 사원 이름 : "+v.getMemname());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(con != null) CloseUtil.close(con);
				if(pstmt != null) CloseUtil.close(pstmt);
				if(rs != null) CloseUtil.close(rs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} return list;
	}

}
