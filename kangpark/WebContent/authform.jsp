<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="ad_header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	table {
    width: 20%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  	}
 	th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
 	 }
</style>
</head>
<body>
<%
	LoginDto dto = (LoginDto)request.getAttribute("dto");
%>
<h1>등급 변경</h1>
<form action="LoginController.do" method="post">
<input type="hidden" name="command" value="authchange" >
<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
<table border="1">
	<tr>
		<th>번호</th>
		<td><%=dto.getSeq()%></td>
	</tr>
	<tr>
		<th>아이디</th>
		<td><%=dto.getId()%></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><%=dto.getName()%></td>
	</tr>
	<tr>
		<th>등급</th>
		<td>
			<select name="role">
				<option value="ADMIN" <%=dto.getRole().equals("ADMIN")?"selected":""%>>관리자</option>
				<option value="MANAGER" <%=dto.getRole().equals("MANAGER")?"selected":""%>>정회원</option>
				<option value="USER" <%=dto.getRole().equals("USER")?"selected":""%>>일반회원</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="등급변경">
		</td>
	</tr>
</table>
</form>
</body>
</html>