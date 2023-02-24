package com.kh.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.kh.model.vo.Member;

/**
 * Servlet implementation class JqAjaxController3
 */
@WebServlet("/jqAjax3.do")
public class JqAjaxController3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqAjaxController3() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int memberNo = Integer.parseInt(request.getParameter("no"));
		
		// 데이터를 조회했다는 가정하에 Member 객체에 값을 담아보기
		Member m = new Member(memberNo , "송지호" , 25 , "남");
		
		// 알게모르게 m변수에 toString()메서드가 호출되어서 문자열이 넘어가게됨.
//		 response.getWriter().print(m); 
		
		// {속성 : 속성값 , 속성 : 속성값}
		
//		JSONObject jobj = new JSONObject();
//		jobj.put("memberNo" , m.getMemberNo()); // {memberNo : 1}
//		jobj.put("memberName", m.getMemberName()); // {memberNo : 1 , memberName : "송지호"}
//		jobj.put("age", m.getAge()); // {memberNo : 1 , memberName : "송지호" , age : 25}
//		jobj.put("gender", m.getGender()); // {memberNo : 1 , memberName : "송지호" , age : 25 , gender : "남"}
//		
//		response.setContentType("application/json; charset=UTF-8");
//		response.getWriter().print(jobj);
		
		
		// GSON : Google JSON
		// GSON 라이브러리를 연동해야 사용이 가능.
		// https://mvnrepository.com/artifact/com.google.code.gson/gson/2.8.2
		
		response.setContentType("application/json; charset=UTF-8");
		Gson gson = new Gson();
		gson.toJson(m , response.getWriter());
		// toJson(응답할 객체, 응답할 스트림) : response.getWriter()라는 통로로 m이라는 객체를 응답하겠다.
		// 단, 변환시 전달되는 키값은 VO객체의 각 필드명으로 자동으로 지정된다.
		
		// 응답할 객체에 vo객체 하나만 지정시 JSONObject형태로 만들어져서 응답.
		// ArrayList로 지정시 JSONArray 형태로 만들어져서 응답.
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
