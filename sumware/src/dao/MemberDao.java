package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.CloseUtil;
import conn.ConUtil;
import dto.MemberVO;

public class MemberDao {
	private static MemberDao dao;

	public synchronized static MemberDao getDao() {
		if(dao == null) dao = new MemberDao();
		return dao;
	}
	
	
	
	
}
