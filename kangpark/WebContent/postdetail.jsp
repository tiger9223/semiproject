<%@page import="com.hk.dtos.CategoryDto"%>
<%@page import="java.util.List"%>
<%@page import="com.hk.dtos.PostDto"%>
<%@page import="com.hk.dtos.LoginDto"%>
<%@page import="com.hk.dtos.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
	/*  selector표현식의 대표적인 표현식3가지: id,> class,> tagName
		class="a"  ---> .a   (같은이름을 중복해서 선언할 수 있다.)
		id="b"     ---> #b   (같은 이름 중복을 선언할 수 없다.)
	*/
	#replyForm{display: none;}
	#container{
/* 		text-align: center; */
		height: 800px;
		width: 1500px;
		overflow: auto;
	}
 	table {
    text-align: left;
    line-height: 1.5;
    margin : 20px 10px;
    display: inline-block;
    width: 40%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  	}
 	th,td{
    border-bottom: 1px solid #444444;
    padding: 10px;
    text-align: center;
 	}
</style>
</head>
<body>
<%
	BoardDto bdto = (BoardDto)request.getAttribute("bdto");
 	PostDto pdto = (PostDto)request.getAttribute("pdto");
	LoginDto ldto = (LoginDto)session.getAttribute("ldto");
	LoginDto dto = (LoginDto)request.getAttribute("dto");
	CategoryDto cdto = (CategoryDto)request.getAttribute("cdto");
%>
<div id="container">
<h1>게시글상세보기</h1>
<table class="bodyTable" border="1">
	<tr>
		<th>번호</th>
		<td><%=pdto.getSeq() %></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><%=dto.getId() %></td>
	</tr>
	<tr>
		<th>제목</th>
		<td>[<%=pdto.getCategory_title() %>]&nbsp;<%=pdto.getTitle() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" readonly="readonly"><%=pdto.getContent() %></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<button onclick="replyForm()">답글달기</button>
			<%if(ldto.getId().equals(dto.getId())){
				%>
			<button onclick="location.href = 'PostController.do?command=UpdateForm&PostSeq=<%=pdto.getSeq()%>&MemberSeq=<%=pdto.getMember_seq()%>'">수정</button>
			<button onclick="location.href = 'PostController.do?command=DeletePost&PostSeq=<%=pdto.getSeq()%>'">삭제</button>
			<% 
			}%>
			<button onclick="location.href='PostController.do?command=PostList&boardseq=<%=bdto.getSeq()%>'">글목록</button>
		</td>
	</tr>
</table>
<div id="replyForm">
<h1>답글</h1>
<form id="forms" action="PostController.do" method="post" >
<input type="hidden" name="command" value="replyPost"/>
<input type="hidden" name="PostSeq" value="<%=pdto.getSeq() %>"/>
<input type="hidden" name="BoardSeq" value="<%=bdto.getSeq() %>"/>
<input type="hidden" name="MemberSeq" value="<%=ldto.getSeq()%>"/>
<input type="hidden" name="CategorySeq" value="<%=pdto.getCategory_seq() %>"/>
<table class="bodyTable" border="1">
	<tr>
		<th>아이디</th>
		<td><input type="text" name="id" value="<%=ldto.getId()%>" readonly="readonly"/></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="60" name="content" ></textarea> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="답글등록"/>
		</td>
	</tr>
</table>
</form>
</div>
</div>
<script type="text/javascript">
	function replyForm(){
// 		$("#replyForm").css("display","block");
// 		$("#replyForm").toggle();
		$("#replyForm").show();
		var replyPosition=$("#replyForm").offset().top;//div태그의 상단 위치를 구함
		$("#container").animate({
			"scrollTop":replyPosition
		},500);
		//animate({css속성값정의},지연시간,easing)
	}
	window.onload = function() {
		var forms = document.getElementById("forms");//[form]
		//form태그에서 submit이벤트가 발생하면 함수를 실행해라
		forms.onsubmit = function() {//패스워드가 정확하게 입력됐는지와 모든 입력값을 넣었는지 확인
			if(forms.title.value==""){
				forms.title.focus();
				alert("제목를 입력하세요");
				return false;
			}else if(forms.content.value==""){
				forms.content.focus();
				alert("내용을 입력하세요");
				return false;
			}
		}
	}
</script>
</body>
</html>









