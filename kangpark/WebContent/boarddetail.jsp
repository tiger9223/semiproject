<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="header.jsp"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	table {
    width: 30%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    display: table;
    margin-left: auto;
    margin-right: auto;
  	}
 	th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
 	}
 	#header{
 	display: table;
    margin-left: auto;
    margin-right: auto;
 	}
</style>
<%
	List<BoardDto> blist = (List<BoardDto>)request.getAttribute("blist");
%>
</head>
<body>
<div id="header">
<h1>게시판 목록</h1>
</div>
<form action="PostController.do" method="post">
<table border="1">
<tr>
<td>게시판 번호</td>
<td>게시판 이름</td>
</tr>
<% for(BoardDto bdto: blist){
	%>
<% 
	if(blist == null || blist.size()==0){%>
	<tr>
		<td colspan="2">등록된 게시판이 없습니다.</td>
	</tr>
	<%}else{
		%>
	<tr>
	<th><%=bdto.getSeq() %></th>
	<td><a href="PostController.do?command=updateboardform&boardseq=<%=bdto.getSeq()%>"><%=bdto.getTitle() %></a></td>
	</tr>
	<%
	}
}%>
<tr>
	<td colspan="2"><input type="button" value="게시판추가"
			       onclick="location.href='insertboard.jsp'"/></td>
</tr>
</table>
</form>
</body>
</html>