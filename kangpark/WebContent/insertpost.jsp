<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@page import="com.hk.dtos.CategoryDto"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
	List<CategoryDto> list = (List<CategoryDto>)request.getAttribute("list");
%>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

	function back(boardseq){
		if(confirm("글 작성 중에 있습니다. 목록으로 가시면 작성 중인 글은 삭제됩니다.")==true){
			location.herf="PostController.do?command=Postlist&boardseq="+boardseq;
		}
	}
	
	window.onload = function() {
		var form = document.getElementsByTagName("form")[0];//[form]
		//form태그에서 submit이벤트가 발생하면 함수를 실행해라
		form.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
			var inputs = document.querySelectorAll("table input");//[input,input....]
			
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
 	//탐색메서드: eq(),find(),prev(), next(), children(),parent()
//	$(function(){
// 		$("form").submit(function() {
// 			var bool=true;
// 			//[input,input,textarea]
// 			$(this).find(".inputval").each(function(i){
// 				if($(this).val()==""){
// 					    //input -> td    -> th  -> text
// 					alert($(this).parent().prev().text()+"를 입력하세요");
// 					$(this).focus();
// 					bool=false;
// 					return false;
// 				}
// 			});
// 			return bool;
// 		});
		

//		$("form").submit(function(){
//			var bool=true;
//			//[input,input,textarea]
//			var inputs=$(this).find("td").children().filter("[name]");
//			inputs.each(function(){
//				if($(this).val()==""){
//					alert($(this).parent().prev().text()+"를 입력하세요");
//					$(this).focus();
//					bool=false;
//					return false;
//				}
//			});
//			return bool;
//		});

//	})
</script>
</head>
<body>
<h1>게시글 추가하기</h1>
<form action="PostController.do" method="post" >
<input type="hidden" name="command" value="InsertPost"/>
<input type="hidden" name="boardSeq" value="<%=bdto.getSeq() %>"/>
<input type="hidden" name="memberSeq" value="<%=ldto.getSeq() %>"/>
<table border="1">
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" class="inputval" readonly="readonly" value="<%=ldto.getId()%>"/></td>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="title" class="inputval"/>
				<select name="category">
				<%
				for(CategoryDto cdto:list){
					%>
				<option value="<%=cdto.getSeq()%>"><%=cdto.getTitle() %></option>
				<%
				}
				%>
				</select>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content" class="inputval"></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="글등록"/>
			<input type="button" value="뒤로가기" onclick="back(<%=bdto.getSeq()%>)">
		</td>
	</tr>
</table>
</form>
</body>
</html>











