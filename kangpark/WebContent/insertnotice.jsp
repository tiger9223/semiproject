<%@page import="com.hk.dtos.CategoryDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
    BoardDto bdto = (BoardDto)request.getAttribute("bdto");
	CategoryDto cdto = (CategoryDto)request.getAttribute("cdto");
%>
<script type="text/javascript">
	function back(boardseq){
		if(confirm("글 작성 중에 있습니다. 목록으로 가시면 작성 중인 글은 삭제됩니다.")==true){
			location.href="HomeController.do?command=notice";
		}
	}
	window.onload = function(){
		var forms = document.getElementById("forms");
		forms.onsubmit = function(){
			if(forms.title.value==""){
				forms.content.focus();
				alert("내용을 입력하세요");
				return false;
			}
		} 	
	}
</script>
</head>
<body>
<h1>게시글 추가하기</h1>
<form id="forms" action="HomeController.do" method="post" >
<input type="hidden" name="command" value="InsertNoticePost"/>
<input type="hidden" name="boardSeq" value="<%=bdto.getSeq() %>"/>
<input type="hidden" name="memberSeq" value="<%=ldto.getSeq() %>"/>
<table border="1">
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" readonly="readonly" value="<%=ldto.getId()%>"/></td>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="title" />
				<select name="categorySeq">
				<option value="<%=cdto.getSeq()%>"><%=cdto.getTitle() %></option>
				</select>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content" ></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="글등록"/>
			<input type="button" value="글목록보기" onclick="back(<%=bdto.getSeq()%>)">
		</td>
	</tr>
</table>
</form>
</body>
</html>
