<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%
response.setHeader("pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setDateHeader("Expires", 0L); //Do not cache in proxy server
%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
#hello {
	border: soild red 1px;
}

#header {
	text-align: center;
}

#container {
	width: 300px;
	padding: 20px;
	padding-left: 15px;
	margin-bottom: 20px;
	text-align: center;
	display: table;
	margin-left: auto;
	margin-right: auto;
}

#bar {
	padding: 20px;
}

#header {
	text-align: center;
}

#body {
	width: 300px;
	padding: 20px;
	padding-left: 15px;
	margin-bottom: 20px;
	text-align: center;
	display: table;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
	<%
	List<BoardDto> list = (List<BoardDto>)request.getAttribute("list");
%>
	<div id="container">
		<%
	if(ldto==null) {
		response.sendRedirect("index.jsp");
	}else if(ldto.getRole().equals("ADMIN")){
		%>
		<div id="hello">
			<h1><%=ldto.getId()%>님 반가워요
			</h1>
			(등급:<%=ldto.getRole()%>) <a href="LoginController.do?command=logout">Logout</a>
		</div>
		<div id="bar">
			<ul>
				<li><a href="LoginController.do?command=alluserstatus">전체 회원
						정보 조회</a></li>
				<li><a href="LoginController.do?command=alluserlist">회원 등급
						관리</a></li>
				<li><a href="PostController.do?command=boarddetail">게시판
						목록보기</a></li>
				<% 
		if(list == null || list.size()==0){
			
		}else{
		for(BoardDto dto:list){
			if(dto.getTitle().equals("공지게시판")){
			%>
				<li><a
					href="HomeController.do?command=notice&boardseq=<%=dto.getSeq()%>">공지게시판
						관리</a></li>
				<% 
			}else{
			%>
				<li><a
					href="PostController.do?command=PostList&boardseq=<%=dto.getSeq()%>"><%=dto.getTitle() %></a></li>
				<% 
			}
		}
	}
		%>
			</ul>
		</div>
		<%
	}else{
		%>
		<div id="container">
			<div id="header">
				<h1><%=ldto.getId()%>님 반가워요.
				</h1>
				(등급:<%=ldto.getRole().equals("USER")?"일반회원":"정회원"%>) <a
					href="LoginController.do?command=logout">Logout</a>
			</div>
			<div id="body">
				<ul>
					<!-- ldto에 로그인 정보가 있으니까.. -->
					<li><a
						href="LoginController.do?command=getUserInfo&seq=<%=ldto.getSeq()%>">나의
							정보 조회</a></li>
				</ul>
				<% 
		if(list == null || list.size()==0){
			
		}else{
		for(BoardDto dto:list){
			%>
				<ul>
					<li><a
						href="PostController.do?command=PostList&boardseq=<%=dto.getSeq()%>"><%=dto.getTitle() %></a></li>
				</ul>
				<% 
			}
		}
		%>
			</div>
		</div>
		<% 
	}
%>
	</div>
</body>
</html>