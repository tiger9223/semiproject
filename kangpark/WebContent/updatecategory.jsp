<%@page import="com.hk.dtos.CategoryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
	table {
    width: 30%;
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
		var forms = document.getElementById("forms");//[form]
		//form태그에서 submit이벤트가 발생하면 함수를 실행해라
		forms.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
			if(forms.title.value==""){
				forms.title.focus();
				alert("유형을 입력하세요");
				return false;
			}
		}
	}
</script>
<%
	CategoryDto cdto = (CategoryDto)request.getAttribute("cdto");
%>
</head>
<body>
<h1>카테고리 수정,삭제하기</h1>
<form id="forms" action="PostController.do" method="post">
<input type="hidden" name="command" value="updatecategory"/>
<input type="hidden" name="categoryseq" value="<%=cdto.getSeq()%>"/>
<table border="1">
<tr>
<th>번호</th>
<td><%=cdto.getSeq() %></td>
</tr>
<tr>
<th>유형</th>
<td><input type="text" name="title" value="<%=cdto.getTitle() %>"/></td>
</tr>
<tr>
<td colspan="2">
<input type="submit" value="수정"/>
<input type="button" value="삭제" onclick="del(<%=cdto.getSeq()%>)"/>		       
</td>
</tr>
</table>
</form>
<script type="text/javascript">
	function del(categoryseq){
		if(confirm("정말 삭제하시겠습니까?")==true){
			location.href = 'PostController.do?command=Deletecategory&categoryseq='+categoryseq;
		}
	}
</script>
</body>
</html>