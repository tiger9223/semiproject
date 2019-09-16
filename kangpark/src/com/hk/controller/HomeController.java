package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hk.daos.BoardDao;
import com.hk.daos.CategoryDao;
import com.hk.daos.LoginDao;
import com.hk.daos.PostDao;
import com.hk.dtos.BoardDto;
import com.hk.dtos.LoginDto;

@WebServlet("/HomeController.do")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
HttpSession session = request.getSession();
		
		String command=request.getParameter("command");
		
		LoginDao ldao = new LoginDao();
		PostDao pdao = new PostDao();
		BoardDao bdao = new BoardDao();
		CategoryDao cdao = new CategoryDao();
		
		LoginDto ldto = (LoginDto)session.getAttribute("ldto");
		
		if(command.equals("notice")) {
			System.out.println("들어왔다");
			dispatch("notice.jsp", request, response);
		}
		
		List<BoardDto> list = bdao.getBoardList();
		request.setAttribute("list", list);
		dispatch("user_main.jsp", request, response);
	}

	public void dispatch(String url, HttpServletRequest request
							, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	

}
