package com.kh.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class AjaxFileUploadController
 */
@WebServlet("/fileUpload.do")
public class AjaxFileUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxFileUploadController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String filePath = request.getServletContext().getRealPath("/upload/");
		
		MultipartRequest multiRequest = new MultipartRequest(request , filePath , 1024*1024*10 , "UTF-8" , 
				new DefaultFileRenamePolicy());
		
		System.out.println(multiRequest.getParameter("name"));
		
		Enumeration e = multiRequest.getFileNames();
		ArrayList<String> filenames = new ArrayList(); 
		while(e.hasMoreElements()) { 
			// System.out.println("원본 키값 : " + (String) e.nextElement());
			filenames.add(multiRequest.getFilesystemName((String) e.nextElement()));
		}
		System.out.println(filenames);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
