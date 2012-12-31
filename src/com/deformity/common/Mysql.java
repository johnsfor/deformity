package com.deformity.common;

import java.sql.*;

public class Mysql {
	String sql;
	Statement stmt = null;
	ResultSet rs = null;
	Connection conn = null;
	int a;
	float x, y, z;

	public Mysql() {
		sql = "select * from actor";// 使用的数据表

		try {
			Class.forName("com.mysql.jdbc.Driver");// 注册驱动

			try {
				conn = DriverManager.getConnection(
						"jdbc:mysql://127.0.0.1:3306/sakila", "root", "111111");
				// 建立连接的语句，注意用的test数据库，用户为root，密码为空，这个根据实际调整
			} catch (SQLException ex1) {// catch出错
			}
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);// 执行sql语句，rs是指向其当前数据行的指针
			while (rs.next()) {
				System.out.println(rs.getString("LAST_NAME"));
			}

		} catch (ClassNotFoundException ex) {
			System.out.println("no driver is f d!\n" + ex);
		} catch (SQLException ex) {
			System.out.println("database connection is wrong!" + ex);
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception ex) {
				System.out.println("Close error!");
			}
		}
	}

	public static void main(String[] args) {
		Mysql mysqlTest = new Mysql();// 只是实例化了一个Mysql
	}
}
