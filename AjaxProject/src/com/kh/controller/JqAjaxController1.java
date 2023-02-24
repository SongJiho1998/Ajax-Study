package com.kh.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JqAjaxController1
 */
@WebServlet("/jqAjax1.do")
public class JqAjaxController1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController1() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String input = request.getParameter("input");
		
		// 응답할 데이터 설정
		String responseData = "입력된 값 : " + input + ", 길이 : " + input.length();
		
		// 응답데이터에 한글이 있을경우 대비해서 설정.
		response.setContentType("text/html; charset=UTF-8");
		
		// jsp와의 통로를 열어둘때사용  -> 자바코드를 안에 html 코드 넣어서 사용했었음.
		response.getWriter().print(responseData);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
