package com.sumware.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sumware.dto.MailVO;

@Repository
public class MailDao {
	@Autowired
	private SqlSessionTemplate st;
	
	public void addMail(Map<String, String> map){
		st.insert("mail.addMail", map);
		
//			sql.append("insert into mail values(mail_seq.nextVal,?,?,?,?,?,sysdate,1,1)");
//			pstmt = con.prepareStatement(sql.toString());
//			
//			pstmt.setString(1, map.get("mailtitle")); 
//			pstmt.setString(2, map.get("mailcont"));
//			pstmt.setString(3, map.get("mailfile"));
//			pstmt.setInt(4, Integer.parseInt(map.get("usernum")));
//			
//			int startidx = map.get("mailreceiver").indexOf("<")+1;
//			int endidx = map.get("mailreceiver").indexOf("@");
//			String mailreceiver = map.get("mailreceiver").substring(startidx, endidx); 
//			pstmt.setString(5, mailreceiver);
//			System.out.println("받는 사람 아이디: "+mailreceiver);
//			pstmt.executeUpdate();
		
	}
	
	public List<MailVO> getFromMailList(Map<String, String> map){
		// 받은 메일 리스트를 불러오는 메서드
		// 현재 로그인되어 있는 사원이 받은 메일만 불러와야 한다.
		return st.selectList("mail.getFromMailList", map);

//			sql.append("select * from (select rownum r_num, a.* from (");
//			sql.append("select ma.mailnum, me.memname, ma.mailtitle, ma.maildate");
//			sql.append(" from member me, mail ma where me.memnum=ma.mailmem and ma.mailreceiver=?");
//			sql.append(" and ma.mailrdelete=1 and not ma.mailmem=? order by ma.maildate desc) a)");
//			sql.append(" where r_num between ? and ?");
//			
//			
//			// 현재 로그인한 사원에게 온 메일만 검색
//			pstmt = con.prepareStatement(sql.toString());
//			pstmt.setString(1, map.get("userid"));
//			pstmt.setInt(2, Integer.parseInt(map.get("usernum")));
//			pstmt.setInt(3, Integer.parseInt(map.get("begin")));
//			pstmt.setInt(4, Integer.parseInt(map.get("end")));
//			rs = pstmt.executeQuery();
			
	}
	
	public List<MailVO> getToMailList(Map<String, String> map){
		// 보낸 메일 리스트를 불러오는 메서드
		return st.selectList("mail.getToMailList", map);
			
//			sql.append("select * from (select rownum r_num, a.* from (");
//			sql.append("select ma.mailnum, me.memname, ma.mailtitle, ma.maildate");
//			sql.append(" from member me, mail ma where me.meminmail=ma.mailreceiver and ma.mailmem=?");
//			sql.append(" and ma.mailsdelete=1 and not ma.mailreceiver=? order by ma.maildate desc) a)");
//			sql.append(" where r_num between ? and ?");
		
			
	}
	
	public List<MailVO> getMyMailList(Map<String, String> map){
		// 내게 쓴 메일 리스트를 불러오는 메서드
		return st.selectList("mail.getMyMailList", map);

//			sql.append("select * from (select rownum r_num, a.* from (");
//			sql.append("select ma.mailnum, ma.mailtitle, ma.maildate, me.memname");
//			sql.append(" from member me, mail ma where me.memnum=ma.mailmem and ma.mailmem=?");
//			sql.append(" and ma.mailreceiver=? and ma.mailsdelete=1 and ma.mailrdelete=1 order by ma.maildate desc) a)");
//			sql.append(" where r_num between ? and ?");
			
	}
	
	public MailVO getMailDetail(int mailnum){
		// 메일 상세 보기 정보를 불러오는 메서드
		return st.selectOne("mail.getMailDetail", mailnum);

//			sql.append("select ma.mailtitle, me1.memname mailsname, me2.memname mailrname, ma.maildate,");
//			sql.append(" ma.mailcont, ma.mailfile, me1.meminmail replyid, ma.mailreceiver");
//			sql.append(" from mail ma, member me1, member me2");
//			sql.append(" where me1.memnum=ma.mailmem and me2.meminmail=ma.mailreceiver and ma.mailnum=?");
//			pstmt = con.prepareStatement(sql.toString());
//			pstmt.setInt(1, mailnum);
//			rs = pstmt.executeQuery();
		
	}
	
	public MailVO getDelAttrMailInfo(String num){
		return st.selectOne("mail.getDelAttrMailInfo", num); // 오류
	}
	
	public void setDelAttrFrom(Map<String,String> map){
		st.update("mail.setDelAttrFrom", map);
	}
	
