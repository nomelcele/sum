package com.sumware.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import conn.ConUtil;

public class SearchMem {
	private static SearchMem smem;

	public static synchronized SearchMem getSmem() {
		if(smem == null) smem = new SearchMem();
		return smem;
	}
	
	public String searchMember(int mesendNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mesendName= null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("select memname from member where memnum=?");
		try {
			con = ConUtil.getOds();
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setInt(1, mesendNum);
			rs = pstmt.executeQuery();
			while(rs.next()){
				mesendName = rs.getString("memname");
				System.out.println("송신자 이름 : "+mesendName);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mesendName;
	}
	
	
	
	

}
