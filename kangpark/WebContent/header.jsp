<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	#main{
	width: 50px;
	height: 50px;
	}
	#header{
	padding: 10px;
	}
</style>
</head>
<body>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
%>
<div id="header">
<a href="LoginController.do?command=login&id=<%=ldto.getId()%>&password=<%=ldto.getPassword()%>"><img id="main" src="img\home.jpg" alt="메인"></a>
</div>
<hr>
</body>
</html>