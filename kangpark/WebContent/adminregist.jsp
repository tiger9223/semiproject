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
	table {
    width: 40%;
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
	//사용한 이벤트 : onload, onsubmit
	//submit이벤트 취소하는 방법 : return false;
	//DOM의 개념 : 탐색하는 메소드 - getElementsByTagName(), querySelectorAll(), parentNode .....
	//input태그의 입력값을 구하는 방법 : input.value
	//현재 페이지가 로딩되면 함수를 실행한다.
	window.onload = function() {
		var form = document.getElementsByTagName("form")[0];//[form]
		//form태그에서 submit이벤트가 발생하면 함수를 실행해라
		form.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
			var inputs = document.querySelectorAll("table input");//[input,input....]
			
			if(inputs[3].value!=inputs[4].value) {	//유효하지 않을 값이 존재하면 submit전송 기능 취소해야한다
				alert("패스워드를 확인하세요.");
				inputs[3].vlaue="";
				inputs[4].value="";
				inputs[3].focus();
				return false;	//이게 없으면 잘못입력했다고 경고가 떠도 값을 전송해버림
								//유효하지 않은 값이 존재하면 submit 전송기능 취소해야 한다.
			}else {
				for (var i = 0; i < inputs.length; i++) {
					if(inputs[i].value=="") {
						var tagEleTxt = inputs[i].parentNode.previousElementSibling.textContent;
						//						 .부모태그 구함 .앞에오는 형제엘리먼트 구함      .내부에 text 구함 
						alert(tagEleTxt+"를 입력하세요.");
						inputs[i].focus();
						return false;
					}
				}
			}
		}
	}
	//아이디 중복체크
	function idChk() {
		var id = document.getElementsByName("id")[0].value;//
		if(id==null){
			alert("아이디를 입력하세요.");
			return false;
		}else{
		//"open(url", "title", "창의 속성설정")
		window.open("LoginController.do?command=idChk&id="+id,"",
					"width=300px, height=300px");
		}
	}
	//뒤로가기
	function back(){
		if(confirm("회원가입 중에 있습니다. 뒤로 가시면 작성 중인 내용은 삭제됩니다.")==true){
			location.href="LoginController.do?command=logout"
		}
	}
</script>
</head>
<body>
<div id="header">
<h1>관리자 회원가입</h1>
</div>
<form action="LoginController.do" method="post">
<input type="hidden" name="command" value="insertadmin">
<table border="1">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" name="id" class="n">
			<input type="button" value="중복체크" onclick="idChk()">
		</td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<th>패스워드</th>
		<td><input type="password" name="password"></td>
	</tr>
	<tr>
		<th>패스워드 확인</th>
		<td><input type="password" name="password2"></td>
	</tr>
	<tr>
		<th>주소</th>
		<td><input type="text" name="address"></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><input type="tel" name="phone" placeholder="010-0000-0000" ></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><input type="email" name="email" placeholder="예)abc@xxxxx.com"></td>
	</tr>
	<tr>
		<td colspan="2">
		<input type="submit" name="가입완료" value="완료"/>
		<input type="button" value="뒤로가기" onclick="back()">
		</td>
	</tr>
</table>
</form>
</body>
<%@include file="footer.jsp"%>
</html>