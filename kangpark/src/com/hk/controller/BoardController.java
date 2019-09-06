package com.hk.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.hk.daos.BoardDao;
import com.hk.daos.LoginDao;
import com.hk.dtos.BoardDto;
import com.hk.dtos.LoginDto;

/**
 * Servlet implementation class BoardController
 */
@WebServlet("/BoardController.do")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//인코딩처리
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String command=request.getParameter("command");
		
		LoginDao ldao = new LoginDao();
		BoardDao dao = new BoardDao();
		
		if(command.equals("boardlist")) {
			//"readcount"값을 삭제한다.
			request.getSession().removeAttribute("readcount");
			int member_seq = Integer.parseInt(request.getParameter("seq"));
			LoginDto ldto = ldao.getUserInfo(member_seq);
			List<BoardDto> list=dao.getAllList();
			request.setAttribute("ldto", ldto);
			request.setAttribute("list", list);
//			request.getRequestDispatcher("boardlist.jsp").forward(request, response);
			dispatch("boardlist.jsp", request, response);
		}else if(command.equals("boarddetail")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			
			//세션에 "readcount"가 있는지 가져와 본다
			String rSeq=(String)request.getSession().getAttribute("readcount");
			
			if(rSeq==null) {
				//조회수 올리기
				dao.readCount(seq);
				//현재 조회된 글에 번호를 세션에 "readcount"라는 이름으로 담아두기
				request.getSession().setAttribute("readcount", seq+"");
			}
			
			
			BoardDto dto=dao.getBoard(seq);
			request.setAttribute("dto", dto);
			dispatch("boarddetail.jsp", request, response);
		}else if(command.equals("muldel")) {
			String [] seqs=request.getParameterValues("chk");
			boolean isS=dao.mulDel(seqs);
			if(isS) {
				response.sendRedirect("AnsController.do?command=boardlist");
			}else {
				request.setAttribute("msg", "글여러개삭제실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("insertForm")) {
			response.sendRedirect("insertboard.jsp");
		}else if(command.equals("insertboard")) {
			String id=request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.insertBoard(new BoardDto(id,title,content));
			if(isS) {
				response.sendRedirect("AnsController.do?command=boardlist");
			}else {
				request.setAttribute("msg", "글추가실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("updateForm")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			BoardDto dto=dao.getBoard(seq);
			request.setAttribute("dto", dto);
			dispatch("updateboard.jsp", request, response);
		}else if(command.equals("updateboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.updateBoard(new BoardDto(seq,title,content));
			if(isS) {
				response.sendRedirect("AnsController.do?command=boarddetail&seq="+seq);
			}else {
				request.setAttribute("msg", "글수정하기 실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("replyboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String id=request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=dao.replyBoard(new BoardDto(seq,id,title,content));
			if(isS) {
				response.sendRedirect("AnsController.do?command=boardlist");
			}else {
				request.setAttribute("msg", "답글달기실패");
				dispatch("error.jsp", request, response);
			}
		}
	}//doPost()종료
	
	//RequestDispatcher객체를 구해서 forward()할 수 있도록 구현한 메서드
	//                        --> request scope에 담은 객체를 전달할때 이동하는 방식
	public void dispatch(String url, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher(url).forward(request, response);
	}
		
}


