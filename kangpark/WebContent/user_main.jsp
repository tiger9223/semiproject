<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
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
<title></title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	#header{
		text-align:center;
	}
	#body{
		width: 300px;
        padding: 20px;
        padding-left: 15px;
        margin-bottom: 20px;
        text-align:center;
        display: table;
        margin-left: auto;
        margin-right: auto;
	}
</style>
</head>
<body>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	List<BoardDto> list = (List<BoardDto>)request.getAttribute("list");
%>
<div id="container">
      <div id="header">
		<h1><%=ldto.getId()%>님 반가워요.</h1>(등급:<%=ldto.getRole().equals("USER")?"일반회원":"정회원"%>)
		<a href="LoginController.do?command=logout">Logout</a>
      </div>
      <div id="body">
        <ul>												<!-- ldto에 로그인 정보가 있으니까.. -->
		<li><a href="LoginController.do?command=getUserInfo&seq=<%=ldto.getSeq()%>">나의 정보 조회</a></li>
		</ul>
		<% 
		if(list == null || list.size()==0){
			
		}else{
		for(BoardDto dto:list){
			%>
		<ul>												
			<li><a href="PostController.do?command=PostList&boardseq=<%=dto.getSeq()%>"><%=dto.getTitle() %></a></li>
		</ul>
		<% 
			}
		}
		%>
		</div>
</div>
</body>
</html>