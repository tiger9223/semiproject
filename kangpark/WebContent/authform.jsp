<%@page import="com.hk.dtos.LoginDto"%>
<%@include file="header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	table {
    width: 40%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
    display: table;
    margin-left: auto;
    margin-right: auto;
  	}
 	th,td{
    border-bottom: 1px solid #444444;
    padding: 10px;
 	 }
 	 th {
    background-color: DodgerBlue;
    }
    #header{
    display: table;
    margin-left: auto;
    margin-right: auto;
    }
</style>
</head>
<body>
<%
	LoginDto dto = (LoginDto)request.getAttribute("dto");
%>
<div id="header">
<h1>회원등급 변경</h1>
</div>
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