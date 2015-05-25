package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CloseUtil {
	public static void close(Connection con){
		try {
			if(con!=null){
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	public static void close(PreparedStatement pstmt){
		try {
			if(pstmt!=null){
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	public static void close(ResultSet rs){
		try {
			if(rs!=null){
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
