package com.hk.controller;

import java.io.IOException;  
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
		
		if(command.equals("PostList")) {
			//"readcount"값을 삭제한다.
			request.getSession().removeAttribute("readcount");
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardBySeq(boardseq);
			List<PostDto> list = pdao.getPostByBoardSeq(boardseq);
			
//			List<CategoryDto> clist=new ArrayList<>();
//			for(PostDto dto:list) {
//				int seq=dto.getCategory_seq();
//				clist.addAll(cdao.getCategoryList(seq));
//			}
			request.setAttribute("bdto", bdto);
			request.setAttribute("list", list);
//			request.setAttribute("clist", clist);
//			request.getRequestDispatcher("boardlist.jsp").forward(request, response);
			dispatch("postlist.jsp", request, response);
			
		}else if(command.equals("PostDetail")) {
			
			int MemberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
			int PostSeq = Integer.parseInt(request.getParameter("PostSeq"));
			//세션에 "readcount"가 있는지 가져와 본다
			String rSeq=(String)request.getSession().getAttribute("readcount");
			
			if(rSeq==null) {
				//조회수 올리기
				pdao.readCount(PostSeq);
				//현재 조회된 글에 번호를 세션에 "readcount"라는 이름으로 담아두기
				request.getSession().setAttribute("readcount", PostSeq+"");
			}
			
			PostDto pdto = pdao.getPostDetail(PostSeq);
			ldto = ldao.getUserInfo(MemberSeq);
			BoardDto bdto = bdao.getBoardBySeq(pdto.getBoard_seq());
			request.setAttribute("pdto", pdto);
			request.setAttribute("dto", ldto);
			request.setAttribute("bdto", bdto);
			dispatch("postdetail.jsp", request, response);
			
		}else if(command.equals("DeletePost")) {
			
			int PostSeq = Integer.parseInt(request.getParameter("PostSeq"));
			PostDto pdto = pdao.getPostDetail(PostSeq);
			boolean isS=pdao.deletePost(PostSeq);
			if(isS) {
				response.sendRedirect("PostController.do?command=PostList&boardseq="+pdto.getBoard_seq());
			}else {
				request.setAttribute("msg", "글삭제실패");
				dispatch("error.jsp", request, response);
			}
			
		//--------------------------------------------------------------------	
		}else if(command.equals("InsertForm")) {//게시판에 글을 넣기위해 어떤게시판을 호출할지
			
			int boardseq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardBySeq(boardseq);
			List<CategoryDto> list = cdao.getCategoryByBoardSeq(boardseq);
			request.setAttribute("list",list);
			request.setAttribute("bdto", bdto);
			dispatch("insertpost.jsp", request, response);
			
		}else if(command.equals("InsertPost")) {
			
			int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
			int memberSeq = Integer.parseInt(request.getParameter("memberSeq"));
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			int categorySeq = Integer.parseInt(request.getParameter("categorySeq"));
			
			boolean isS = pdao.insertPost(new PostDto(title, content, memberSeq, boardSeq, categorySeq));
			
			if(isS) {
				jsForward("PostController.do?command=PostList&boardseq="+boardSeq, "글이 정상적으로 등록 됐습니다.", response);
				
			}else {
				request.setAttribute("msg", "글추가실패");
				dispatch("error.jsp", request, response);
			}
			
			
		}else if(command.equals("UpdateForm")) {
			
			int memberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
			int postSeq = Integer.parseInt(request.getParameter("PostSeq"));
			PostDto pdto = pdao.getPost(memberSeq,postSeq);
			request.setAttribute("pdto", pdto);
			dispatch("updatepost.jsp", request, response);
			
			
		}else if(command.equals("UpdatePost")) {
			
			int MemberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
			int postSeq = Integer.parseInt(request.getParameter("PostSeq"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS=pdao.updatePost(new PostDto(postSeq,title,content));
			
			if(isS) {
				ldto = ldao.getUserInfo(MemberSeq);
				PostDto pdto = pdao.getPostDetail(postSeq);
				BoardDto bdto = bdao.getBoardBySeq(pdto.getBoard_seq());
				request.setAttribute("pdto", pdto);
				request.setAttribute("dto", ldto);
				request.setAttribute("bdto", bdto);
				dispatch("postdetail.jsp", request, response);
			}else {
				request.setAttribute("msg", "글수정하기 실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("replyPost")) {
			
			int seq = Integer.parseInt(request.getParameter("PostSeq"));
			int memberSeq = Integer.parseInt(request.getParameter("MemberSeq"));
			int boardSeq = Integer.parseInt(request.getParameter("BoardSeq"));
			int categorySeq = Integer.parseInt(request.getParameter("CategorySeq"));
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			boolean isS=pdao.replyPost(new PostDto(seq,title, content, memberSeq, boardSeq, categorySeq));
			if(isS) {
				jsForward("PostController.do?command=PostList&boardseq="+boardSeq, "답글이 정상적으로 등록 됐습니다.", response);
			}else {
				request.setAttribute("msg", "답글달기실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("InsertBoard")) {
			
			String board = request.getParameter("board");
			boolean isS = bdao.insertBoard(new BoardDto(board));
			if(isS) {
				jsForward("admin_main.jsp","게시판이 정상적으로 등록 됐습니다.", response);
			}else {
				request.setAttribute("msg", "게시판추가실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("boarddetail")) {
			
			List<BoardDto> blist = bdao.getBoardList();
			request.setAttribute("blist", blist);
			dispatch("boarddetail.jsp", request, response);
			
		}else if(command.equals("updateboardform")) {
			
			int boardSeq = Integer.parseInt(request.getParameter("boardseq"));
			BoardDto bdto = bdao.getBoardBySeq(boardSeq);
			List<CategoryDto> clist = cdao.getCategoryByBoardSeq(boardSeq);
			request.setAttribute("bdto", bdto);
			request.setAttribute("clist", clist);
			dispatch("updateboard.jsp", request, response);
			
		}else if(command.equals("updateboard")) {
			
			int boardSeq = Integer.parseInt(request.getParameter("boardseq"));
			String title = request.getParameter("title");
			boolean isS = bdao.updateBoard(new BoardDto(boardSeq,title));
			if(isS) {
				jsForward("admin_main.jsp","게시판이 정상적으로 수정됐습니다.", response);
			}else {
				request.setAttribute("msg", "게시판수정실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("updatecategoryform")) {
			
			int categoryseq = Integer.parseInt(request.getParameter("categoryseq"));
			CategoryDto cdto = cdao.getCategoryBySeq(categoryseq);
			request.setAttribute("cdto", cdto);
			dispatch("updatecategory.jsp", request, response);
			
		}else if(command.equals("updatecategory")) {
			
			int categoryseq = Integer.parseInt(request.getParameter("categoryseq"));
			String title = request.getParameter("title");
			boolean isS = cdao.updateCategory(new CategoryDto(categoryseq,title));
			if(isS) {
				jsForward("admin_main.jsp","유형이 정상적으로 수정됐습니다.", response);
			}else {
				request.setAttribute("msg", "유형수정실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("Deletecategory")) {
			
			int categoryseq = Integer.parseInt(request.getParameter("categoryseq"));
			boolean isS = cdao.deleteCategory(new CategoryDto(categoryseq));
			if(isS) {
				jsForward("admin_main.jsp","유형이 정상적으로 삭제됐습니다.", response);
			}else {
				request.setAttribute("msg", "유형삭제실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("boardInsertForm")) {
			
			int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
			String title = request.getParameter("title");
			boolean isS = bdao.updateBoard(new BoardDto(boardSeq,title));
			if(isS) {
				jsForward("admin_main.jsp","게시판이 정상적으로 수정됐습니다.", response);
			}else {
				request.setAttribute("msg", "게시판수정실패");
				dispatch("error.jsp", request, response);
			}
			
		}else if(command.equals("insertCategoryForm")) {
			
			int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
			BoardDto bdto = bdao.getBoardBySeq(boardSeq);
			request.setAttribute("bdto", bdto);
			dispatch("insertcategory.jsp", request, response);
			
		}else if(command.equals("InsertCategory")) {
			
			int boardSeq = Integer.parseInt(request.getParameter("boardSeq"));
			String title = request.getParameter("title");
			boolean isS = cdao.insertCategory(new CategoryDto(title,boardSeq));
			if(isS) {
				jsForward("admin_main.jsp","카테고리가 추가됐습니다.", response);
			}else {
				request.setAttribute("msg", "카테고리 추가실패");
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


