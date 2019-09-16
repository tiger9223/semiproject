<%
response.setHeader("pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0L); //Do not cache in proxy server
%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
%>
<h1>관리자 페이지</h1>
<%
	if(ldto==null) {
		response.sendRedirect("index.jsp");
	}else {
		%>
		<div><%=ldto.getId()%>님 반갑습니다.(등급:<%=ldto.getRole()%>)
			<a href="LoginController.do?command=logout">로그아웃</a>
		</div>
		<ul>
			<li><a href="LoginController.do?command=alluserstatus">회원 상태정보 조회</a></li>
			<li><a href="LoginController.do?command=alluserlist">회원정보 목록 조회</a></li>
			<li><a href="insertboard.jsp">게시판 추가</a></li>
			<li><a href="PostController.do?command=boarddetail">게시판 목록보기</a></li>
		</ul>
		<%
	}
%>

</body>
</html>