<%@page import="com.hk.dtos.CategoryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%
	CategoryDto cdto = (CategoryDto)request.getAttribute("cdto");
%>
</head>
<body>
<h1>카테고리 수정,삭제하기</h1>
<form action="PostController.do" method="post">
<input type="hidden" name="command" value="updatecategory"/>
<input type="hidden" name="categoryseq" value="<%=cdto.getSeq()%>"/>
<table border="1">
<tr>
<th>번호</th>
<td><%=cdto.getSeq() %></td>
</tr>
<tr>
<th>유형</th>
<td><input type="text" name="title" value="<%=cdto.getTitle() %>"/></td>
</tr>
<tr>
<td colspan="2">
<input type="submit" value="수정"/>
<input type="button" value="삭제"
			       onclick="location.href = 'PostController.do?command=Deletecategory&categoryseq=<%=cdto.getSeq()%>'"/>		       
</td>
</tr>
</table>
</form>
</body>
</html>