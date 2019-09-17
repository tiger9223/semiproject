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
<input type="hidden" name="command" value="boardInsertForm"/>
<input type="hidden" name="boardSeq" value="<%=bdto.getSeq()%>"/>
<table border="1">
<tr>
<th>게시판 이름</th>
<td><input type="text" name="title" value="<%=bdto.getTitle() %>"/></td>
</tr>
<%
	if(clist==null || clist.size()==0){
		%>
		<tr>
		<th>유형</th>
		<td>유형이 없습니다.</td>
		</tr>
		<%
	}else{
	for(CategoryDto cdto : clist){
		%>
<tr>
	<th>유형</th>
	<td><a href="PostController.do?command=updatecategoryform&categoryseq=<%=cdto.getSeq()%>"><%=cdto.getTitle() %></a></td>
</tr>
		<%
	}
}
%>
<tr>
<td colspan="2">
<input type="submit" value="수정완료"/>
<input type="button" value="유형추가"
		onclick="location.href = 'PostController.do?command=insertCategoryForm&boardSeq=<%=bdto.getSeq()%>'"/>
</td>
</tr>
</table>
</form>
</body>
</html>