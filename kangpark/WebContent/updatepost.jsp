<%@page import="com.hk.dtos.PostDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	window.onload = function() {
		var forms = document.getElementById("forms");//[form]
		//form태그에서 submit이벤트가 발생하면 함수를 실행해라
		forms.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
			if(forms.title.value==""){
				forms.title.focus();
				alert("제목을 입력하세요");
				return false;
			}else if(forms.content.value==""){
				forms.content.focus();
				alert("내용을 입력하세요");
				return false;
			}
		}
	}	
</script>
<%
	PostDto pdto = (PostDto)request.getAttribute("pdto");
%>
</head>
<body>
<div id="header">
<h1>게시글수정하기</h1>
</div>
<form id="forms" action="PostController.do" method="post">
<input type="hidden" name="command" value="UpdatePost"/>
<input type="hidden" name="PostSeq" value="<%=pdto.getSeq()%>"/>
<input type="hidden" name="MemberSeq" value="<%=pdto.getMember_seq()%>"/>
<table border="1">
	<tr>
		<th>번호</th>
		<td><%=pdto.getSeq() %></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=pdto.getId() %></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" value="<%=pdto.getTitle()%>"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content" style="background-color:rgb(255,204,255); border-color:rgb(255,204,255);"><%=pdto.getContent() %></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정완료"/>
		</td>
	</tr>
</table>
</form>
<%@include file="footer.jsp"%>
</body>
</html>