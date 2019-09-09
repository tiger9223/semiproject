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
import com.hk.daos.LoginDao;
import com.hk.dtos.BoardDto;
import com.hk.dtos.LoginDto;

@WebServlet("/LoginController.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession session = request.getSession();
		
		String command = request.getParameter("command");
		
		LoginDao dao = new LoginDao();
		
		if(command.equals("regist")) {
			response.sendRedirect("regist.jsp");
		}else if(command.equals("insertuser")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String password = request.getParameter("password");
			String address = request.getParameter("address");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			
			boolean isS = dao.insertUser(new LoginDto(0, id, name, password, address, phone, email, null, null, null));
			
			if(isS) {
				jsForward("index.jsp", "회원가입이 완료되었습니다.", response);
			}else {
				request.setAttribute("msg", "회원가입 실패");
//				pageContext.forward("error.jsp");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("login")) {
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			
			LoginDto ldto = dao.getLogin(id, password);
			if(ldto==null || ldto.getId()==null) {
				request.setAttribute("msg", "아이디나 패스워드를 확인하시오.");
//				pageContext.forward("error.jsp");
				dispatch("error.jsp", request, response);
			}else {
				if(ldto.getEnabled().equals("N")) {
					request.setAttribute("msg", "탈퇴한 회원입니다.");
					dispatch("error.jsp", request, response);
				}else {
					session.setAttribute("ldto", ldto);//세션삽입
					session.setMaxInactiveInterval(10*60);// 10분간 요청이 없으면 세션을 삭제
					if(ldto.getRole().toUpperCase().equals("ADMIN")) {
						
						response.sendRedirect("admin_main.jsp");
					}else if(ldto.getRole().toUpperCase().equals("USER")) {
						BoardDao bdao = new BoardDao();
						List<BoardDto> list = bdao.getBoardList();
						request.setAttribute("list", list);
						dispatch("user_main.jsp", request, response);
					}else if(ldto.getRole().toUpperCase().equals("MANAGER")) {
						BoardDao bdao = new BoardDao();
						List<BoardDto> list = bdao.getBoardList();
						request.setAttribute("list", list);
						dispatch("user_main.jsp", request, response);
					}
				}
			}
		}else if(command.equals("logout")) {
			session.invalidate(); //session의 정보 삭제
			response.sendRedirect("index.jsp");
		}else if(command.equals("idChk")) {
			String id = request.getParameter("id");
			System.out.println(id);
			LoginDto dto = dao.idChk(id);
			request.setAttribute("dto", dto);
//			pageContext.forward("idchkform.jsp");
			dispatch("idchkform.jsp", request, response);
		}else if(command.equals("alluserstatus")){
			List<LoginDto> list=dao.getAllUserStatus();
			request.setAttribute("list", list);
//			pageContext.forward("userlist_status.jsp");
			dispatch("userlist_status.jsp", request, response);
		}else if(command.equals("alluserlist")) {
			List<LoginDto> list = dao.getAllUserStatus();
			request.setAttribute("list", list);
//			pageContext.forward("userlist.jsp");
			dispatch("userlist.jsp", request, response);
		}else if(command.equals("roleForm")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			LoginDto dto=dao.getUser(seq);	//등급을 변경하려는 회원의 정보를 구함
			request.setAttribute("dto", dto);
//			pageContext.forward("authform.jsp");
			dispatch("authform.jsp", request, response);
		}else if(command.equals("authchange")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			String role = request.getParameter("role");
			boolean isS = dao.updateUserRole(seq, role);
			if(isS) {
				jsForward("LoginController.do?command=alluserlist", "회원등급을 수정했습니다.", response);	
			}else {
				request.setAttribute("msg", "회원등급 변경실패");
//				pageContext.forward("error.jsp");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("getUserInfo")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			LoginDto dto = dao.getUserInfo(seq);
			request.setAttribute("dto", dto);
//			pageContext.forward("user_info.jsp");
			dispatch("user_info.jsp", request, response);
		}else if(command.equals("userUpdate")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			LoginDto dto=dao.getUser(seq);
			request.setAttribute("dto", dto);
			dispatch("userupdate.jsp", request, response);
		}else if(command.equals("updateUserInfo")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			String id = request.getParameter("id");
			String address = request.getParameter("address");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			boolean isS = dao.userUpdate(new LoginDto(id,address,phone,email));
			if(isS) {
				jsForward("LoginController.do?command=getUserInfo&seq="+seq,"회원정보을 수정했습니다.",response);
			}else {
				request.setAttribute("msg", "회원정보 수정실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("withdraw")) {
			String id = request.getParameter("id");
			boolean isS = dao.withdraw(id);
			if(isS) {
				 jsForward("LoginController.do?command=logout", "회원 탈퇴 되었습니다.", response);
			}else {
				request.setAttribute("msg", "회원 탈퇴실패");
				dispatch("error.jsp", request, response);
			}
		}else if(command.equals("marketboard")) {
			int seq = Integer.parseInt(request.getParameter("seq"));
			LoginDto dto = dao.getUserInfo(seq);
			request.setAttribute("dto", dto);
//			pageContext.forward("user_info.jsp");
			dispatch("BoardController.do?command=boardlist", request, response);
		}
	}
	public void dispatch(String url, HttpServletRequest request
							, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
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
