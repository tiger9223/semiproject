package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.daos.PostDao;
import com.hk.dtos.BoardDto;
import com.hk.dtos.PostDto;

import net.sf.json.JSONObject;

@WebServlet("/ContentAjax.do")
public class ContentAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/json;charset=utf-8");
		
		int seq=Integer.parseInt(request.getParameter("seq"));
		
		System.out.println("클라이언트로부터 전달받은 seq값:"+seq);
		
		PostDao dao=new PostDao();
		PostDto dto=dao.getContent(seq);
		
		//text 데이터를 클라이언트로 보낼때
//		String content=dto.getContent();
//		PrintWriter pw=response.getWriter();
//		pw.print(content);
		
		//AnsDto는 자바에서 사용되는 객체--> 이걸 그대로 보내주면 javascript에서 인식못함
		//json객체로 변환해서 보내주면----> javascript가 인식함
		//{key:value} -----> Map[key:value]형태로 만들고 json으로 변환해서 보내준다.
		//            ----->obj=["dto":{seq:1,id:hk,title:'제목',content:'내용'...}]
		//json변환시 date타입은 변환할 수 없다.
		Map<String, PostDto> map=new HashMap<>();
		map.put("dto", dto);
//		
		JSONObject obj=JSONObject.fromObject(map);//map---> json변환
		PrintWriter pw=response.getWriter();
		obj.write(pw);//obj에 브라우저용 프린터를 빌려주면 json객체를 브라우저로 출력해 준다.
	}

}










