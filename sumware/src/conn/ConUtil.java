package conn;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import oracle.jdbc.pool.OracleDataSource;

public class ConUtil {
	private static OracleDataSource ods;
	
	static{
		InitialContext ic;
		try {
			ic = new InitialContext();
			ods = (OracleDataSource) ic.lookup("java:comp/env/jdbc/myora");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getOds() throws SQLException{
		return ods.getConnection();
	}
	
}
