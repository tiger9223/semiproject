<%@page import="com.hk.dtos.PostDto"%>
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
<script type="text/javascript" src="http://code.jquery.com"/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	$("form").submit(function(){
		var bool=true;
		//[input,input,textarea]
		var inputs=$(this).find("td").children().filter("[name]");
		inputs.each(function(){
			if($(this).val()==""){
				alert($(this).parent().prev().text()+"를 입력하세요");
				$(this).focus();
				bool=false;
				return false;
			}
		});
		return bool;
	});
})
</script>
<%
	PostDto pdto = (PostDto)request.getAttribute("pdto");
%>
</head>
<body>
<div id="header">
<h1>게시글 수정하기</h1>
</div>
<form action="HomeController.do" method="post">
<input type="hidden" name="command" value="UpdatePost"/>
<input type="hidden" name="PostSeq" value="<%=pdto.getSeq()%>">
<input type="hidden" name="MemberSeq" value="<%=pdto.getMember_seq()%>"/>
<input type="hidden" name="boardseq" value="<%=pdto.getBoard_seq()%>"/>
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
		<td><textarea rows="10" cols="60" name="content"><%=pdto.getContent() %></textarea></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정완료"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>
















