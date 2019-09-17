<%@page import="com.hk.dtos.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
%>
</head>
<body>
<h1>유형 추가하기</h1>
<form action="PostController.do" method="post">
<input type="hidden" name="command" value="InsertCategory"/>
<input type="hidden" name="boardSeq" value="<%=bdto.getSeq()%>"/>
<table border="1">
	<tr>
		<th>게시판 이름</th>
		<td><%=bdto.getTitle()%></td>
	</tr>
	<tr>
		<th>카테고리 유형</th>
		<td><input type="text" name="title"/></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="추가"/></td>
	</tr>
</table>
</form>
</body>
</html>