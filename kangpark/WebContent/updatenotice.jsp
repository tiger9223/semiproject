<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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

</head>
<body>
/
</body>
</html>