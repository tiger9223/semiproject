<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idchkform</title>
<style type="text/css">
	table {
    width: 40%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  	}
 	th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
 	 }
</style>
<script type="text/javascript">
	window.onload = function() {
		//현재 페이지를 열어준 부모페이지
		var id = opener.document.getElementsByName("id")[0].value;
		//.문서에서 .name속성의 값이 id인 엘리먼트를 구해서 입력값을 얻어옴
		document.getElementsByName("id")[0].value = id;
	}
	
	function kk(bool) {
		var parentPage = document.getElementsByName("id")[0];
		if(bool) {
			opener.document.getElementsByName("name")[0].focus();
			opener.document.getElementsByName("id")[0].setAttribute("class","y");
		}else {
			parentPage.value=""
			parentPage.focus();
		}
		self.close(); //현재 창을 닫음
	}
</script>
</head>
<body>
<%
	LoginDto dto = (LoginDto)request.getAttribute("dto");
	boolean isS = false;
	if(dto==null || dto.getId()==null) { //사용 가능하다면...
		isS = true;
	}
%>
<table border="1">
	<tr>
		<td><input type="text" name="id" /></td>
	</tr>
	<tr>
		<td><%=isS?"이 아이디는 사용가능합니다.":"중복된 아이디입니다."%></td>
	</tr>
	<tr>
		<td><input type="button" value="확인" onclick="kk(<%=isS%>)" /></td>
	</tr>
</table>
</body>
</html>