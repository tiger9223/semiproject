<%@page import="com.hk.util.Util"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
	LoginDto dto = (LoginDto)request.getAttribute("dto");
%>
</head>
<body>
<div id="header">
<h1>나의 정보 수정하기</h1>
</div>
<form action="LoginController.do" method="post">
<input type="hidden" name="command" value="updateUserInfo" /> 
<input type="hidden" name="id" value="<%=dto.getId()%>" />
<input type="hidden" name="seq" value="<%=dto.getSeq()%>" />
<table border="1">
	<tr>
	    <th>회원번호</th>
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
	    <th>주소</th>
	    <td><input type="text" name="address"
				value="<%=dto.getAddress()%>" /></td>
	</tr>
	<tr>
	    <th>전화번호</th>
	    <td><input type="tel" name="phone" value="<%=dto.getPhone()%>" /></td>
	</tr>
	<tr>
	    <th>이메일</th>
	    <td><input type="email" name="email"
				value="<%=dto.getEmail()%>" /></td>
	</tr>
	<tr>
	    <th>가입일</th>
	    <td><%=Util.getToDate(dto.getRegdate())%></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="수정완료" /></td>
	</tr>
</table>
</form>
</body>
</html>