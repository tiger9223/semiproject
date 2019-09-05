......<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idchkform</title>
<script type="text/javascript">
	window.onload = function() {
		//현재 페이지를 열어준 부모페이지
		var id = oppener.document.getElementsBaName("id")[0].value;
		//.문서에서 .name속성의 값이 id인 엘리먼트를 구해서 입력값을 얻어옴
		document.getElementsByName("id")[0].value = id;
	}
	
	function kk(bool) {
		var val=document.getElementsByName("id")[0].value;
		if(bool) {
			opener.document.getElementsByName("name")[0].focus();
			parentPage.setAttribute("class","y");
		}else {
			parentPage.value=""
			parentPage.focus();
		}
		self.close();	//현재 창을 닫음
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
<%-- 	<td><input type="text" name="id" value="<%=dto.getId()==null?"":dto.getId()%>"></td>
 --%>  	<td><input type="text" name="id"></td>	
	</tr>
	<tr>
		<td><%=isS?"사용가능합니다아~":"중복된 아이디입니다아..."%></td>
	</tr>
	<tr>
		<td><input type="button" value="확인" onclick="kk(<%=isS%>)"></td>
	</tr>
</table>
</body>
</html>