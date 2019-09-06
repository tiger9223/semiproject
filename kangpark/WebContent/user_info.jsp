<%@page import="com.hk.util.Util"%>
<%@include file="us_header.jsp"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보 조회</title>
</head>
<%
	LoginDto dto = (LoginDto)request.getAttribute("dto");
%>
<body>
<h1>나의 정보 조회</h1>
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
	    <td><%=dto.getAddress()%></td>
	</tr>
	<tr>
	    <th>전화번호</th>
	    <td><%=dto.getPhone()%></td>
	</tr>
	<tr>
	    <th>이메일</th>
	    <td><%=dto.getEmail()%></td>
	</tr>
	<tr>
	    <th>가입일</th>
	    <td><%=Util.getToDate(dto.getRegdate())%></td>
	</tr>
	<tr>
		<td colspan="2">
			<button onclick="update(<%=dto.getSeq()%>)">수정</button>
			<button onclick="withdraw('<%=dto.getId()%>')">탈퇴</button>
		</td>
	</tr>
</table>
<script type="text/javascript">
	function update(seq){
		location.href = "LoginController.do?command=userUpdate&seq="+seq;
	}
	
	function withdraw(id){
		if(confirm("정말 탈퇴하시겠습니까?")==true){
			location.href = "LoginController.do?command=withdraw&id="+id;
		}
	}
</script>
</body>
</html>