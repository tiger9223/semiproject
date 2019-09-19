<%@page import="com.hk.dtos.CategoryDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@include file="header.jsp"%>
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
<script type="text/javascript">
window.onload = function() {
	var forms = document.getElementById("forms");//[form]
	//form태그에서 submit이벤트가 발생하면 함수를 실행해라
	forms.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
		if(forms.title.value==""){
			forms.title.focus();
			alert("게시판 이름을 입력하세요");
			return false;
		}
	}
}
</script>
<%
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
	List<CategoryDto> clist = (List<CategoryDto>)request.getAttribute("clist");
%>
</head>
<body>
<div id="header">
<h1>게시판 수정하기</h1>
</div>
<form id="forms" action="PostController.do" method="post">
<input type="hidden" name="command" value="boardInsertForm"/>
<input type="hidden" name="boardSeq" value="<%=bdto.getSeq()%>"/>
<table border="1">
<tr>
<th>게시판 이름</th>
<td><input type="text" name="title" value="<%=bdto.getTitle() %>"/></td>
</tr>
<%
	if(clist==null || clist.size()==0){
		%>
		<tr>
		<th>유형</th>
		<td>등록된 유형이 없습니다.</td>
		</tr>
		<%
	}else{
	for(CategoryDto cdto : clist){
		%>
<tr>
	<th>유형</th>
	<td><a href="PostController.do?command=updatecategoryform&categoryseq=<%=cdto.getSeq()%>"><%=cdto.getTitle() %></a></td>
</tr>
		<%
	}
}
%>
<tr>
<td colspan="2">
<input type="submit" value="수정완료"/>
<input type="button" value="유형추가"
		onclick="location.href = 'PostController.do?command=insertCategoryForm&boardSeq=<%=bdto.getSeq()%>'"/>
</td>
</tr>
</table>
</form>
</body>
</html>