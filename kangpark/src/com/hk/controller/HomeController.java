package com.hk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
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
import com.hk.dtos.CategoryDto;
import com.hk.dtos.LoginDto;
import com.hk.dtos.PostDto;

@WebServlet("/HomeController.do")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		HttpSession session = request.getSession();
		
		String command=request.getParameter("command");
		
		LoginDao ldao = new LoginDao();
		PostDao pdao = new PostDao();
		BoardDao bdao = new BoardDao();
		CategoryDao cdao = new CategoryDao();
		
		LoginDto ldto = (LoginDto)session.getAttribute("ldto");
		
		if(command.equals("notice")) {
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardBySeq(boardseq);
			List<PostDto> list = pdao.getPostByBoardSeq(boardseq);
			request.setAttribute("bdto", bdto);
			request.setAttribute("list", list);
			dispatch("notice.jsp", request, response);
		}else if(command.equals("InsertNoticeForm")) {
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardBySeq(boardseq);
			CategoryDto cdto = cdao.getCateByBoardSeq(boardseq);
			System.out.println(bdto);
			System.out.println(cdto);
			request.setAttribute("cdto",cdto);
			request.setAttribute("bdto", bdto);
			dispatch("insertnotice.jsp", request, response);
		
	}else if(command.equals("InsertNoticePost")) {
		int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
		int memberSeq = Integer.parseInt(request.getParameter("memberSeq"));
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int categorySeq = Integer.parseInt(request.getParameter("categorySeq"));
		
		boolean isS = pdao.insertNotice(new PostDto(title, content, memberSeq, boardSeq, categorySeq));
		
		if(isS) {
			jsForward("admin_main.jsp", "글이 정상적으로 등록 됐습니다.", response);
			
		}else {
			request.setAttribute("msg", "글추가실패");
			dispatch("error.jsp", request, response);
		}
		
	}else if(command.equals("noticedetail")) {
		
		int PostSeq = Integer.parseInt(request.getParameter("PostSeq"));
		int memberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
		String rSeq=(String)request.getSession().getAttribute("readcount");
		
		if(rSeq==null) {
			//조회수 올리기
			pdao.readCount(PostSeq);
			//현재 조회된 글에 번호를 세션에 "readcount"라는 이름으로 담아두기
			request.getSession().setAttribute("readcount", PostSeq+"");
		}
		PostDto pdto = pdao.getPostDetail(PostSeq);
		ldto = ldao.getUserInfo(memberSeq);
		BoardDto bdto = bdao.getBoardBySeq(pdto.getBoard_seq());
		request.setAttribute("pdto", pdto);
		request.setAttribute("dto", ldto);
		request.setAttribute("bdto", bdto);
		dispatch("noticedetail.jsp", request, response);
	}else if(command.equals("noticedelete")) {
		int PostSeq = Integer.parseInt(request.getParameter("PostSeq"));
		BoardDto bdto = bdao.getBoardByPostSeq(PostSeq);
		int boardseq = bdto.getSeq();
		boolean isS=pdao.deletePost(PostSeq);
		if(isS) {
			jsForward("HomeController.do?command=notice&boardseq="+boardseq, "글을 삭제하였습니다.", response);
		}else {
			request.setAttribute("msg", "글삭제실패");
			dispatch("error.jsp", request, response);
		}
	}else if(command.equals("noticeUpdateForm")) {
		
		int memberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
		int postSeq = Integer.parseInt(request.getParameter("PostSeq"));
		PostDto pdto = pdao.getPost(memberSeq,postSeq);
		request.setAttribute("pdto", pdto);
		dispatch("updatenotice.jsp", request, response);		
	}else if(command.equals("UpdatePost")) {
		int boardseq = Integer.parseInt(request.getParameter("boardseq"));
		int memberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
		int postSeq = Integer.parseInt(request.getParameter("PostSeq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		boolean isS=pdao.updatePost(new PostDto(postSeq,title,content));
		
		if(isS) {
			ldto = ldao.getUserInfo(memberSeq);
			PostDto pdto = pdao.getPostDetail(postSeq);
			BoardDto bdto = bdao.getBoardBySeq(pdto.getBoard_seq());
			request.setAttribute("pdto", pdto);
			request.setAttribute("dto", ldto);
			request.setAttribute("bdto", bdto);
			dispatch("HomeController.do?command=notice&boardseq="+boardseq, request, response);		
		}else {
			request.setAttribute("msg", "글수정실패");
			dispatch("error.jsp", request, response);
		}
	
	}
	
	
	
	}
	
	
	
	
	public void jsForward(String url, String msg, HttpServletResponse response) throws IOException {
		String str = "<script type='text/javascript'>"
		+"alert('"+msg+"');"
		+"location.href='"+url+"';"
		+"</script>";
		PrintWriter pw = response.getWriter();
		pw.print(str);
	}

	public void dispatch(String url, HttpServletRequest request
							, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}
	

}