	public void setDelAttrTo(Map<String,String> map){
		st.update("mail.setDelAttrTo", map);
	}
	
//	public void setDeleteAttr(String[] mailnums, Map<String, String> map){
		// 메일의 delete 속성 설정
//		for(String e:mailnums){ 
//			MailVO vo = st.selectOne("mail.getDelAttrMailInfo",e);
//			
//			int mailmem = vo.getMailmem();
//			String mailreceiver = vo.getMailreceiver();
//			
//			if(mailmem == Integer.parseInt(map.get("usernum"))){
//				map.put("mailnum", e);
//				st.update("mail.setDelAttrFrom", map);
//			}
//			
//			if(mailreceiver.equals(map.get("userid"))){
//				map.put("mailnum", e);
//				st.update("mail.setDelAttrTo", map);
//			}
//		}
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		try {
//			con = ConUtil.getOds();
//			StringBuffer sql = new StringBuffer();
//			
//			for(String e:mailnums){
//				sql.setLength(0);
//				sql.append("select mailmem,mailreceiver from mail where mailnum=?");
//				pstmt = con.prepareStatement(sql.toString());
//				pstmt.setInt(1, Integer.parseInt(e)); // 검색할 메일의 번호
//				rs = pstmt.executeQuery();
//			
//				if(rs.next()){ 
//					int mailmem = rs.getInt("mailmem");
//					String mailreceiver = rs.getString("mailreceiver");
//					
//					if(mailmem == Integer.parseInt(map.get("usernum"))){ // 로그인한 사원이 보낸 메일일 경우
//						sql.setLength(0); // 스트링버퍼 비우기
//						sql.append("update mail set mailsdelete=? where mailnum=?");
//					}
//					
//					if(mailreceiver.equals(map.get("userid"))){ // 로그인한 사원이 받은 메일일 경우
//						sql.setLength(0); // 스트링버퍼 비우기
//						sql.append("update mail set mailrdelete=? where mailnum=?");
//					}
//					
////					CloseUtil.close(rs);
////					CloseUtil.close(pstmt);
//					pstmt = con.prepareStatement(sql.toString());
//					pstmt.setInt(1, Integer.parseInt(map.get("delvalue")));
//					// 삭제(메일함에서 휴지통으로 이동)는 2
//					// 영구 삭제(휴지통에서도 보이지 않게 함)는 3
//					// 복구(휴지통에서 메일함으로 이동)은 1
//					pstmt.setInt(2, Integer.parseInt(e));
//					pstmt.executeUpdate();	
//					
//					System.out.println("delete 속성 업데이트");
//				}
//				
//			}
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
//	}
	
	public List<MailVO> getTrashList(Map<String, String> map){
		// 휴지통에서 보여줄 메일 리스트를 리턴하는 메서드
		return st.selectList("mail.getTrashList", map);
	
//			sql.append("select * from (select rownum r_num, a.* from (");
//			sql.append("select ma.mailnum, me1.memname mailsname, me2.memname mailrname, ma.mailtitle, ma.maildate");
//			sql.append(" from member me1, member me2, mail ma");
//			sql.append(" where (me1.memnum=ma.mailmem and me2.meminmail=ma.mailreceiver) and");
//			sql.append(" ((ma.mailmem=? and ma.mailsdelete=2) or (ma.mailreceiver=? and ma.mailrdelete=2))");
//			sql.append(" order by ma.maildate desc) a)");
//			sql.append(" where r_num between ? and ?");

	}
	
	public int[] getListNum(Map<String, String> map){
		// 각 메일함에 있는 메일의 갯수를 얻기 위한 메서드
		MailVO mavo = st.selectOne("mail.getListNum",map);
		
		System.out.println("받은 메일함 메일 갯수: "+mavo.getFromnum());
		System.out.println("보낸 메일함 메일 갯수: "+mavo.getTonum());
		int[] numArr = new int[4];
		numArr[0] = mavo.getFromnum();
		numArr[1] = mavo.getTonum();
		numArr[2] = mavo.getMynum();
		numArr[3] = mavo.getTrashnum();
		
//		for(int i=0; i<numList.size(); i++){
//			System.out.println("메일 갯수: "+numList.get(i));
//			numArr[i] = numList.get(i);
//			// ***********************
//			// ***********************
//			// 받은 메일함 메일 갯수밖에 못 불러옴
//			// ***********************
//			// ***********************
//		}
		
		return numArr;
		
//			sql.append("select (select count(*) from mail where mailreceiver=? and mailrdelete=1 and not mailmem=?) fromnum,");
//			sql.append(" (select count(*) from mail where mailmem=? and mailsdelete=1 and not mailreceiver=?) tonum,");
//			sql.append(" (select count(*) from mail where mailmem=? and mailreceiver=? and mailsdelete=1 and mailrdelete=1) mynum,");
//			sql.append(" (select count(*) from mail where (mailmem=? and mailsdelete=2) or (mailreceiver=? and mailrdelete=2)) trashnum from dual");
			
//			pstmt.setString(1, userid);
//			pstmt.setInt(2, usernum);
//			pstmt.setInt(3, usernum);
//			pstmt.setString(4, userid);
//			pstmt.setInt(5, usernum);
//			pstmt.setString(6, userid);
//			pstmt.setInt(7, usernum);
//			pstmt.setString(8, userid);
		
	}
	
//	public void delMailFromDB(){
//		// mailsdelete, mailrdelete 속성이 모두 3인 메일을 db에서 삭제하는 메서드
//		// (받은 사람과 보낸 사람이 모두 메일을 영구 삭제했을 경우)
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		
//		try {
//			con = ConUtil.getOds();
//			StringBuffer sql = new StringBuffer();
//			sql.append("delete from mail where mailsdelete=3 and mailrdelete=3");
//			pstmt = con.prepareStatement(sql.toString());
//			pstmt.executeUpdate(); 
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} 
//		
//	}
	
}
