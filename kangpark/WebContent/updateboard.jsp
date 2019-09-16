<%@page import="com.hk.dtos.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
%>
</head>
<body>
<h1>게시판 수정하기</h1>
<form action="PostController.do" method="post">
<table border="1">
<tr>
<th>게시판 이름</th>
<td><input type="text" name="title"/><%=bdto.getTitle() %></td>
</tr>
</table>
</form>
</body>
</html>