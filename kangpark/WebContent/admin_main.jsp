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
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	#header{
		text-align:center;
	}
	#container{
		width: 300px;
        padding: 20px;
        padding-left: 15px;
        margin-bottom: 20px;
        text-align:center;
        display: table;
        margin-left: auto;
        margin-right: auto;
	}
	#bar{
		padding: 20px;
	}
</style>
</head>
<body>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
%>
<div id="container">
<h1>관리자 페이지</h1>
<%
	if(ldto==null) {
		response.sendRedirect("index.jsp");
	}else {
		%>
		<div><h1><%=ldto.getId()%>님 반가워요</h1>(등급:<%=ldto.getRole()%>)
			<a href="LoginController.do?command=logout">로그아웃</a>
		</div>
		<div id="bar">
		<ul>
			<li><a href="LoginController.do?command=alluserstatus">회원 상태정보 조회</a></li>
			<li><a href="LoginController.do?command=alluserlist">회원정보 목록 조회</a></li>
			<li><a href="PostController.do?command=boarddetail">게시판 목록보기</a></li>
			<li><a href="HomeController.do?command=notice">공지게시판 관리</a></li>
		</ul>
		</div>
		<%
	}
%>
</div>
</body>
</html>