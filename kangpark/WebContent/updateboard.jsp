<%@page import="com.hk.dtos.CategoryDto"%>
<%@page import="java.util.List"%>
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
	List<CategoryDto> clist = (List<CategoryDto>)request.getAttribute("clist");
%>
</head>
<body>
<h1>게시판 수정하기</h1>
<form action="PostController.do" method="post">
<table border="1">
<tr>
<th>게시판 이름</th>
<td><input type="text" name="title" value="<%=bdto.getTitle() %>"/></td>
</tr>
<tr>
<th>유형</th>
<%
for(CategoryDto cdto : clist){
	if(clist==null||clist.size()==0){
		%>
		<td>유형이 없습니다.</td>
		<%
	}else{
		%>
		<td><%=cdto.getTitle() %></td>
		<%
	}
}
%>
</tr>
<tr>
<td colspan="2"><input type="submit" value="수정완료"/></td>
</tr>
</table>
</form>
</body>
</html>