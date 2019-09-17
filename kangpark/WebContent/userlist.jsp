<%@page import="com.hk.util.Util"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="java.util.List"%>
<%@include file="ad_header.jsp" %>
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
    width: 50%;
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
	List<LoginDto> list = (List<LoginDto>)request.getAttribute("list");
%>
<h1>회원 리스트 조회</h1>
<table border="1">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>등급</th>
		<th>가입일</th>
	</tr>
	<%
		for(LoginDto dto:list) {
			%>
			<tr>
				<td><%=dto.getSeq()%></td>
				<td><%=dto.getId()%></td>
				<td><%=dto.getName()%></td>
				<td>
					<%=dto.getRole()%>
					<button onclick="auth(<%=dto.getSeq()%>)">변경</button>
				</td>
				<td><%=Util.getToDate(dto.getRegdate())%></td>
			</tr>
			<%
		}
	%>
</table>
<script type="text/javascript">
	function auth(seq) {
		//등급변경 폼으로 이동
		location.href="LoginController.do?command=roleForm&seq="+seq;
	}
</script>
</body>
</html>