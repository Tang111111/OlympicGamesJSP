package helper;

import java.sql.Connection;
import java.sql.DriverManager;
//import java.sql.PreparedStatement;

public class DBConnect {
    public static final String url = "jdbc:mysql://localhost:3306/Olympics?uerUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai";
    public static final String name = "com.mysql.jdbc.Driver";
    public static final String user = "root";
    public static final String password = "cgp5226926+123";
    public static Connection conn = null;
	//public PreparedStatement p = null;
	public static Connection getConnection() {
		if(conn==null) {
			try {
				
				Class.forName(name);
				conn = DriverManager.getConnection(url, user, password);	System.out.println(conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
    public static void main(String[] args) {
    	System.out.println(getConnection());
    }
}

