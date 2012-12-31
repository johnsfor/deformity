package com.deformity.common;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * @description 初始化系统数据
 */ 
public class InitServlet extends HttpServlet {
	private static final long serialVersionUID = 7764231679027921927L;
	public void init() throws ServletException{
		
		try {
			System.out.println("*********************初始化***************************");
			System.out.println("********************初始化完成***************************");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
