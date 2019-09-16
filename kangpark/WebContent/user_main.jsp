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
</head>
<body>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	List<BoardDto> list = (List<BoardDto>)request.getAttribute("list");
%>
<div><%=ldto.getId()%>님 반가워요.(등급:<%=ldto.getRole().equals("USER")?"일반회원":"정회원"%>)
	<a href="LoginController.do?command=logout">로그아웃</a>
</div>
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


</body>
</html>