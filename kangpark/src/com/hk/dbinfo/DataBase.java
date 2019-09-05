package com.hk.dbinfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataBase {

	public DataBase() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1단계 드라이버 로딩", "DataBase()");
		} catch (ClassNotFoundException e) {
			log("1단계 드라이버 로딩", "DataBase()", e);
		}
	}
	
	//오버로딩 ---> subString(index), subString(index, index)
	//오류 로그 : catch 내부에 작성될 log method
	public void log(String msg, String methodName, Exception e) {
		System.out.println(msg+":실패:"+getClass()+":"+methodName+"\n 오류내용:"+e);
	}
	//성공 로그
	public void log(String msg, String methodName) {
		System.out.println(msg+":성공:"+getClass()+":"+methodName);
	}
	
	public Connection getConnection() throws SQLException {
		Connection conn = null;
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "hk5";
		String password = "hk5";
		conn = DriverManager.getConnection(url, user, password);
		log("2단계 DB연결", "getConnection()");
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement psmt, Connection conn) {
		try {
			if(rs!=null) {
				rs.close();
			}
			if(psmt!=null) {
				psmt.close();
			}
			if(conn!=null) {
				conn.close();
			}
			log("6단계 DB 닫기", "close()");
		} catch (SQLException e) {
			log("6단계 DB 닫기", "close()", e);
		}
	}
}
