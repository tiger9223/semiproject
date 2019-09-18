<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
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
	function regist() {
		location.href = "LoginController.do?command=regist";
	}
	
	window.onload = function() {
		var forms = document.getElementById("forms");//[form]
		//form태그에서 submit이벤트가 발생하면 함수를 실행해라
		forms.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
			if(forms.id.value==""){
				forms.id.focus();
				alert("아이디를 입력하세요");
				return false;
			}else if(forms.password.value==""){
				forms.password.focus();
				alert("패스워드를 입력하세요");
				return false;
			}
		}
	}
</script>
</head>
<body>
<div id="header">
<h1>로그인</h1>
</div>
<form id="forms" action="LoginController.do" method="post">
	<input type="hidden" name="command" value="login">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="id"></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="submit" value="로그인">
			<input type="button" value="회원가입" onclick="regist()">
			</td>
		</tr>
	</table>
</form>
</body>
</html>