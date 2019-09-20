<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<style type="text/css">
	#header{
		text-align:center;
	}
	#body{
		width: 300px;
        padding: 20px;
        padding-left: 15px;
        margin-bottom: 20px;
        text-align:center;
        display: table;
        margin-left: auto;
        margin-right: auto;
	}
</style>
</script>
</head>
<body>
<div id="header">
<h1>회원가입</h1>
</div>
<div id="body">
        <ul>												<!-- ldto에 로그인 정보가 있으니까.. -->
			<li><a href="LoginController.do?command=userregist">일반 회원가입</a></li>
		</ul>
		<ul>												
			<li><a href="LoginController.do?command=adminregist">관리자 회원가입</a></li>
		</ul>
</div> 
<%@include file="footer.jsp"%>
</body>
</html>