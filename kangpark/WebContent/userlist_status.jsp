<%@page import="com.hk.util.Util"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="java.util.List"%>
<%@include file = "ad_header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	List<LoginDto> list = (List<LoginDto>)request.getAttribute("list");
%>
<h1>회원정보상태조회</h1>
<table border="1">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>주소</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>탈퇴여부</th>
		<th>회원등급</th>
		<th>가입일</th>
	</tr>
	<%
	if(list==null){
		%>
		<tr>
			<td>가입된 회원이 없습니다.</td>
		</tr>
		<% 
	}else{
		for(LoginDto dto:list) {
			%>
			<tr>
				<td><%=dto.getSeq()%></td>
				<td><%=dto.getId()%></td>
				<td><%=dto.getName()%></td>
				<td><%=dto.getAddress()%></td>
				<td><%=dto.getPhone()%></td>
				<td><%=dto.getEmail()%></td>
				<td><%=dto.getEnabled()%></td>
				<td><%=dto.getRole()%></td>
				<td><%=Util.getToDate(dto.getRegdate())%></td>
			</tr>
			<%
		}
	}
	%>
</table>
</body>
</html>