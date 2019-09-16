<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%
	List<BoardDto> blist = (List<BoardDto>)request.getAttribute("blist");
%>
</head>
<body>
<h1>게시판 목록</h1>
<form action="PostController.do" method="post">
<table border="1">
<% for(BoardDto bdto: blist){
	%>
<% 
	if(blist == null || blist.size()==0){%>
<tr>
	<td>등록된 게시판이 없습니다.</td>
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
	
</table>
</form>
</body>
</html>