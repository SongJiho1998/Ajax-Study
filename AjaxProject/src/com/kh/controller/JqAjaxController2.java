package com.kh.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class JqAjaxController2
 */
@WebServlet("/jqAjax2.do")
public class JqAjaxController2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController2() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		// ajax는 결과를 한개만 응답할 수 있음.
		// 요청처리를 다 했다는 가정하에 응답할 데이터 (문자열)
		
		// 버전1)
//		String responseData = "이름 : " + name + ", 나이 : " + age;
//		
//		response.setContentType("text/html; charset=UTF-8");
//		response.getWriter().print(responseData);
		
		// 버전2) 응답데이터 여러개 응답하기 => JSON을 이용
		/*
		 * JSON(Javascript Object Notation : 자바스크립트 객체 표기법)
		 * - ajax 통신 시 데이터 전송에 사용되는 포맷형식 중 하나
		 * 
		 * - JSON 처리시 사용되는 클래스 종류
		 *   => 기본적으로 자바에서 제공하지 않는다. (라이브러리 필요.)
		 *   json-simple-x.x.x.jar 다운로드후 WEB-INF/lib폴더에 복사해줘야함.
		 *   https://code.google.com/archive/p/json-simple/downloads
		 *   
		 *   1. JSONArray[value, value, value] : 배열형태
		 *   2. JSONObject{key:value, key:value} : 객체형태
		 */
		
//		JSONArray jArr = new JSONArray(); // []
//		jArr.add(name); // ["송지호"]
//		jArr.add(age); // ["송지호", 25]
//		
//		// 응답할 데이터의 ContentType을 설정을 하기. text/html -> 문자열 방식
//		response.setContentType("application/json; charset=UTF-8");
//		
//		response.getWriter().print(jArr); // ["송지호", 20] 이라는 문자열로 응답처리됨.
		
		// 마찬가지로 JSONObject 객체 전달 가능.
		JSONObject jobj = new JSONObject(); // {}
		jobj.put("name", name); // {name : "송지호"}
		jobj.put("age" , age); // {name : "송지호" , age : 25}
		
		response.setContentType("appliction/json; charset=UTF-8");
		
		response.getWriter().print(jobj);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
