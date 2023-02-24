package com.kh.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.model.vo.Member;

/**
 * Servlet implementation class JqAjaxController4
 */
@WebServlet("/jqAjax4.do")
public class JqAjaxController4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController4() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Member> list = new ArrayList<>();
		
		list.add(new Member(1 , "송지호" , 25 , "남자"));
		list.add(new Member(2 , "송지효" , 25 , "여자"));
		list.add(new Member(3 , "아무개" , 30 , "남자"));
		
		response.setContentType("application/json; charset=UTF-8");
		
		new Gson().toJson(list , response.getWriter()); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
