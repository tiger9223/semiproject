package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.hk.daos.PostDao;
import com.hk.daos.BoardDao;
import com.hk.daos.CategoryDao;
import com.hk.daos.LoginDao;
import com.hk.dtos.PostDto;
import com.hk.dtos.BoardDto;
import com.hk.dtos.CategoryDto;
import com.hk.dtos.LoginDto;

/**
 * Servlet implementation class BoardController
 */
@WebServlet("/PostController.do")
public class PostController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//인코딩처리
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		
		String command=request.getParameter("command");
		
		LoginDao ldao = new LoginDao();
		PostDao pdao = new PostDao();
		BoardDao bdao = new BoardDao();
		CategoryDao cdao = new CategoryDao();
		
		LoginDto ldto = (LoginDto)session.getAttribute("ldto");
		
		if(command.equals("boardlist")) {
			//"readcount"값을 삭제한다.
			request.getSession().removeAttribute("readcount");
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardListBySeq(boardseq);
			List<PostDto> list = pdao.getPostByListSeq(boardseq);
			request.setAttribute("bdto", bdto);
			request.setAttribute("list", list);
//			request.getRequestDispatcher("boardlist.jsp").forward(request, response);
			dispatch("infoboardlist.jsp", request, response);
			
		}else if(command.equals("boarddetail")) {
			int boardseq=Integer.parseInt(request.getParameter("boardseq"));
			
			//세션에 "readcount"가 있는지 가져와 본다
			String rSeq=(String)request.getSession().getAttribute("readcount");
			
			if(rSeq==null) {
				//조회수 올리기
				pdao.readCount(boardseq);
				//현재 조회된 글에 번호를 세션에 "readcount"라는 이름으로 담아두기
				request.getSession().setAttribute("readcount", boardseq+"");
			}
			
			PostDto pdto=pdao.getBoard(boardseq);
			request.setAttribute("pdto", pdto);
			dispatch("boarddetail.jsp", request, response);
			
			
		}else if(command.equals("muldel")) {
			String [] seqs = request.getParameterValues("chk");
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			boolean isS=pdao.mulDel(seqs);
			if(isS) {
				response.sendRedirect("PostController.do?command=boardlist&boardseq="+boardseq);
			}else {
				request.setAttribute("msg", "글여러개삭제실패");
				dispatch("error.jsp", request, response);
			}
			
			
		}else if(command.equals("insertForm")) {
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardListBySeq(boardseq);
			List<CategoryDto> list = cdao.getCategoryBySeq(boardseq);
			request.setAttribute("list",list);
			request.setAttribute("bdto", bdto);
			dispatch("insertboard.jsp", request, response);
			
		}else if(command.equals("insertboard")) {
			int boardSeq = Integer.parseInt(request.getParameter("boardseq"));
			String id = request.getParameter("id");
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			int categorySeq = Integer.parseInt(request.getParameter("category"));
			
			boolean isS=pdao.insertBoard(new PostDto(id,title, content, ldto.getSeq(), boardSeq, categorySeq));
			if(isS) {
				jsForward("PostController.do?command=boardlist&boardseq="+boardSeq, "글이 정상적으로 등록 됐습니다.", response);
				
			}else {
				request.setAttribute("msg", "글추가실패");
				dispatch("error.jsp", request, response);
			}
			
			
		}else if(command.equals("updateForm")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			PostDto dto=pdao.getBoard(seq);
			request.setAttribute("dto", dto);
			dispatch("updateboard.jsp", request, response);
			
			
		}else if(command.equals("updateboard")) {
			int seq=Integer.parseInt(request.getParameter("seq"));
			String title=request.getParameter("title");
			String content=request.getParameter("content");
			
			boolean isS=pdao.updateBoard(new PostDto(seq,title,content));
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
			
			boolean isS=pdao.replyBoard(new PostDto());
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
		
	public void jsForward(String url, String msg, HttpServletResponse response) throws IOException {
		String str = "<script type='text/javascript'>"
		+"alert('"+msg+"');"
		+"location.href='"+url+"';"
		+"</script>";
		PrintWriter pw = response.getWriter();
		pw.print(str);
	}
}


