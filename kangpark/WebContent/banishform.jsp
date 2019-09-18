<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.daos.BoardDao"%>
<%@page import="com.hk.util.Util"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강제 탈퇴</title>
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
</head>
<%
	LoginDto dto = (LoginDto)request.getAttribute("dto");
	BoardDao bdao = new BoardDao();
	List<BoardDto> list = bdao.getBoardList();
	request.setAttribute("list", list);
%>
<body>
<div id="header">
<h1>강제 탈퇴</h1>
</div>
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
			<button onclick="banish('<%=dto.getId()%>')">강제 추방</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="restore('<%=dto.getId()%>')">탈퇴 복원</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
</table>
<script type="text/javascript">
function banish(id){
	if(confirm("정말 추방하시겠습니까?")==true){
		location.href = "LoginController.do?command=withdraw&id="+id;
	}
}
function restore(id){
	if(confirm("정말 복원하시겠습니까?")==true){
		location.href = "LoginController.do?command=restore&id="+id;
	}
}
</script>
</body>
</html>