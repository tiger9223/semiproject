<%@include file = "ad_header.jsp"%>
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
			if(forms.board.value==""){
				forms.board.focus();
				alert("게시판 이름를 입력하세요");
				return false;
			}
		}
	}
</script>
</head>
<body>
<div id="header">
<h1>게시판 추가하기</h1>
</div>
<form id="forms" action="PostController.do" method="post">
<input type="hidden" name="command" value="InsertBoard"/>
<table border="1">
	<tr>
		<th>게시판 이름</th>
		<td><input type="text" name="board"/>예시)**게시판</td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="등록"/></td>
	</tr>
</table>
</form>
</body>
</html>