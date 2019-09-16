<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h1>게시판 추가하기</h1>
<form action="PostController.do" method="post">
<input type="hidden" name="command" value="InsertBoard"/>
<table border="1">
	<tr>
		<th>게시판 이름</th>
		<td><input type="text" name="board"/>예시)**게시판</td>
	</tr>
	<tr>
		<th>카테고리 유형</th>
		<td><input type="text" name="category"/></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="등록"/></td>
	</tr>
</table>
</form>
</body>
</html>